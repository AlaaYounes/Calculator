import 'package:calculator/buttonItem.dart';
import 'package:calculator/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      resText!,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns in the grid
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: buttonList.length,
              itemBuilder: (BuildContext context, int index) {
                List<int> checkIndex = [3, 7, 11, 15, 18, 19, 23];

                /// trigonometric methods
                if (index == 0 || index == 1 || index == 21 || index == 22) {
                  return ButtonWidget(
                    text: buttonList[index].text,
                    onButtonClick: onTrigonometricClicked,
                  );
                }
                if (checkIndex.contains(index)) {
                  return ButtonWidget(
                    text: buttonList[index].text,
                    onButtonClick: onOperatorClicked,
                  );
                } else if (index == 20) {
                  return ButtonWidget(
                    text: buttonList[index].text,
                    onButtonClick: onEqualClicked,
                  );
                } else if (index == 3) {
                  return ButtonWidget(
                    text: buttonList[index].text,
                    onButtonClick: onClearClicked,
                  );
                } else if (index == 2) {
                  return ButtonWidget(
                      text: buttonList[index].text,
                      onButtonClick: onDeleteClicked);
                } else {
                  return ButtonWidget(
                    text: buttonList[index].text,
                    onButtonClick: onDigitClick,
                  );
                }
              },
              // shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String resText = '';

  void onDigitClick(String text) {
    print(text);
    resText = resText! + text;
    setState(() {});
  }

  String lhs = '';
  String operator = '';
  void onOperatorClicked(String clickedOperator) {
    print(clickedOperator);

    if (operator.isEmpty || resText != null) {
      lhs = resText!;
    } else {
      String rhs = resText!;
      lhs = calculate(lhs, operator, rhs);
    }
    operator = clickedOperator;
    resText = '';
    setState(() {});
  }

  void onTrigonometricClicked(String clickedOperator) {
    lhs = resText!;
    resText = calculateTrigonometric(clickedOperator, lhs);
    setState(() {});
  }

  String calculate(String lhs, String operator, String rhs) {
    double num1 = double.parse(lhs);
    double num2 = double.parse(rhs);
    double? result;
    if (operator == '+') {
      result = num1 + num2;
    } else if (operator == '-') {
      result = num1 - num2;
    } else if (operator == '*') {
      result = num1 * num2;
    } else if (operator == '/') {
      result = num1 / num2;
    } else if (operator == '%') {
      result = num1 % num2;
    }else if(operator == 'x^y'){
      result = pow(num1, num2) as double?;
    }
    print(result);
    setState(() {});
    return result.toString();
  }

  String calculateTrigonometric(String method, String lhs) {
    double num1 = double.parse(lhs);
    int num2 =int.parse(lhs);
    num1 = num1 * (3.14 / 180);
    double? result;
    if (method == 'Sin') {
      result = sin(num1);
    } else if (method == 'Cos') {
      result = cos(num1);
    }else if(method == 'Tan'){
      result = tan(num1);
    }else if(method == 'Sqrt'){
      result = sqrt(num2);
    }
    print(result);
    setState(() {});
    return result.toString();
  }

  void onEqualClicked(String text) {
    String rhs = resText!;
    resText = calculate(lhs, operator, rhs);
    lhs = '';
    operator = '';
    rhs = '';
    setState(() {});

  }

  void onClearClicked() {
    resText = '';
    print('resText: $resText');
    setState(() {});
  }

  void onDeleteClicked(text) {
    print('resText: $resText');

    if(resText.isNotEmpty) {
      resText = resText.substring(0, resText.length - 1);

      setState(() {

      });
    }
    print('resText: $resText');
  }
}
