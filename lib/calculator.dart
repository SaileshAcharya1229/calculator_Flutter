import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = " ";
  String result = "0";

  List<String> buttonsList = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(child: resultWidget(), flex: 1),
            Flexible(child: buttonsWidget(), flex: 3),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    );
  }

  Widget buttonsWidget() {
    return GridView.builder(
      itemCount: 20,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return button(buttonsList[index]);
      },
    );
  }

  Widget button(String text) {
    return Container(
      margin: EdgeInsets.all(4),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handledButtonPressed(text);
          });
        },
        color: getColor(text),
        textColor: Colors.white,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        shape: CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
    );
  }

  void handledButtonPressed(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      userInput = userInput.substring(0, userInput.length - 1);
      return;
    }

    if (text == "=") {
      result = calculate();
      if (result.endsWith(".0")) result = result.replaceAll(".0", "");
      return;
    }
    userInput = userInput + text;
  }

  bool _isValidExpression(String input) {
    // Basic check for invalid characters, sequences, etc.
    // This is a simple example; you might want to use a more robust method.
    final validCharacters = RegExp(r'^[0-9\+\-\*/\(\)\.]*$');
    return validCharacters.hasMatch(input);
  }

  String calculate() {
    try {
      if (!_isValidExpression(userInput)) {
        return "Error";
      }
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }

  // String calculate() {
  //   try {
  //     print('User Input: $userInput');
  //     var exp = Parser().parse(userInput);
  //     var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
  //     return evaluation.toString();
  //   } catch (e) {
  //     print('Error: $e');
  //     return "Error";
  //   }
  // }

  Color getColor(String text) {
    if (text == "/" || text == "*" || text == "+" || text == "-") {
      return Colors.orangeAccent;
    }
    if (text == "C" || text == "AC") {
      return Colors.red;
    }
    if (text == "(" || text == ")") {
      return Colors.blueGrey;
    }
    return Colors.lightBlue;
  }
}
