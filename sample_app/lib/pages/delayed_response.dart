import 'package:flutter/material.dart';

class DelayedResponse extends StatefulWidget {
  @override
  _DelayedResponseState createState() => _DelayedResponseState();
}

class _DelayedResponseState extends State<DelayedResponse> {
  String response = 'No Response Yet';

  // This function send a delayed String to the caller. A future
  Future<String> getResponse() {
    // delayed 3 seconds
    return Future.delayed(Duration(seconds: 3), () {
      return 'Zoo Wee Mama';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delayed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(response),
            RaisedButton(
              child: Text('Get Response'),
              // the functions is marked async since it's awaiting a future
              onPressed: () async {
                // mess with the await here
                response = await getResponse();
                // blank setState???? whatt???
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
