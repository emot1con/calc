import 'package:flutter/material.dart';

import 'package:flutter_project_calculator/constants.dart';
import 'package:flutter_project_calculator/controller/calc_controller.dart';
import 'package:flutter_project_calculator/widgets/button_widget.dart';
import 'package:get/get.dart';

class CalcPage extends StatelessWidget {
  const CalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalcController());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                controller.previousNumber.value,
                style: const TextStyle(color: Colors.white54, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Text(
                '${controller.number1.value}${controller.arithmetic.value}${controller.number2.value}',
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
      ),
    );
  }
}
