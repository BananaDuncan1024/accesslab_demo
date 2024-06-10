import 'package:accesslab_demo/app/app.locator.dart';
import 'package:accesslab_demo/app/app.logger.dart';
import 'package:accesslab_demo/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final logger = getLogger('LoginViewModel');
  final AuthService _authService = locator<AuthService>();
  login() async {
    await _authService.gitHubLogin();
  }
}
