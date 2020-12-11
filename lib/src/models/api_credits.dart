import 'dart:convert';

/// bulksmsweb credit response model
class ApiCredits {
  final String status;
  final String error;
  // ignore: non_constant_identifier_names
  final dynamic error_string;
  final dynamic timestamp;
  final dynamic credit;

  ApiCredits({
    this.status,
    this.error,
    // ignore: non_constant_identifier_names
    this.error_string,
    this.timestamp,
    this.credit,
  });

  ApiCredits copyWith({
    String status,
    String error,
    // ignore: non_constant_identifier_names
    String error_string,
    int timestamp,
    int credit,
  }) {
    return ApiCredits(
      status: status ?? this.status,
      error: error ?? this.error,
      error_string: error_string ?? this.error_string,
      timestamp: timestamp ?? this.timestamp,
      credit: credit ?? this.credit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'error': error,
      'error_string': error_string,
      'timestamp': timestamp,
      'credit': credit,
    };
  }

  factory ApiCredits.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ApiCredits(
      status: map['status'],
      error: map['error'],
      error_string: map['error_string'],
      timestamp: map['timestamp'],
      credit: map['credit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiCredits.fromJson(String source) => ApiCredits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApiCredits(status: $status, error: $error, error_string: $error_string, timestamp: $timestamp, credit: $credit)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ApiCredits &&
      o.status == status &&
      o.error == error &&
      o.error_string == error_string &&
      o.timestamp == timestamp &&
      o.credit == credit;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      error.hashCode ^
      error_string.hashCode ^
      timestamp.hashCode ^
      credit.hashCode;
  }
}
