import 'package:dio/dio.dart';
import 'package:symmetrical_broccoli/model/discord_embed.dart';
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

  Future<int?> postEmbed({required List<DiscordEmbed> embeds}) async {
    List<Map> embedsList = embeds.map((embed) {
      return embed.content;
    }).toList();

    try {
      final response = await Dio().post(
        webhook,
        data: {
          'username': 'Preciso de um nome',
          'avatar_url':
              'https://upload.wikimedia.org/wikipedia/en/thumb/e/ed/Nyan_cat_250px_frame.PNG/220px-Nyan_cat_250px_frame.PNG',
          'embeds': embedsList,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      return response.statusCode;
    } on DioError catch (e) {
      return e.response?.statusCode;
    } catch (e) {
      return 0;
    }
  }
}
