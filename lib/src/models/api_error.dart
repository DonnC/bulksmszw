import 'dart:convert';

/// bulksmsweb custom onSend message error model
class ApiError {
  final String? status;
  final String? error;
  // ignore: non_constant_identifier_names
  final dynamic error_string;
  final int? timestamp;

  ApiError({
    this.status,
    this.error,
    // ignore: non_constant_identifier_names
    this.error_string,
    this.timestamp,
  });

  ApiError copyWith({
    String? status,
    String? error,
    // ignore: non_constant_identifier_names
    String? error_string,
    int? timestamp,
  }) {
    return ApiError(
      status: status ?? this.status,
      error: error ?? this.error,
      error_string: error_string ?? this.error_string,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'error': error,
      'error_string': error_string,
      'timestamp': timestamp,
    };
  }

  factory ApiError.fromMap(Map<String, dynamic>? map) {
    return ApiError(
      status: map!['status'],
      error: map['error'],
      error_string: map['error_string'],
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiError.fromJson(String source) =>
      ApiError.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApiError(status: $status, error: $error, error_string: $error_string, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ApiError &&
        o.status == status &&
        o.error == error &&
        o.error_string == error_string &&
        o.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        error.hashCode ^
        error_string.hashCode ^
        timestamp.hashCode;
  }
}
