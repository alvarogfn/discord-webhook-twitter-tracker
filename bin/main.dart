import 'dart:convert';
import 'dart:io';
import 'package:dotenv/dotenv.dart' show load, clean, isEveryDefined, env;
import 'package:http/http.dart' as http;

main(List<String> parameters) {
  load();
  String discordWebHook = env['WEBHOOK']!;
  String twitterBearer = env['TWITTER_BEARER_TOKEN']!;

  // http.post(
  //   Uri.parse(discordWebHook),
  //   headers: {'Content-Type': 'application/json'},
  //   body: json.encode({
  //     'content': 'oi',
  //     'username': 'teste2',
  //     'avatar_url': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Bra-Cos_%281%29_%28cropped%29.jpg'
  //   }),
  // );

  // http.get(
  //   Uri.parse(
  //       "https://api.twitter.com/2/tweets/search/recent?query=from:twitterdev"),
  //   headers: {
  //     'Authorization': 'Bearer $twitterBearer',
  //   },
  // ).then((r) => print(r.body));
}
