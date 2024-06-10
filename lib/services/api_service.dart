import 'package:accesslab_demo/app/app.config.dart';
import 'package:accesslab_demo/app/app.logger.dart';
import 'package:accesslab_demo/request/api_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

class ApiService {
  final log = getLogger('ApiService');

  Future<ApiModel> request({
    required String path,
    String method = 'GET',
    dynamic body,
    Map<String, dynamic>? queryParam,
    Map<String, dynamic>? headers,
  }) async {
    return await _doRequest(
      path,
      body,
      method,
      headers,
      queryParam,
    );
  }

  Future<ApiModel> _doRequest(
    String path,
    dynamic params,
    String method,
    Map<String, dynamic>? customHeaders,
    Map<String, dynamic>? queryParam,
  ) async {
    // Check network available
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return ApiModel(
        message: '請確認網路連線',
        status: ApiStatus.error,
        responseCode: '-1',
      );
    }

    Map<String, dynamic> headers = await _getHeaders(customHeaders);
    dio.BaseOptions baseOptions = dio.BaseOptions(
      method: method,
      headers: headers,
      baseUrl: Config.apiBaseUrl,
      connectTimeout: Duration(milliseconds: Config.timeout),
      receiveTimeout: Duration(milliseconds: Config.timeout),
    );
    // ignore: no_leading_underscores_for_local_identifiers
    dio.Dio _dio = dio.Dio(baseOptions);

    try {
      log.d(
        '-------------------------------------------------------',
      );
      log.d('API Request: $method ${Config.apiBaseUrl}$path');
      if (params != null) {
        if (params is dio.FormData) {
          log.d('*** Form Data Params ***');
          log.d('Fields: ${params.fields}');
          log.d('Files: ${params.files}');
        } else
          log.d('Param: $params');
      }

      if (queryParam != null) log.d('Query: $queryParam');
      // Request
      dio.Response response = await _dio.request(
        path,
        data: params,
        queryParameters: queryParam,
      );

      log.i('API Response: $method $path');
      log.i('Response: $response');
      // log.i('Header: $reqder');

      // success Return
      return ApiModel(
        // rawBody: response.data is Map
        //     ? response.data
        //     : response,
        header: response.headers.map,
        body: response.data,
        // pagination: PaginationModel(
        //   page: response.data['page'],
        //   size: response.data['size'],
        //   total: response.data['total'],
        // ),
        status: ApiStatus.success,
        responseCode: response.statusCode.toString(),
      );
    } on DioException catch (e) {
      // API fail
      log.e('API Error: $method $path');
      log.e('Response: ${e.response?.data}');
      log.e('Response Code: ${e.response?.statusCode}');
      // 401
      if (e.response != null && e.response?.data?['code'] == 401) {
        //  Return
        return ApiModel(
          status: ApiStatus.unauthorized,
          responseCode: '-1',
        );
      }

      // fail Return
      return ApiModel(
        message: e.response?.data is Map
            ? '${e.response?.data?['message']} (${e.response?.data?['code']})'
            : e.response?.data,
        status: ApiStatus.error,
        responseCode: e.response?.statusCode.toString() ?? '-1',
      );
    } catch (e) {
      // error
      log.e('Other Error: $method $path');
      log.e(e);

      return ApiModel(
        message: '系統忙碌中',
        status: ApiStatus.error,
        responseCode: '-1',
      );
    }
  }

  _getHeaders(Map<String, dynamic>? customHeader) async {
    Map<String, dynamic> headers = customHeader ?? {};
    if (headers['Content-Type'] == null)
      headers['Content-Type'] = 'application/json';

    // var token = await locator<AuthService>().getToken();
    // if (token != null) headers['Authorization'] = 'Bearer ' + token;

    return headers;
  }
}
