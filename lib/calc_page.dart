import 'package:flutter/material.dart';

import 'package:flutter_project_calculator/button_values.dart';

class CalcPage extends StatefulWidget {
  const CalcPage({super.key});

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  String number1 = '';
  String number2 = '';
  String arithmetic = '';
  String previousNumber = '0';
  late double result;

  void arithmeticCalc() {
    final double parse1 = double.parse(number1);
    final double parse2 = double.parse(number2);
    switch (arithmetic) {
      case '+':
        result = parse1 + parse2;
        break;
      case '-':
        result = parse1 - parse2;
        break;
      case 'x':
        result = parse1 * parse2;
        break;
      case '/':
        result = parse1 / parse2;
        break;
      default:
    }
    setState(() {
      if (result == result.toInt()) {
        number1 = result.toInt().toString();
      } else {
        number1 = result.toStringAsFixed(2);
      }
      previousNumber = number1;
      arithmetic = '';
      number2 = '';
    });
  }

  void buttonInput(String input) {
    setState(() {
      // number 1 input
      if (number1.isEmpty &&
          arithmetic.isEmpty &&
          number2.isEmpty &&
          int.tryParse(input) != null) {
        number1 = input;
        return;
      }
      if (number1.isNotEmpty &&
          arithmetic.isEmpty &&
          number2.isEmpty &&
          int.tryParse(input) != null) {
        number1 += input;
        return;
      }
      if (input == '-' &&
          number1.isEmpty &&
          arithmetic.isEmpty &&
          number2.isEmpty) {
        number1 = '-';
        return;
      }
      if (number1.endsWith('-') &&
          arithmetic.isEmpty &&
          input == '%' &&
          input == 'x' &&
          input == '/' &&
          input == '-' &&
          input == '+') {
        return;
      }

      // number 2 input
      if (number1.isNotEmpty &&
          number2.isEmpty &&
          arithmetic.isNotEmpty &&
          int.tryParse(input) != null) {
        number2 = input;
        return;
      }
      if (number1.isNotEmpty &&
          number2.isNotEmpty &&
          arithmetic.isNotEmpty &&
          int.tryParse(input) != null) {
        number2 += input;
        return;
      }

      // dot(.) number 1 input
      if (input == '.' &&
          number1.isNotEmpty &&
          number2.isEmpty &&
          !number1.contains(input)) {
        number1 += input;
        return;
      }
      if (input == '.' &&
          number1.isNotEmpty &&
          arithmetic.isNotEmpty &&
          number2.isEmpty) {
        return;
      }
      // dot(.) number 2 input
      if (input == '.' &&
          number1.isNotEmpty &&
          number2.isNotEmpty &&
          !number2.contains(input)) {
        number2 += input;
        return;
      }

      // arithmetic input
      if (number1.isNotEmpty &&
          int.tryParse(input) == null &&
          input != 'D' &&
          input != 'C' &&
          input != '=' &&
          input != '%') {
        arithmetic = input;
        return;
      }

      // delete input
      if (input == 'D') {
        number1 = '';
        arithmetic = '';
        number2 = '';
        return;
      }
      if (input == 'C' &&
          number1.isNotEmpty &&
          arithmetic.isEmpty &&
          number2.isEmpty) {
        number1 = number1.substring(0, number1.length - 1);
        return;
      }
      if (input == 'C' &&
          number1.isNotEmpty &&
          arithmetic.isNotEmpty &&
          number2.isEmpty) {
        arithmetic = arithmetic.substring(0, arithmetic.length - 1);
        return;
      }
      if (input == 'C' &&
          number1.isNotEmpty &&
          arithmetic.isNotEmpty &&
          number2.isNotEmpty) {
        number2 = number2.substring(0, number2.length - 1);
        return;
      }
    });

    // arithmetic result
    if (input == '=' &&
        number1.isNotEmpty &&
        arithmetic.isNotEmpty &&
        number2.isNotEmpty) {
      arithmeticCalc();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              previousNumber,
              style: const TextStyle(color: Colors.white54, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: Text(
              '$number1$arithmetic$number2',
              style: const TextStyle(
                fontSize: 55,
              ),
            ),
          ),
          Wrap(
            children: Btn.buttonValues
                .map(
                  (value) => SizedBox(
                    width: value == Btn.n0
                        ? screenSize.width / 2
                        : (screenSize.width / 4),
                    height: screenSize.width / 5,
                    child: buildButton(value),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: [Btn.del, Btn.clr].contains(value)
            ? Colors.blueGrey
            : [
                Btn.per,
                Btn.multiply,
                Btn.divide,
                Btn.subtract,
                Btn.add,
                Btn.calculate
              ].contains(value)
                ? Colors.orange
                : const Color.fromARGB(221, 49, 48, 48),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            buttonInput(value);
          },
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
