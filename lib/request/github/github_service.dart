import 'package:accesslab_demo/app/app.locator.dart';
import 'package:accesslab_demo/app/app.logger.dart';
import 'package:accesslab_demo/request/api_model.dart';
import 'package:accesslab_demo/request/github/model/user_detail_model.dart';
import 'package:accesslab_demo/request/github/model/user_model.dart';
import 'package:accesslab_demo/services/api_service.dart';
import 'package:accesslab_demo/services/base_service.dart';
import 'package:logger/logger.dart';

class GithubService extends BaseService {
  Logger _logger = getLogger('GithubService');
  ApiService apiService = locator<ApiService>();

  // Get Github User list
  Future<ApiModel<List<UserModel>>> getUserList({
    int since = 0,
    int perPage = 100,
  }) async {
    ApiModel resp = await apiService.request(
      path: '/users',
      queryParam: {
        'since': since,
        'per_page': perPage,
      },
    );

    return getApiModel<List<UserModel>>(
      resp,
      (json) => UserModel.userListModelFromJson(json),
    );
  }

  String removeAngleBrackets(String url) {
    if (url.startsWith('<') && url.endsWith('>')) {
      return url.substring(1, url.length - 1);
    }
    return url;
  }

  Map<String, String> parseLinkHeader(List<String>? linkList) {
    final Map<String, String> links = {};
    if (linkList == null) {
      return links;
    }

    // print(removeAngleBrackets(linkList[0]));
    // final uri = Uri.parse(removeAngleBrackets(linkList[0]));
    // final queryParams = uri.queryParameters;
    // print(queryParams);

    // final regex = RegExp(r'<([^>]+)>; rel="([^"]+)"');
    // final matches = regex.allMatches(linkHeader);

    return links;
  }

  // Get Github User detail
  Future<ApiModel<UserDetailModel>> getUserDetail(
    String username,
  ) async {
    ApiModel resp = await apiService.request(
      path: '/users/$username',
    );

    return getApiModel<UserDetailModel>(
      resp,
      (json) => UserDetailModel.userDeitalModelFromJson(json),
    );
  }
}
