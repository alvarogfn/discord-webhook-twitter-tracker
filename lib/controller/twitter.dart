import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:discord_webhook_twitter_tracker/model/tweet.dart';

class Twitter {
  final String bearerToken;
  late Dio _request;

  Twitter({required this.bearerToken}) {
    _request = Dio(
      BaseOptions(
        baseUrl: "https://api.twitter.com/2/",
        connectTimeout: 20000,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + bearerToken,
        },
      ),
    );
  }

  Future<Map?> getStreamRules() async {
    print("GET: Requesting current stream rules.");
    try {
      final response = await _request.get(
        "tweets/search/stream/rules",
        options: Options(responseType: ResponseType.json),
      );
      print("SUCESS: Rules successfully requested!");
      Map body = response.data;
      if (body['data'] != null) {
        return body = {
          "ids": [...body['data'].map((v) => v['id'])]
        };
      }
    } on DioError catch (e) {
      print("FAILED: can't get rules from the server.");
      if (e.response != null) {
        var error = e.response!.data;
        print(error);
      } else {
        print("without network or url invalid.");
      }
    }
  }

  Future<Map?> deleteStreamRules({required Map rulesId}) async {
    print("POST: Post for delete actual rules.");
    final response = await _request.post(
      "tweets/search/stream/rules",
      data: {"delete": rulesId},
    );

    if (response.statusCode != 200) {
      String error = response.data.body;
      print("FAILED: can't delete rules from the server. \n$error");
    } else {
      print("SUCESS: post for delete actual rules.");
      return {"code": response.statusCode};
    }
  }

  Future<Map?> postStreamRules({required List<Map> rules}) async {
    print("POST: set new rules into the server. \n$rules");
    try {
      final response = await _request.post(
        "tweets/search/stream/rules",
        data: {"add": rules},
      );
      print("SUCESS: set new rules to the server.");
      return {"code": response.statusCode};
    } on DioError catch (e) {
      print("FAILED: can't get rules from the server.");
      if (e.response != null) {
        var error = e.response!.data;
        print(error);
      } else {
        print("without network or url invalid.");
      }
    }
  }

  Stream<Tweet?> stream() async* {
    while (true) {
      print("GET: streaming tweets with rules.");
      try {
        var streamedResponse = await _request.get<ResponseBody>(
          "tweets/search/stream",
          options: Options(
            responseType: ResponseType.stream,
            contentType: "application/json",
          ),
          queryParameters: {
            "expansions": "author_id,attachments.media_keys",
            "user.fields": "username,profile_image_url",
            "tweet.fields": "created_at,attachments,author_id,entities,id,text",
            "media.fields": "media_key,preview_image_url,url",
          },
        );
        await for (var v in streamedResponse.data!.stream) {
          // Future.delayed(Duration(minutes: 15)).whenComplete(() {
          //   _request.close(force: true);
          // });
          try {
            String tweetString = utf8.decode(v);
            Map tweetObject = json.decode(tweetString);
            yield Tweet(
              data: tweetObject['data'],
              includes: tweetObject['includes'],
            );
          } on FormatException catch (_) {
            yield null;
          }
        }
      } on DioError catch (e) {
        int error = e.response!.statusCode!;

        if (error == 401 || error == 400) {
          break;
        }

        int xRateReset =
            int.parse(e.response!.data.headers['x-rate-limit-reset'][0]);
        xRateReset *= 1000;
        xRateReset = DateTime.fromMillisecondsSinceEpoch(xRateReset)
            .millisecondsSinceEpoch;

        int actualTime = DateTime.now().millisecondsSinceEpoch;
        int subtractedTime = xRateReset - actualTime;
        subtractedTime = (((subtractedTime / 1000) + 15) / 60).ceil();

        print("TIMEOUT(${subtractedTime}min): Reconnecting after timeout...");
        sleep(Duration(minutes: subtractedTime));
      } catch (e) {
        _request.close();
        print("ERROR: Something was wrong with the code or network \n\n$e");
        break;
      }
    }
  }

  Stream timeline(String userId) async* {
    while (true) {
      var response = await _request.get(
        "users/$userId/tweets",
        queryParameters: {
          "expansions": "author_id,attachments.media_keys",
          "user.fields": "username,profile_image_url",
          "tweet.fields": "created_at,attachments,author_id,entities,id,text",
          "media.fields": "media_key,preview_image_url,url",
        },
      );
      yield json.decode(response.data.toString());
      sleep(Duration(minutes: 5));
    }
  }

  Future<Map> getTweet({required List<String> tweetsId}) async {
    print("GET: trying get a tweet");
    try {
      final response = await _request.get(
        "tweets?ids=${tweetsId.join(',')}",
        options: Options(responseType: ResponseType.json),
        queryParameters: {
          "expansions": "author_id,attachments.media_keys",
          "user.fields": "username,profile_image_url",
          "tweet.fields": "created_at,attachments,author_id,entities,id,text",
          "media.fields": "media_key,preview_image_url,url",
        },
      );
      return response.data;
    } on DioError catch (e) {
      return {"e": e};
    } catch (e) {
      return {"e": e};
    }
  }
}
