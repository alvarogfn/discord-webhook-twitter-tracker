import 'dart:convert';

import 'package:dotenv/dotenv.dart' show load, env, isEveryDefined;
import 'package:discord_webhook_twitter_tracker/controller/discord.dart';
import 'package:discord_webhook_twitter_tracker/controller/twitter.dart';
import 'package:discord_webhook_twitter_tracker/model/discord_embed.dart';

main(List<String> parameters) async {
  load();
  if (!isEveryDefined(['WEBHOOK', 'TWITTER_BEARER_TOKEN'])) {
    throw Error();
  }

  String webhook = env['WEBHOOK']!;
  String twitterBearToken = env['TWITTER_BEARER_TOKEN']!;

  List<Map> rules = [];

  try {
    rules = [...json.decode(env['RULES']!)];
  } catch (_) {
    rules = [{}]; // set your rules here in code or in .env
  }

  Twitter twitter = Twitter(bearerToken: twitterBearToken);
  Discord discord = Discord(webhook: webhook);

  Map? actualRules = await twitter.getStreamRules();
  if (actualRules != null && actualRules.isNotEmpty) {
    await twitter.deleteStreamRules(rulesId: actualRules);
  }
  await twitter.postStreamRules(rules: rules);

  twitter.stream().listen((tweet) async {
    if (tweet != null) {
      DiscordEmbed embed = DiscordEmbed.fromTweet(tweet);
      await embed.translateContent("pt");
      var discordResponse = await discord.postEmbed(embeds: [embed]);
      if (discordResponse == 204) {
        print("🥳");
      } else {
        print("😭");
      }
    } else {
      print("👀");
    }
  }).onError((err) {
    print("Err: $err");
  });
}
