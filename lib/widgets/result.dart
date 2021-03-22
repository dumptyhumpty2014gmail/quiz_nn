import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/share_style.dart';
//import '../pages/list_quizes.dart';

class Result extends StatelessWidget {
  final count;
  final total;
  // final Function onClearState;
  final curQuiz;
  
  Result({Key key, this.count, this.total, this.curQuiz, 
  // this.onClearState
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  void loadTableRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _achivements =0;
    if (prefs.containsKey(curQuiz.keyTitle)) {
        var quizMap = jsonDecode(prefs.getString(curQuiz.keyTitle));
        //_countResult = quizMap['countResult'] ?? 0;
        //print(quizMap['questionIndex']);
        //_questionIndex = quizMap['questionIndex'] ?? 0;
        //print('achievements');
        _achivements = quizMap['achievements'] ?? 0;
        //_now = DateTime.parse(quizMap['now'] ?? 0);
        //print(_now);
        // for (var item in quizMap.entries) {
        //print(item.key);
        //  if (item.key == 'now') {print(DateTime.parse(item.value));}
        // }
    }    
    if (prefs.containsKey('achiv_' + curQuiz.keyTitle)) {
        var recordsMap = jsonDecode(prefs.getString('achiv_' + curQuiz.keyTitle));
        for (var acivRecord in recordsMap) {

        }
    } else {
      //сразу занимаем первое место
    }
  }

    String msg;

    if (count < total) {
      msg = 'В следующий раз повезет!';
    } else {
      msg = 'Поздравляем! Отличный результат!';
    }
    // читаем таблицу рекордов для этой викторины
    // смотрим, какое место занимает текущий результат, меняем msg
    // если попадание в ТОП-10, то выводим "имя" в виде дата+время с возможностью изменить "Результат будет записан под именем:"
    // в процедуре "закончить" делаем запись (но нужно понимать, что мы перешли сюда сразу из списка викторин, чтобы одно и тоже не записывать несколько раз...)
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 15.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 5.0),
        )
      ],
      borderRadius: BorderRadius.circular(20.0),
      gradient: baseGradient1,
      ),
      child: Column(
        children: [
          Container(
            child: Text(
              msg,
              textAlign: TextAlign.center,
            ),
          ),
          Divider(color: Colors.white),
          Text('Верных ответов $count из $total'),
          Divider(color: Colors.white),
          TextButton(
            onPressed: () {
                Navigator.pop(
                  context,
                  'Result',
                  // MaterialPageRoute(
                  //   builder: (context) => ListQuizPage(
                  //       ),
                        
                  //   // maintainState: false,    
                  // ),
                );
            }, 
            child: Text(
              'Закончить',
              style: whiteTextStyle1,
              ),
          )
        ],
      ),
    );
  }
}