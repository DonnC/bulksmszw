import 'package:flutter/foundation.dart';

import 'models/index.dart';
import 'services/api.dart';

/// connect to bulksms zw gateway and send a text message
/// obtain authentication details from http://portal.bulksmsweb.com
class BulkSmsZw {
  // ignore: non_constant_identifier_names
  static String _BULKSMS_WEBSERVICE_URL = 'http://portal.bulksmsweb.com/index.php?app=ws';

  // ignore: non_constant_identifier_names
  static String _SEND_SMS_OPERATION = 'pv';

  // ignore: non_constant_identifier_names
  static String _SMS_CREDIT_OPERATION = 'cr';

  /// bulksmsweb api web-key
  final String bulksmsWebKey;

  /// bulksmsweb api username
  final String bulksmsWebName;

  String _key;
  String _name;

  BulkSmsZw({
    @required this.bulksmsWebKey,
    @required this.bulksmsWebName,
  }) {
    _key = bulksmsWebKey.trim();
    _name = bulksmsWebName.trim();
  }

  ///  send message to `recipients`, phone-numbers are passed as a list of numbers or groups or mixed
  ///  returns [ApiResponse] instance
  ///
  ///  ```dart
  ///   final api = BulkSmsZw(bulksmsWebKey: '<web-key>', bulksmsWebName: '<web-name>');
  ///   var resp = await api.send(message="Hello from Flutter", recipients=['#developer', '2637xxxxxxx']);
  ///  ```
  ///  `credits` flag is set to true in order to return text messages left (credits) in your account. Is set to `false` by default
  ///
  /// ```dart
  ///   final api = BulkSmsZw(bulksmsWebKey: '<web-key>', bulksmsWebName: '<web-name>');
  ///   // send message to a group called `#developers` as defined on your bulksmsweb-portal
  ///   var resp = await api.send(message="Please be reminded, project deadline is next week!", recipients=['#developer', '2637xxxxxxx'], credits=true);
  /// ```
  Future<ApiResponse> send({
    @required String message,
    @required List<String> recipients,
    bool credits: false,
    var schedule,
  }) async {
    String _url = _text_op();

    if (credits) {
      _url = _credit_op();
    }

    var resp = await Api(
      url: _url,
      recipients: _recipients(recipients),
      message: message + '\n',
    ).sendRequest();

    return resp;
  }

  // ignore: non_constant_identifier_names
  String _text_op() =>
      '$_BULKSMS_WEBSERVICE_URL&u=$_name&h=$_key&op=$_SEND_SMS_OPERATION';

  // ignore: non_constant_identifier_names
  String _credit_op() =>
      '$_BULKSMS_WEBSERVICE_URL&u=$_name&h=$_key&op=$_SMS_CREDIT_OPERATION';

  String _recipients(List<String> recipients) {
    String _listStr = '';

    for (String number in recipients) {
      if (number.isEmpty) {
        continue;
      }
      _listStr += number.trim() + ',';
    }

    // remove trailing comma
    _listStr =
        _listStr.replaceRange(_listStr.length - 1, _listStr.length, '').trim();

    return _listStr;
  }
}
