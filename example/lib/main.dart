import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:magic/magic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  var textColor = Colors.white;
  var textController = TextEditingController();
  String parsedNumber = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Magic.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                onPressed: () => Magic.showDialog(),
                child: Text("Dialog")
              ),
              ElevatedButton(
                onPressed: () async {
                  textColor  = await Magic.color;
                  setState(() { });
                },
                child: Text(
                  "Change Color",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    child: TextField(
                      controller: textController,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        var numIn = int.parse(textController.text);
                        setState(() async {
                          parsedNumber = (await Magic.parseNumber(numIn)).toString();
                        });
                      } catch(_) {
                        setState(() {
                          parsedNumber = "Failed";
                        });
                      }
                    },
                    child: Text("Parse number")
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 70,
                    child: Text(parsedNumber),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
