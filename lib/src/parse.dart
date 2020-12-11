import 'package:flutter/foundation.dart';

/// parse and encode webservices payload and return encoded url
class Parse {
  final String webUrl;
  final String quoteBody;
  final String quoteRecipients;

  Parse({
    @required this.webUrl,
    @required this.quoteBody,
    @required this.quoteRecipients,
  });

  /// return parsed webservice url
  String url() => '${this.webUrl}${_payload()}';

  String _payload() => '&to=${_recipients()}&msg=${_body()}';

  String _recipients() => Uri.encodeComponent(this.quoteRecipients);

  String _body() => Uri.encodeComponent(this.quoteBody);

  @override
  String toString() =>
      'Parse: -> (webUrl: $webUrl, quoteBody: $quoteBody, quoteRecipients: $quoteRecipients)';
}
