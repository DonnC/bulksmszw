import 'dart:convert';

/// bulksmsweb api success response
class ApiSuccess {
    ApiSuccess({
        this.data,
        this.errorString,
        this.timestamp,
    });

    final List<Data> data;
    final dynamic errorString;
    final int timestamp;

    factory ApiSuccess.fromJson(String str) => ApiSuccess.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ApiSuccess.fromMap(Map<String, dynamic> json) => ApiSuccess(
        data: List<Data>.from(json["data"].map((x) => Data.fromMap(x))),
        errorString: json["error_string"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "error_string": errorString,
        "timestamp": timestamp,
    };
}

class Data {
    Data({
        this.status,
        this.error,
        this.smslogId,
        this.queue,
        this.to,
    });

    final String status;
    final dynamic error;
    final String smslogId;
    final String queue;
    final String to;

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        status: json["status"],
        error: json["error"],
        smslogId: json["smslog_id"],
        queue: json["queue"],
        to: json["to"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "error": error,
        "smslog_id": smslogId,
        "queue": queue,
        "to": to,
    };
}
