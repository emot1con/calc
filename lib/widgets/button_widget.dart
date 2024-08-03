 import 'package:flutter/material.dart';
import 'package:flutter_project_calculator/constants.dart';
import 'package:flutter_project_calculator/controller/calc_controller.dart';
import 'package:get/get.dart';

Widget buildButton(String value) {
    final controller = Get.put(CalcController());

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
            controller.buttonInput(value);
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