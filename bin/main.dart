import 'dart:convert';
import 'dart:io';

import 'package:dotenv/dotenv.dart' show load, env;
import 'package:symmetrical_broccoli/controller/discord.dart';
import 'package:symmetrical_broccoli/controller/twitter.dart';
import 'package:symmetrical_broccoli/model/discord_embed.dart';
import 'package:symmetrical_broccoli/model/tweet.dart';

main(List<String> parameters) async {
  load();
  String webhook = env['WEBHOOK']!;
  String twitterBearToken = env['TWITTER_BEARER_TOKEN']!;

  Twitter twitter = Twitter(bearerToken: twitterBearToken);

  List map = json.decode(env['RULES']!);
  print(map);

  List<Map<String, String>> rules = [
    // {
    //   "value":
    //       "-is:retweet ((from:kimkataguiri OR (from:kimkataguiri to:kimkataguiri)) OR (from: renansantosmbl OR (from:renansantosmbl to:renansantosmbl)) OR (from:arthurmodeloval (from:arthurmoledoval to:arthurmoledoval)) OR (from:ricardo_mbl OR (from:ricardo_mbl to:ricardo_mbl)) OR (from:rubensnunesmbl OR (from:rubensnunesmbl to:rubensnunesmbl)))"
    // },
    // {
    //   "value":
    //       "-is:retweet ((from:Amandavettorazz OR (from:Amandavettorazz to:Amandavettorazz)) (from:GutoZacariasMBL OR (from:GutoZacariasMBL to:GutoZacariasMBL)) (from:WarlenMBL OR (from:WarlenMBL to:WarlenMBL)))"
    // },
    // {"value": "from:MBLivre OR (from:MBLivre to:MBLivre)"},
    // {
    //   "value":
    //       "-is:retweet -is:reply (from:cwingert OR from:lochbyytt OR from:cristalescuite OR from:nephartoth OR from:luda_ve_luda)"
    // },
    // {
    //   "value":
    //       "-is:retweet (from:socialistaancap OR (from:socialistaancap to:socialistaancap))"
    // }
    {"value": "-is:retweet (ancap OR sonegar OR sonegação OR imposto) lang:pt"}
  ];

  Map<String, dynamic> parameters = {
    "expansions": "author_id,attachments.media_keys",
    "user.fields": "username,profile_image_url",
    "tweet.fields": "created_at,attachments,author_id,entities,id,text",
    "media.fields": "media_key,preview_image_url,url",
  };

  // Map actualRules = await twitter.getStreamRules();
  // sleep(Duration(milliseconds: 2500));
  // if (actualRules.isNotEmpty) {
  //   sleep(Duration(milliseconds: 2500));
  //   await twitter.deleteStreamRules(rulesId: actualRules);
  // }
  // await twitter.postStreamRules(rules: rules);
  // sleep(Duration(milliseconds: 2500));

  // twitter.stream(parameters: parameters).listen((tweet) async {
  //   if (tweet != null) {
  //     DiscordEmbed embed = DiscordEmbed(
  //       description: tweet.text,
  //       url: tweet.url,
  //       createAt: tweet.createdAt,
  //       authorName: "${tweet.name}(@${tweet.username})",
  //       authorIconUrl: tweet.profilePic,
  //       footerIconUrl: "https://i.imgur.com/WZivM7y.png",
  //       imageUrl: tweet.media,
  //       footerText: tweet.url,
  //     );
  //     var discordResponse =
  //         await Discord(webhook: webhook).postEmbed(embeds: [embed]);
  //     print(">$discordResponse");
  //   } else {
  //     print("/");
  //   }
  // }).onError((err) {
  //   print("Err: $err");
  // });
}
