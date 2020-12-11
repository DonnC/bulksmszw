import 'package:flutter_test/flutter_test.dart';

import 'package:bulksmszw/bulksmszw.dart';

void main() {
  test('make request: return ApiResponse instance', () async {
    final api = BulkSmsZw(
      bulksmsWebKey: 'hw8eow-fake-key-bq232Qsa3',
      bulksmsWebName: 'api-name',
    );

    final response = await api.send(
      message: 'hello from flutter-test',
      recipients: ['263770000000', '#flutter', '263773000000'],
    );

    expect(response, isInstanceOf<ApiResponse>());
  });
}
