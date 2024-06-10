import 'dart:async';

import 'package:accesslab_demo/app/app.locator.dart';
import 'package:accesslab_demo/app/app.logger.dart';
import 'package:accesslab_demo/app/app.router.dart';
import 'package:accesslab_demo/request/api_model.dart';
import 'package:accesslab_demo/request/github/github_service.dart';
import 'package:accesslab_demo/request/github/model/user_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserListViewModel extends BaseViewModel {
  final Logger _logger = getLogger("ListViewModel");
  final GithubService _githubService = locator<GithubService>();
  final _dialog = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  List<UserModel> _userModel = [];
  List<UserModel> get userModel => _userModel;

  UserListViewModel() {
    _logger.i('ListViewModel Created');
  }

  init() async {
    _userModel = await handleUserModel();
    rebuildUi();
  }

  FutureOr<List<UserModel>> handleUserModel() async {
    ApiModel<List<UserModel>> res =
        await runBusyFuture(_githubService.getUserList(), throwException: true);
    if (res.status == ApiStatus.success) {
      return res.body!;
    } else if (res.status == ApiStatus.error) {
      _dialog.showDialog(
          title: 'Request Fail', description: 'Check Newwork Connection');
    }
    return []; // Add a return statement here
  }

  navigateToDetailPage(UserModel model) {
    _navigationService.navigateToDetailView(
      userModel: model,
      // isFromSpot: false,
      // category: _title,
    );
  }
}
