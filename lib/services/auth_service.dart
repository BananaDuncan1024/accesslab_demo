import 'package:accesslab_demo/app/app.locator.dart';
import 'package:accesslab_demo/services/api_service.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class AuthService {
  // final Logger _logger = getLogger('AuthService');
  ApiService apiService = locator<ApiService>();
  // final
  final auth0 =
      Auth0('duncanlin-outh.jp.auth0.com', 'CDTaTnGkJZhdieQl2ZgMcLV0TRncnxiY');

  Future<void> gitHubLogin() async {
    final Credentials credentials =
        await auth0.webAuthentication(scheme: "com.accesslab.demo").login();
  }
}
