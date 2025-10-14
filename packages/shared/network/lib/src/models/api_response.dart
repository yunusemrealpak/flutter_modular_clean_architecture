/// Generic API response wrapper
class ApiResponse<T> {
  /// The response data
  final T? data;

  /// Success status
  final bool success;

  /// Error message if any
  final String? message;

  /// HTTP status code
  final int? statusCode;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const ApiResponse({
    this.data,
    required this.success,
    this.message,
    this.statusCode,
    this.metadata,
  });

  /// Factory constructor for successful responses
  factory ApiResponse.success({
    T? data,
    String? message,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) {
    return ApiResponse(
      data: data,
      success: true,
      message: message,
      statusCode: statusCode,
      metadata: metadata,
    );
  }

  /// Factory constructor for error responses
  factory ApiResponse.error({
    String? message,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) {
    return ApiResponse(
      data: null,
      success: false,
      message: message,
      statusCode: statusCode,
      metadata: metadata,
    );
  }

  /// Factory constructor from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic)? fromJsonT,
  }) {
    return ApiResponse(
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Converts the response to JSON
  Map<String, dynamic> toJson({dynamic Function(T)? toJsonT}) {
    return {
      'data': data != null && toJsonT != null ? toJsonT(data as T) : data,
      'success': success,
      if (message != null) 'message': message,
      if (statusCode != null) 'statusCode': statusCode,
      if (metadata != null) 'metadata': metadata,
    };
  }

  /// Creates a copy with modified fields
  ApiResponse<T> copyWith({
    T? data,
    bool? success,
    String? message,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) {
    return ApiResponse(
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() {
    return 'ApiResponse(success: $success, message: $message, statusCode: $statusCode, data: $data)';
  }
}
