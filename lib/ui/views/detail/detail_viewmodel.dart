import 'dart:async';

import 'package:accesslab_demo/app/app.locator.dart';
import 'package:accesslab_demo/app/app.logger.dart';
import 'package:accesslab_demo/request/api_model.dart';
import 'package:accesslab_demo/request/github/github_service.dart';
import 'package:accesslab_demo/request/github/model/user_detail_model.dart';
import 'package:accesslab_demo/request/github/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailViewModel extends BaseViewModel {
  final Logger _logger = getLogger('DetailViewModel');
  final GithubService _githubService = locator<GithubService>();
  final _dialog = locator<DialogService>();
  late UserDetailModel _userDetailModel;
  late TextEditingController _nameController;
  TextEditingController get nameController => _nameController;

  UserDetailModel get userDetailModel => _userDetailModel;
  // set userDetailModel(UserDetailModel value) {
  //   _userDetailModel = value;
  // }

  late UserModel _userModel;
  UserModel get userModel => _userModel;
  final _navigationService = locator<NavigationService>();

  init(UserModel model) async {
    _userModel = model;
    _userDetailModel = await handleUserDetailModel(model);
    _nameController = TextEditingController(text: _userDetailModel.name);
    rebuildUi();
  }

  Future<void> setName(String name) async {
    // _navigationService.back();
    _userDetailModel.name = name;
    rebuildUi();
  }

  Future<void> pop() async {
    _navigationService.back();
  }

  Future<UserDetailModel> handleUserDetailModel(UserModel model) async {
    ApiModel<UserDetailModel> res = await runBusyFuture(
        _githubService.getUserDetail(model.login),
        throwException: true);
    if (res.status == ApiStatus.success) {
      return res.body!;
    } else if (res.status == ApiStatus.error) {
      _logger.e('Request Fail');
      _dialog.showDialog(
          title: 'Request Fail', description: 'Check Newwork Connection');
    }
    throw Exception('Request Fail');
  }

  Future<void> launchURL(String url) async {
    final Uri url0 = Uri.parse(url);

    if (!await launchUrl(url0)) {
      _logger.e('Could not launch $url0');
      throw Exception('Could not launch $url0');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
