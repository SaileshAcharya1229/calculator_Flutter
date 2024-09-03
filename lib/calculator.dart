import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = " ";
  String result = "0";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Flexible(child: resultWidget(), flex: 1),
          Flexible(child: buttonsWidget(), flex: 2),
        ],
      ),
    ));
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: TextStyle(fontSize: 32),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: TextStyle(fontSize: 32),
          ),
        )
      ],
    );
  }

  Widget buttonsWidget() {
    return GridView.builder(
      itemCount: 20,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return button("1");
      },
    );
  }

  Widget button(String text) {
    return Container(
      margin: EdgeInsets.all(20),
      child: MaterialButton(
        onPressed: () {},
        color: Colors.red,
        textColor: Colors.white,
        child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
