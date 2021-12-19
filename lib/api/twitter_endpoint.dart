class TwitterEndpoint {
  static final String _END_POINT = "https://api.twitter.com";

  String get base {
    return _END_POINT;
  }
  
  String get baseVersion2 {
    return _END_POINT + "/2/";
  }

  Uri get autentication {
    return Uri.parse(base + "/oauth2/token");
  }

  Uri get streamRules {
    return Uri.parse(baseVersion2 + "tweets/search/stream/rules");
  }

  Uri get stream {
    return Uri.parse(baseVersion2 + "tweets/search/stream");
  }

}
