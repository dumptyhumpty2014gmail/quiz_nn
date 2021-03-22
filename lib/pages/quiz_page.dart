import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question.dart';
import '../models/share_style.dart';
// import 'package:my_flutter_app_test/widgets/answer_button.dart';
import '../widgets/progress_bar1.dart';
import '../widgets/quiz.dart';
import '../widgets/result.dart';

class QuizPage extends StatefulWidget {
  final QuestionData data;
  QuizPage({Key key, this.data}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();
}

//@JsonSerializable()
class _QuizPageState extends State<QuizPage> {
  // QuestionData data = QuestionData();
  int _countResult = 0;
  int _questionIndex = 0;
  List<Icon> _icon = [];
  int _achievements = 0;
  var _now = DateTime.now();
  @override
  void initState() {
    loadStateFromPref();
    super.initState();
  }//..
  // void _clearState() => setState(() {
  //       _questionIndex = 0;
  //       _countResult = 0;
  //       _icon = [];
  //     });

  //Map<String, dynamic> toJson() => _$_QuizPageStateToJson(this);

  void saveStateToPref() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('countResult', _countResult);
    // prefs.setInt('questionIndex', _questionIndex);
    // prefs.setInt('achievements', _achievements);
    //prefs.set('icon', _icon);
    //print(widget.data.keyTitle);
    var mapToJson = Map();

    mapToJson['countResult'] = _countResult;
    mapToJson['questionIndex'] = _questionIndex;
    mapToJson['achievements'] = _achievements;
    mapToJson['now'] = _now.toString();
    // print(_now);

    var iconToString = [];
    for (var oneIcon in _icon) {
      if (oneIcon.icon == badIconAnswer) {
        iconToString.add('bad');
        //print('bad');
      } else {
        iconToString.add('good');
      }
    }
    mapToJson['icon'] = iconToString;
    String mapToString = jsonEncode(mapToJson);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(widget.data.keyTitle, mapToString);
    // здесь записываем строку
    // var quizMap = jsonDecode(mapToString);
    // for (var item in quizMap.entries) {
    //   //print(item.key);
    //   if (item.key == 'now') {print(DateTime.parse(item.value));}
    // }
    // String icons = jsonEncode(iconToString);
    //print(icons);
    // var iconList = jsonDecode(icons);
    // for (var oneIcon in iconList) {
    //   print(oneIcon);
    // }
  }

  void loadStateFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.data.keyTitle)) {
      // значит уже заходили сюда и нужно состояние восстановить или написать, что уже проходили один раз, так что сбрасывайте прогресс
      setState(() {
        var quizMap = jsonDecode(prefs.getString(widget.data.keyTitle));
        //print(quizMap['countResult']);
        _countResult = quizMap['countResult'] ?? 0;
        //print(quizMap['questionIndex']);
        _questionIndex = quizMap['questionIndex'] ?? 0;
        //print('achievements');
        _achievements = quizMap['achievements'] ?? 0;
        _now = DateTime.parse(quizMap['now'] ?? 0);
        //print(_now);
        var iconList = quizMap['icon'];
        _icon = [];
        for (var item in iconList) {
          //print(item);
          if (item == 'bad') {
            _icon.add(Icon(badIconAnswer, color: Colors.green));
          } else if (item == 'good') {
            _icon.add(Icon(goodIconAnswer, color: Colors.redAccent));
          }
        }
        // for (var item in quizMap.entries) {
        //print(item.key);
        //  if (item.key == 'now') {print(DateTime.parse(item.value));}
        // }
      });
    } else {
      //print('Нет');
      saveStateToPref();
    }
  }

  void _onChangeAnswer(bool isCorrect) => setState(() {
        if (isCorrect) {
          _icon.add(Icon(goodIconAnswer, color: Colors.redAccent));
          _countResult++;
          _achievements += 5;
        } else {
          _icon.add(Icon(badIconAnswer, color: Colors.green));
        }
        _questionIndex += 1;
        var now1 = DateTime.now();
        // print(widget.data.timeForAnswer - now1.difference(this._now).inMilliseconds~/1000);
        // print(widget.data.timeForAnswer);
        // print((now1.difference(this._now).inMilliseconds/1000).round());
        if (((now1.difference(this._now).inMilliseconds / 1000).round() <
                widget.data.timeForAnswer) &
            isCorrect) {
          // _achievements += widget.data.timeForAnswer - (now1.difference(this._now).inMilliseconds/1000).round();
          _achievements += widget.data.timeForAnswer -
              now1.difference(this._now).inMilliseconds ~/ 1000;
        }
        //setState(() {
        _now = now1;
        //});
        saveStateToPref();
      });
// loadStateFromPref();
  Widget _getQuizOrResult(index, total) {
    return index < total
        ? Quiz(
            index: _questionIndex,
            questionData: widget.data,
            onChangeAnswer: _onChangeAnswer,
          )
        : Result(
            count: _countResult,
            total: widget.data.dataAnswer.length,
            // onClearState: _clearState,
            curQuiz: widget.data,
          );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.data.title),
            automaticallyImplyLeading: false,
          ),
          body: DefaultTextStyle.merge(
            style: whiteTextStyle1,
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: const Color(0xff2a375a),
                image: DecorationImage(
                  image: AssetImage('assets/images/quiz_nn1.png'),
                  fit: BoxFit.contain,
                  // repeat: ImageRepeat.repeat,
                ),
              ),
              child: ListView(
                children: [
                  ProgressBar1(
                    icons: _icon,
                    count: _questionIndex,
                    total: widget.data.dataAnswer.length,
                    achievement: _achievements,
                    questionIndex: _questionIndex,
                  ),
                  _getQuizOrResult(
                      _questionIndex, widget.data.dataAnswer.length)
                ],
              ),
            ),
          )),
    );
  }
}
