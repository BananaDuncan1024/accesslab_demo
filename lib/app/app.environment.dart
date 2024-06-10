import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> setupEnvironment() async {
  // build time by --dart-define=ENV=DEV
  const envStr = String.fromEnvironment('ENV');

  var envPath = 'environments/';

  switch (envStr) {
    case 'DEV':
      envPath = '${envPath}dev.env';
      break;

    case 'STAGING':
      envPath = '${envPath}staging.env';
      break;

    case 'PROD':
      envPath = '${envPath}prod.env';
      break;

    default:
      envPath = '${envPath}dev.env';
      break;
  }

  await dotenv.load(
    fileName: envPath,
  );
}
