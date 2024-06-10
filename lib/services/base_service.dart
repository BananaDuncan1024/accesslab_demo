import 'package:accesslab_demo/app/app.logger.dart';
import 'package:accesslab_demo/request/api_model.dart';

class BaseService {
  final _logger = getLogger('BaseService');

  ApiModel<T> getApiModel<T>(
    ApiModel response,
    Function fromJson,
  ) {
    ApiModel<T> apiModel;
    try {
      apiModel = ApiModel(
        rawBody: response.rawBody,
        body: response.body == null ? null : fromJson(response.body),
        message: response.message,
        pagination: response.pagination,
        responseCode: response.responseCode,
        status: response.status,
      );
    } catch (e) {
      _logger.e(e);

      apiModel = ApiModel(
        message: e.toString(),
        responseCode: '-1',
        status: ApiStatus.error,
      );
    }

    return apiModel;
  }
}
