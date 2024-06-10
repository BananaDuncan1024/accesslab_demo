import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String environment = dotenv.get('ENV');

  static int timeout = int.parse(dotenv.get('NTW_TIMEOUT'));
  static int apiDelay = int.parse(dotenv.get('NTW_DELAY'));

  static String apiBaseUrl = dotenv.get('API_BASE_URL');
}
