import 'dart:convert';
import 'dart:math';
import 'package:discord_webhook_twitter_tracker/model/tweet.dart';

class DiscordEmbed {
  late String description;
  late String title;
  final int color = (Random().nextDouble() * 0xFFFFFF).toInt();
  String url = "";
  String timestamp = DateTime.now().toUtc().toIso8601String();
  late Map author = {
    "name": "",
    "icon_url": "",
    "url": "",
  };
  late Map thumbnail = {
    "url": "",
    "height": 350,
    "width": 350,
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
    String? title,
    String? url,
    String? createAt,
    String? authorName,
    String? authorIconUrl,
    String? authorUrl,
    String? thumbnailUrl,
    String? imageUrl,
    String? footerText,
    String? footerIconUrl,
    String? videoUrl,
  }) {
    url = url ?? "";
    title = title ?? "";
    timestamp = DateTime.parse(createAt ?? timestamp).toUtc().toIso8601String();

    author['name'] = authorName ?? "";
    author['icon_url'] = authorIconUrl ?? "";
    author['url'] = authorUrl ?? "";

    thumbnail['url'] = thumbnailUrl ?? "";

    image['url'] = imageUrl ?? "";

    footer['text'] = footerText ?? "";
    footer['icon_url'] = footerIconUrl ?? "";

    video['url'] = videoUrl ?? "";
  }

  DiscordEmbed.fromTweet(Tweet tweet) {
    description = tweet.text;
    title = "VER NO TWITTER";
    url = tweet.url ?? "";
    timestamp = tweet.createdAt ?? "";
    author['name'] = tweet.username;
    author['icon_url'] = tweet.profilePic;
    author['url'] = "https://twitter.com/${tweet.username}";
    image['url'] = tweet.media;
    thumbnail['url'] = tweet.profilePic;
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
      "title": title,
      "color": color,
      "url": url,
      // "thumbnail": thumbnail,
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
