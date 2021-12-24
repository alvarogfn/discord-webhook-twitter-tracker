class Tweet {
  final Map _data;
  Map? _includes;

  Tweet({data, includes}) : _data = data {
    _includes = includes;
  }

  String get text {
    return _data['text'];
  }

  get profilePic {
    if (_includes != null) {
      return _includes!['users'][0]['profile_image_url'];
    } else {
      return null;
    }
  }

  get username {
    if (_includes != null) {
      return _includes!['users'][0]['name'];
    } else {
      return null;
    }
  }
}
