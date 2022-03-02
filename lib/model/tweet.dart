class Tweet {
  final List _data;
  Map? _includes;

  Tweet({data, includes}) : _data = data {
    _includes = includes;
  }

  String get text {
    String text = _data[0]['text'];
    try {
      if ((_includes?['media'][0]['type'] != "photo")) {
        return text.replaceAll(text.substring(text.lastIndexOf('https')), '');
      } else {
        return text;
      }
    } on RangeError catch (_) {
      return text;
    } on NoSuchMethodError catch (_) {
      return text;
    }
  }

  String? get profilePic {
    try {
      return _includes?['users'][0]['profile_image_url'];
    } catch (_) {
      return null;
    }
  }

  String? get id {
    try {
      return _data[0]['id'];
    } catch (_) {
      return null;
    }
  }

  String? get username {
    try {
      return _includes?['users'][0]['username'];
    } catch (_) {
      return null;
    }
  }

  String? get name {
    try {
      return _includes?['users'][0]['name'];
    } catch (_) {
      return null;
    }
  }

  String? get url {
    if (id != null && username != null) {
      return "https://twitter.com/$username/status/$id";
    } else {
      return null;
    }
  }

  String? get createdAt {
    try {
      return _data[0]['created_at'];
    } catch (_) {
      return null;
    }
  }

  String? get media {
    try {
      if (_includes?['media'][0]['type'] != "photo") {
        return _includes?['media'][0]['preview_image_url'];
      }
      return _includes?['media'][0]['url'];
    } catch (_) {
      return null;
    }
  }

  List<Map?> get conversationList {
    if (_includes?["tweets"] == null) return [];
    if (_includes?["users"] == null) return [];

    final List referencedTweets = _data[0]["referenced_tweets"] ?? [];

    List<Map<String, String>> tweetsReferences = [];

    for (var reference in referencedTweets) {
      var content = _includes?["tweets"]
          .firstWhere((t) => t["id"] == reference["id"], orElse: () => null);

      var users = _includes?["users"];
      var user = users.firstWhere((u) => u["id"] == content["author_id"],
          orElse: () => "");

      if (user is Map) {
        user = "${user['name']} (@${user['username']})";
      }

      String labelName;
      if (reference["type"] == "quoted") {
        labelName = "Citando $user:";
      } else {
        labelName = "Respondendo $user:";
      }

      tweetsReferences.add({"value": content["text"], "name": labelName});
    }

    // print(tweetsReferences);

    return tweetsReferences;
  }

  Map? get tweet {
    return {
      'text': text,
      'profilePic': profilePic,
      'username': username,
      'name': name,
      'url': url,
      'createdAt': createdAt,
      'media': media,
    };
  }
}
