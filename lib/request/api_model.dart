import 'api_status.dart';

export 'api_status.dart';

class ApiModel<T> {
  // Api body
  Map<String, dynamic>? rawBody;

// Api header
  Map<String, List<String>>? header;

  // Api body
  T? body;

  // Error Message
  String message;

  // Response Code
  String responseCode;

  // Status
  ApiStatus status;

  // pagination
  PaginationModel? pagination;

  ApiModel({
    this.rawBody,
    this.body,
    this.message = '系統忙碌中',
    this.pagination,
    this.header,
    required this.responseCode,
    required this.status,
  });
}

class PaginationModel {
  String? page;
  String? size;
  String? total;

  PaginationModel({
    this.page,
    this.size,
    this.total,
  });

  factory PaginationModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PaginationModel();

    return PaginationModel(
      page: json['page'],
      size: json['size'],
      total: json['total'],
    );
  }
}
