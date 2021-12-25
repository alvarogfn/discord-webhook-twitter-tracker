import 'dart:convert';
import 'dart:math';

class DiscordEmbed {
  final String description;
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

  late List attachments = [
    {}
  ];

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
