import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//The main app is a stateless widget because we will be creating a stateful widget within the app to change the state of the widgets inside
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red,
          // Sets the primary background color for the pages within the whole app,
          //you can of course change it within the properties of individual Scaffolds
          //by passing the named parameter color
          scaffoldBackgroundColor: Colors.red[50]),
      //the main page as the app opens
      home: MyHomePage(),
    );
  }
}

//This is the stateful widget since we'll be changing data within here
class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//Creating the Stream for giving out the time since epoch(January 1, 1970) in MicroSeconds
Stream<int> getTheTime() {
  Stream<int> theTime =
      Stream<int>.periodic(Duration(microseconds: 1), (int x) {
    return DateTime.now().microsecondsSinceEpoch;
  });
  // taking limited data from the stream
  //
  // theTime = theTime.take(100000);
  return theTime;
}

class _MyHomePageState extends State<MyHomePage> {
  // the variable tracks the value of the Cupertino Switch
  bool buttonValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample App'),
      ),
      body: Column(
        // Where the widgets should be on the horizontal axis along the phone screen
        crossAxisAlignment: CrossAxisAlignment.center,
        // Where the widgets should be on the vertical axis along the phone screen.
        // Space evenly, as the name suggests, Evenly spaces the widgets vertically
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            // ternery operator to check for button value and display widget on screen accordingly
            child: buttonValue
                // if true
                ? Text(
                    'Data Stream Paused',
                    style: TextStyle(fontSize: 26),
                  )
                //if false
                //
                // A Stream builder subscribes to a data stream and changes value on screen accordingly as the stream spits
                : StreamBuilder<int>(
                    stream: getTheTime(),
                    builder: (context, snapshot) {
                      // if for some reason the stream gives out no data
                      if (!snapshot.hasData) return Text('Good luck debugging');
                      // checking connection state with the Stream
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Text('Waiting Connection');
                      // if the stream has finished
                      if (snapshot.connectionState == ConnectionState.done)
                        return Text('The stream has expired, lol');

                      // display the stream onto the screen
                      return Text(
                        '${snapshot.data.toString()}',
                        style: TextStyle(fontSize: 28),
                      );
                    },
                  ),
          ),
          // we're using a cupertino style switch because, well, we can
          CupertinoSwitch(
            activeColor: Colors.red[100],
            // tracks the button state according to the variable value
            value: buttonValue,
            //this function executes whenever the button is pressed.
            onChanged: (value) {
              // the set state notifies the widget tree that there has been a value change,
              // this calls the build function and the whole widget tree is rebuilt
              setState(() {
                buttonValue = value;
              });
            },
          )
        ],
      ),
    );
  }
}

// TODO: Add drawer
// TODO: Add navigation
// TODO: Change individual text color
