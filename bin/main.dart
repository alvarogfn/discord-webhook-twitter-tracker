import 'dart:io';
import 'package:dotenv/dotenv.dart' show load, clean, isEveryDefined, env;

main(List<String> parameters) {
  load();
  print('your home directory is: ${env['HOME']}');
}
