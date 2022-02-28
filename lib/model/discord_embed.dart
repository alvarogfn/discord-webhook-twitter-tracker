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
    "height": 25,
    "width": 25,
  };

  late Map image = {
    "url": "",
  };

  late Map footer = {
    "text": "https://rebrand.ly/kasoke",
    "icon_url": "https://i.imgur.com/UPeHfNR.png",
  };

  late Map provider = {
    "name": "alvarogfn",
    "url": "https://github.com/alvarogfn",
  };

  late Map video = {
    "url": "",
  };

  late List attachments = [{}];

  late List<Map<String, dynamic>> fields = [];

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

    video['url'] = videoUrl ?? "";
  }

  DiscordEmbed.fromTweet(Tweet tweet) {
    description = tweet.text;
    title = "";
    url = tweet.url ?? "";
    timestamp = tweet.createdAt ?? "";
    author['name'] = "${tweet.name} (@${tweet.username})";
    author['icon_url'] = tweet.profilePic;
    author['url'] = "https://twitter.com/${tweet.username}";
    image['url'] = tweet.media;
    thumbnail['url'] = tweet.profilePic;

    if (tweet.url != null) {
      fields.add({"value": url, "name": "Link do Tweet"});
    }
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
      "attachments": attachments,
      "fields": fields
    };
  }

  appendFields(List<Map<String, dynamic>> fieldsList) {
    for (var field in fieldsList) {
      final String? value = field["value"];
      final String? name = field["name"];
      final bool inline = field["inline"] ?? false;

      if (value != null && name != null) {
        fields.insert(0, {"name": name, "value": value, "inline": inline});
      }
    }
  }
}
