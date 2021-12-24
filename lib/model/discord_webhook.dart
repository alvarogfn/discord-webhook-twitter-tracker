class DiscordWebhook {
  final String content;
  late String? username;
  late String? avatarUrl;
  late String? tts;
  late String? embeds;
  late String? allowedMentions;
  late String? components;
  late List<BigInt>? files;

  DiscordWebhook({
    required this.content,
    this.username,
    this.avatarUrl,
    this.tts,
    this.embeds,
    this.allowedMentions,
    this.components,
    this.files,
  });

  Map<String, dynamic> get bodyModel {
    return {
      'content': content,
      'username': username,
      'avatar_url': avatarUrl,
      'tts': tts,
      'embeds': embeds,
      'allowedMentions': allowedMentions,
      'components': components,
      'files': files,
    };
  }
}
