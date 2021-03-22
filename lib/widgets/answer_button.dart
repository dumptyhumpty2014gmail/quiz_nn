import 'package:flutter/material.dart';
import '../models/share_style.dart';

class AnswerType1 extends StatelessWidget {
  final String title;
  final isCorrect;
  final Function onChangeAnswer;

  AnswerType1({Key key, this.title, this.isCorrect, this.onChangeAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChangeAnswer(isCorrect),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        // maxWidth: 300,
        constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                offset: Offset(1.0, 1.0),
              ),
            ],
            borderRadius: BorderRadius.circular(2.0),
            gradient: baseGradient1),
        child: Text(
          title,
          textAlign: TextAlign.center,
          // style: TextStyle(
          //   fontSize: 15.0,
          //   color: Colors.white,
          // ),
        ),
      ),
    );
  }
}
