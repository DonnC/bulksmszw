import '../utils.dart';

/// custom api response model, preferred way to check api response
class ApiResponse {
  /// returns api status code response
  final SMSRESPONSE statusresponse;

  /// returns response based on caught error or on successful
  /// 
  /// on success: -> [ApiSuccess]
  /// on error: -> [ApiError]
  /// on success with [credits] flag set to `true`: -> [ApiCredits] 
  final dynamic apiResponse;

  /// return api response message information
  final String message;

  ApiResponse({
    this.statusresponse,
    this.apiResponse,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusresponse': statusresponse,
      'apiResponse': apiResponse,
      'message': message,
    };
  }
}
