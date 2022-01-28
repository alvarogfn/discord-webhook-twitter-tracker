class Tweet {
  final Map _data;
  Map? _includes;

  Tweet({data, includes}) : _data = data {
    _includes = includes;
  }

  String get text {
    String text = _data['text'];
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
      return _data['id'];
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
      return _data['created_at'];
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
