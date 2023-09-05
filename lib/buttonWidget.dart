import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String text;
  Function? onButtonClick;
  ButtonWidget({required this.text,this.onButtonClick});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onButtonClick!(text);
        },
        child: Text(
          '$text',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }
}
