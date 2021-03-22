import 'package:flutter/material.dart';

import 'answer_button.dart';

class Quiz extends StatelessWidget {
  final index;
  final questionData;
  final onChangeAnswer;
  Quiz({Key key, this.index, this.questionData, this.onChangeAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          // alignment: Alignment.center,
          child: Text(
            questionData.question[index].title,
            textAlign: TextAlign.center,
            // style: Theme.of(context).textTheme.caption,
          ),
        ),
        // AnswerType1(),
        Wrap(
            direction: Axis
                .horizontal, // направление. при вертикальном, если не будут убираться, то появится столбец дополнительный horizontal
            spacing: 10, // пробелы между для направления
            runSpacing:
                10, // пробелы между чайлдами для не основного направления
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              ...questionData.dataAnswer[index].answers
                  .map((e) => AnswerType1(
                        title: e['answer'],
                        isCorrect: e.containsKey('isCorrect') ? true : false,
                        onChangeAnswer: onChangeAnswer,
                      ))
                  .toList(),
            ])
      ],
    );
  }
}
