import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/index.dart';
import '../parse.dart';
import '../utils.dart';

/// handle sending api request to bulksmsweb portal
class Api {
  final String url;
  final String recipients;
  final String message;

  Api({
    this.url,
    this.recipients,
    this.message,
  });

  /// make a request to bulksmsweb services to send bulksms
  // ignore: missing_return
  Future<ApiResponse> sendRequest() async {
    try {
      String _url = Parse(
        quoteBody: message,
        quoteRecipients: recipients,
        webUrl: url,
      ).url();

      var _result = await http.post(_url);

      if (_result.statusCode == 200) {
        var _response = _checkApiMessageError(_result.body);

        if (_response == null) {
          return ApiResponse(
            statusresponse: SMSRESPONSE.FAIL,
            apiResponse: _response,
            message: 'failed to send bulksmsweb message',
          );
        } else {
          if (_response is ApiError) {
            final ApiError _error = _response;
            return ApiResponse(
              statusresponse: SMSRESPONSE.API_ERROR,
              apiResponse: _response,
              message: _error.error_string,
            );
          }
          if (_response is ApiSuccess) {
            // can be success when user send message but with no credits left
            final ApiSuccess _success = _response;

            if (_success.data.first.status == 'ERR' &&
                _success.data.first.error == '200') {
              // not enough credits here
              return ApiResponse(
                statusresponse: SMSRESPONSE.API_ERROR,
                apiResponse: _success,
                message: 'insufficient credits',
              );
            } else {
              return ApiResponse(
                statusresponse: SMSRESPONSE.SUCCESS,
                apiResponse: _response,
                message: 'success',
              );
            }
          }
          if (_response is ApiCredits) {
            // return success on credits
            return ApiResponse(
              statusresponse: SMSRESPONSE.SUCCESS,
              apiResponse: _response,
              message: 'success credit',
            );
          }
        }
      } else {
        return ApiResponse(
          statusresponse: SMSRESPONSE.FAIL,
          message: '${_result.statusCode}',
          apiResponse: _result.body,
        );
      }
    } catch (e) {
      return ApiResponse(
        statusresponse: SMSRESPONSE.ERROR,
        apiResponse: null,
        message: 'Error sending bulksmszw request, ${e.toString()}',
      );
    }
  }

  _checkApiMessageError(var response) {
    // handle bulksmszw api error
    var resp = jsonDecode(response);

    if (resp['error_string'] != null) {
      // bulksms custom error on send message caught
      return ApiError.fromJson(response);
    } else {
      if (resp.toString().contains('credit')) {
        // bulksmsweb credit operation response
        return ApiCredits.fromJson(response);
      }
      if (resp.toString().contains('data')) {
        // bulksmsweb success response
        return ApiSuccess.fromJson(response);
      } else {
        return null;
      }
    }
  }
}
