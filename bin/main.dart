import 'dart:io';

import 'package:dotenv/dotenv.dart' show load, env;
import 'package:symmetrical_broccoli/controller/discord.dart';
import 'package:symmetrical_broccoli/controller/twitter.dart';

main(List<String> parameters) async {
  load();
  String WEBHOOK = env['WEBHOOK']!;
  String TWITTER_BEARER_TOKEN = env['TWITTER_BEARER_TOKEN']!;

  String TWITTER_KEY = env['TWITTER_KEY']!;
  String TWITTER_KEY_SECRET = env['TWITTER_KEY_SECRET']!;

  Twitter twitter = Twitter(bearerToken: TWITTER_BEARER_TOKEN);

  List<Map<String, String>> rules = [
    {
      "value":
          "-is:retweet -is:reply (from:kimkataguiri OR from:socialistaancap OR from:arthurmoledoval)"
    },
    {
      "value":
          "(from:cwingert OR from:lochbyytt OR from:cristalescuite OR from:nephartoth)"
    }
  ];

  Map<String, dynamic> parameters = {
    "expansions": "author_id",
    "user.fields": "username,profile_image_url",
  };

  Map actualRules = await twitter.getStreamRules();
  sleep(Duration(milliseconds: 2500));
  if (actualRules.isNotEmpty) {
    sleep(Duration(milliseconds: 2500));
    await twitter.deleteStreamRules(rulesId: actualRules);
  }
  await twitter.postStreamRules(rules: rules);
  sleep(Duration(milliseconds: 2500));

  twitter.stream(parameters: parameters).listen((tweet) async {
    if (tweet != null) {
      await Discord(webhook: WEBHOOK).postWebHookFromTweet(tweet);
    } else {
      print("/");
    }
  }).onError((err) {
    print("Err: $err");
  });
}
