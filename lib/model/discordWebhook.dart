class DiscordWebhook {
  late String content;
  late String username;
  late String avatarUrl;
  late String tts;
  late String embeds;
  late String allowedMentions;
  late String components;
  late List<BigInt> files;

  Map<String, dynamic> get webhook {
    return {
      'content': content,
      'username': username,
      'avatarUrl': avatarUrl,
      'tts': tts,
      'embeds': embeds,
      'allowedMentions': allowedMentions,
      'components': components,
      'files': files,
    };
  }
}
