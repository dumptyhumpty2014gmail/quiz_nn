import 'package:flutter/material.dart';
import 'package:quiz_nn/models/question.dart';

class ProgressBar1 extends StatelessWidget {
  final icons;
  final count;
  final total;
  final achievement;
  final questionIndex;

  ProgressBar1({Key key, 
  this.icons, 
  this.count, 
  this.total, this.achievement, this.questionIndex
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    // final badQuestion = questionIndex - count;
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '$achievement'
            )
          ),
          Icon(
            Icons.emoji_events,
            color: Colors.yellow
            ),
          SizedBox(width:5),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '$count'
            )
          ),
          Icon(
            goodIconAnswer,
            color: Colors.orange
            ),
          SizedBox(width:5),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '$questionIndex / $total'
            )
          ),

          SizedBox(width:5),

          ...icons,
        ]
      ),
    );
  }
}