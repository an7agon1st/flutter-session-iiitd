import 'package:flutter/material.dart';

class ProperTime extends StatelessWidget {
  Stream<String> getTime() {
    // gives a PROPER stream of time more human decipherable
    Stream<String> time =
        Stream<String>.periodic(Duration(milliseconds: 1), (value) {
      return DateTime.now().toString();
    });
    // returns the stream to the caller
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proper Time'),
      ),
      body: Center(
        child: StreamBuilder<String>(
          stream: getTime(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Error, goodluck debugging!');

            if (snapshot.connectionState == ConnectionState.none)
              return Text('Connection error!!!');

            return Text(snapshot.data);
          },
        ),
      ),
    );
  }
}
