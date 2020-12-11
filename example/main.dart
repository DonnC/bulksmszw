/// bulksmszw example code
/// Donald Chinhuru Dec 2020
import 'package:bulksmszw/bulksmszw.dart';

void main() async {
  print('[INFO] Sending text `hello from dart` with bulksmszw api');

  final String message = 'hello from dart';

  // contacts supports all zim numbers and groups as defined on your portal
  final List<String> contacts = ['263770000000', '2637xxxxxxxx', '#customers'];

  // create bulksmszw object
  final api = BulkSmsZw(
    bulksmsWebKey: '<your-api-key>',
    bulksmsWebName: '<your-api-username>',
  );

  // send a message, set field `credits` to true to return number of texts left in your account
  ApiResponse response = await api.send(
    message: message,
    recipients: contacts,
    credits: true,
  );

  print('[INFO] ApiResponse: ${response.toMap()}');
}
