import 'package:get/get.dart';

class CalcController extends GetxController {
  static CalcController get instance => Get.find();
  Rx<String> number1 = ''.obs;
  Rx<String> number2 = ''.obs;
  Rx<String> arithmetic = ''.obs;
  Rx<String> previousNumber = '0'.obs;
  Rx<double> result = 0.0.obs;

  void arithmeticCalc() {
    final double parse1 = double.parse(number1.value);
    final double parse2 = double.parse(number2.value);
    switch (arithmetic.value) {
      case '+':
        result.value = parse1 + parse2;
        break;
      case '-':
        result.value = parse1 - parse2;
        break;
      case 'x':
        result.value = parse1 * parse2;
        break;
      case '/':
        result.value = parse1 / parse2;
        break;
      default:
    }
    if (result.value == result.toInt()) {
      number1.value = result.toInt().toString();
    } else {
      number1.value = result.toStringAsFixed(2);
    }
    previousNumber.value = number1.value;
    arithmetic.value = '';
    number2.value = '';
  }

  void buttonInput(String input) {
    // number 1 input
    if (number1.value.isEmpty &&
        arithmetic.value.isEmpty &&
        number2.value.isEmpty &&
        int.tryParse(input) != null) {
      number1.value = input;
      return;
    }
    if (number1.value.isNotEmpty &&
        arithmetic.value.isEmpty &&
        number2.value.isEmpty &&
        int.tryParse(input) != null) {
      number1.value += input;
      return;
    }
    if (input == '-' &&
        number1.value.isEmpty &&
        arithmetic.value.isEmpty &&
        number2.value.isEmpty) {
      number1.value = '-';
      return;
    }
    if (number1.value.endsWith('-') &&
        arithmetic.value.isEmpty &&
        input == '%' &&
        input == 'x' &&
        input == '/' &&
        input == '-' &&
        input == '+') {
      return;
    }

    // number 2 input
    if (number1.value.isNotEmpty &&
        number2.value.isEmpty &&
        arithmetic.value.isNotEmpty &&
        int.tryParse(input) != null) {
      number2.value = input;
      return;
    }
    if (number1.value.isNotEmpty &&
        number2.value.isNotEmpty &&
        arithmetic.value.isNotEmpty &&
        int.tryParse(input) != null) {
      number2.value += input;
      return;
    }

    // dot(.) number 1 input
    if (input == '.' &&
        number1.value.isNotEmpty &&
        number2.value.isEmpty &&
        !number1.value.contains(input)) {
      number1.value += input;
      return;
    }
    if (input == '.' &&
        number1.value.isNotEmpty &&
        arithmetic.value.isNotEmpty &&
        number2.value.isEmpty) {
      return;
    }
    // dot(.) number 2 input
    if (input == '.' &&
        number1.value.isNotEmpty &&
        number2.value.isNotEmpty &&
        !number2.value.contains(input)) {
      number2.value += input;
      return;
    }

    // arithmetic.value input
    if (number1.value.isNotEmpty &&
        int.tryParse(input) == null &&
        input != 'D' &&
        input != 'C' &&
        input != '=' &&
        input != '%') {
      arithmetic.value = input;
      return;
    }

    // delete input
    if (input == 'D') {
      number1.value = '';
      arithmetic.value = '';
      number2.value = '';
      return;
    }
    if (input == 'C' &&
        number1.value.isNotEmpty &&
        arithmetic.value.isEmpty &&
        number2.value.isEmpty) {
      number1.value = number1.value.substring(0, number1.value.length - 1);
      return;
    }
    if (input == 'C' &&
        number1.value.isNotEmpty &&
        arithmetic.value.isNotEmpty &&
        number2.value.isEmpty) {
      arithmetic.value = arithmetic.value.substring(0, arithmetic.value.length - 1);
      return;
    }
    if (input == 'C' &&
        number1.value.isNotEmpty &&
        arithmetic.value.isNotEmpty &&
        number2.value.isNotEmpty) {
      number2.value = number2.value.substring(0, number2.value.length - 1);
      return;
    }

    // arithmetic.value result
    if (input == '=' &&
        number1.value.isNotEmpty &&
        arithmetic.value.isNotEmpty &&
        number2.value.isNotEmpty) {
      arithmeticCalc();
      return;
    }
  }
}
