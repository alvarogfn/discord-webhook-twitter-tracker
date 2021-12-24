import 'package:dio/dio.dart';
import 'package:symmetrical_broccoli/model/discord_webhook.dart';
import 'package:symmetrical_broccoli/model/tweet.dart';

class Discord {
  final String webhook;

  Discord({required this.webhook});

  postWebHookFromTweet(Tweet tweet) async {
    var discordWebHookModel = DiscordWebhook(
      content: tweet.text,
      username: tweet.username,
      avatarUrl: tweet.profilePic,
    );
    try {
      await Dio().post(
        webhook,
        data: discordWebHookModel.bodyModel,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        print("ERROR: something wrong with ${e.response!.statusCode}");
      } else {
        print("NETWORK: without network or url invalid.");
      }
    }
  }
}
