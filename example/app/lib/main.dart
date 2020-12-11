import 'package:flutter/material.dart';
import 'package:bulksmszw/bulksmszw.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bulksmszw demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'BulkSmsZw Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _message;
  TextEditingController _recipient_1;
  TextEditingController _recipient_2;

  @override
  void initState() {
    super.initState();
    _message = TextEditingController();
    _recipient_1 = TextEditingController();
    _recipient_2 = TextEditingController();
  }

  @override
  void dispose() {
    _message.dispose();
    _recipient_1.dispose();
    _recipient_2.dispose();
    super.dispose();
  }

  showLoader() {
    return showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(
          'sending sms...',
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  Widget _customTextField({
    TextEditingController controller,
    String validateError,
    String labelText,
    String hintText,
    TextInputType keyboardType: TextInputType.text,
    int maxLines: 1,
  }) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return validateError;
          }
          return null;
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    // create a list of string of recipients | contacts
    List<String> _recipients = [
      _recipient_1.text.trim(),
      _recipient_2.text.trim(),
    ];

    final api = BulkSmsZw(
      bulksmsWebKey: '<your-api-web-key>',
      bulksmsWebName: '<your-api-web-username>',
    );

    showLoader();

    ApiResponse _response = await api.send(
      message: _message.text.trim(),
      recipients: _recipients,
    );

    // pop previous showLoader dialog
    Navigator.of(context, rootNavigator: true).pop();

    // check api statusresponse
    if (_response.statusresponse == SMSRESPONSE.SUCCESS) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.greenAccent,
          content: new Text(
            'Text message sent successfully',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: new Text(
            'Error: ${_response.message}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    setState(() {
      _message.clear();
      _recipient_1.clear();
      _recipient_2.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _customTextField(
                controller: _message,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                validateError: 'message body is required',
                labelText: 'Message',
                hintText: 'enter message to send',
              ),
              SizedBox(height: 15),
              _customTextField(
                controller: _recipient_1,
                keyboardType: TextInputType.phone,
                labelText: 'Contact-1',
                validateError: 'at least one contact should be provided',
                hintText: '263778888888',
              ),
              SizedBox(height: 15),
              _customTextField(
                controller: _recipient_2,
                keyboardType: TextInputType.phone,
                labelText: 'Contact-2',
                hintText: '2637xxxxxxxx',
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8),
                child: MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await _sendMessage();
                    }
                  },
                  minWidth: double.infinity,
                  color: Colors.blue,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Send Message',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
