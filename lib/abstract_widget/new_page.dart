import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'abstract_factory.dart';
import 'button_abstract.dart';

class A {
  String name = "";
  String lname = "";

  void setName(String n) {
    name = n;
  }

  void setLName(String n) {
    lname = n;
  }
}

class NewPage extends StatefulWidget {
  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  int initial = 12;

  @override
  void initState() {
    super.initState();
    var obj = A();

    obj
      ..setName("AB")
      ..setLName("CD");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AbstractFactoryImpl().buildButton(context, "Click", () {
              setState(() {
                initial = initial++;
              });
            }),
            AbstractFactoryImpl().buildIndicator(context),
            const Text("did change update widget example"),
            CounterWidget(initialValue: initial),
            const Text("did change update widget example"),
            MyCounterWidget()
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final int initialValue;

  CounterWidget({Key? key, required this.initialValue}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int counter;

  @override
  void initState() {
    super.initState();
    setState(() {
      counter = widget.initialValue;
    });
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        counter = 0;
      });
    }
    print("DidupdateWidget");
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $counter'),
        ElevatedButton(
          onPressed: incrementCounter,
          child: Text('Increment'),
        ),
      ],
    );
  }
}

class MyCounterWidget extends StatefulWidget {
  @override
  _MyCounterWidgetState createState() => _MyCounterWidgetState();
}

class _MyCounterWidgetState extends State<MyCounterWidget> {
  int counter = 0;
  Color bgColor = Colors.white;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the current theme and update the background color accordingly.
    final theme = Theme.of(context);
    setState(() {
      if (counter != 0) bgColor = CupertinoColors.systemGreen;
    });
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter Value: $counter',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: incrementCounter,
              child: const Text('Increment Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
