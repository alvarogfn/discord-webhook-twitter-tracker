import 'dart:convert';
import 'dart:math';

import 'package:discord_webhook_twitter_tracker/model/tweet.dart';

class DiscordEmbed {
  late String description;
  final int color = (Random().nextDouble() * 0xFFFFFF).toInt();
  String url = "";
  String timestamp = DateTime.now().toUtc().toIso8601String();
  Map author = {
    "name": "",
    "icon_url": "",
  };
  late Map image = {
    "url": "",
    "height": 1200,
    "width": 1200,
  };
  late Map footer = {
    "text": "",
    "icon_url": "",
  };
  late Map provider = {
    "name": "alvarogfn",
    "url": "https://github.com/alvarogfn",
  };

  late Map video = {
    "url": "",
  };

  late List attachments = [{}];

  DiscordEmbed({
    required this.description,
    String? url,
    String? createAt,
    String? authorName,
    String? authorIconUrl,
    String? imageUrl,
    String? footerText,
    String? footerIconUrl,
    String? videoUrl,
  }) {
    url = url ?? "";
    timestamp = DateTime.parse(createAt ?? timestamp).toUtc().toIso8601String();

    author['name'] = authorName ?? "";
    author['icon_url'] = authorIconUrl ?? "";

    image['url'] = imageUrl ?? "";

    footer['text'] = footerText ?? "";
    footer['icon_url'] = footerIconUrl ?? "";

    video['url'] = videoUrl ?? "";
  }

  DiscordEmbed.fromTweet(Tweet tweet) {
    description = tweet.text;
    url = tweet.url ?? "";
    timestamp = tweet.createdAt ?? "";
    if (tweet.name != null && tweet.username != null) {
      author['name'] = "${tweet.name}(@${tweet.username})";
    } else {
      author['name'] = "undefined";
    }
    author['icon_url'] = tweet.profilePic;
    image['url'] = tweet.media;
    footer['text'] = tweet.url;
    footer['icon_url'] = "https://i.imgur.com/WZivM7y.png";
  }

  @override
  String toString() {
    return json.encode({
      "description": description,
      "color": color,
      "url": url,
      "timestamp": timestamp,
      "author": author,
      "image": image,
      "footer": footer,
      "provider": provider,
    });
  }

  Map get content {
    return {
      "description": description,
      "color": color,
      "url": url,
      "timestamp": timestamp,
      "author": author,
      "image": image,
      "video": video,
      "footer": footer,
      "provider": provider,
      "attachments": attachments
    };
  }
}
