import 'package:oauth2/oauth2.dart' as oauth2;

class Autenticate {
  final String _TWITTER_KEY;
  final String _TWITTER_KEY_SECRET;
  final String _END_POINT;

  Autenticate({
    required String TWITTER_KEY,
    required String END_POINT,
    required String TWITTER_KEY_SECRET,
  })  : _TWITTER_KEY = TWITTER_KEY,
        _TWITTER_KEY_SECRET = TWITTER_KEY_SECRET,
        _END_POINT = END_POINT;

  get TWITTER_KEY_SECRET {
    return Uri.parse(_END_POINT);
  }

  Future<String> get BEARER_TOKEN async {
    var client = await oauth2.clientCredentialsGrant(
      TWITTER_KEY_SECRET,
      _TWITTER_KEY,
      _TWITTER_KEY_SECRET,
    );

    return client.credentials.accessToken;
  }
}
