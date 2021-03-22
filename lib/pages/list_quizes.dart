import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_nn/widgets/progress_bar1.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:quiz_nn/widgets/base_button.dart';
import '../models/question.dart';
import '../models/share_style.dart';
import '../pages/quiz_page.dart';

class ListQuizPage extends StatefulWidget {
  const ListQuizPage({Key key}) : super(key: key);

  @override
  _ListQuizPageState createState() => _ListQuizPageState();
}

class _ListQuizPageState extends State<ListQuizPage> {
  List<QuestionData> _listOfQuizs = [...listOfQuiz];
  Future<void> _clearProgress (context) async {
    // пробежаться по викторинам (группы?) и записать в префференс
    for (var quizone in listOfQuiz) {
    // var mapToJson = Map();

    // mapToJson['countResult'] = 0;
    // mapToJson['questionIndex'] = 0;
    // mapToJson['achievements'] = 0;
    // mapToJson['now'] = DateTime.now().toString();
    // // print(_now);

    // var iconToString = [];
    // mapToJson['icon'] = iconToString;
    // String mapToString = jsonEncode(mapToJson);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(quizone.keyTitle);

    }
    // обновить статус и а здесь для каждой кнопки придется обновлять статус, похоже... или через провайдер все таки делать
    // вернуться в конктекст
    //print(context as Element);
    //(context as Element).markNeedsBuild();
    setState(() {
    _listOfQuizs =[];     
    });
    setState(() {
    _listOfQuizs =[...listOfQuiz];     
    _listOfQuizs.shuffle();
    });
    Navigator.of(context).pop();
    
  }

  void _cupertinoDialog(context) {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Очистить текущие достижения?'),
              actions: [
                CupertinoDialogAction(
                  child: Text('Да'),
                  onPressed: () async {_clearProgress(context);},
                  isDestructiveAction: true,
                ),
                CupertinoDialogAction(
                    child: Text('Нет'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    //print('1');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Список викторин'),
      ),
      backgroundColor: baseBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
              direction: Axis
                  .horizontal, // направление. при вертикальном, если не будут убираться, то появится столбец дополнительный horizontal
              spacing: 10, // пробелы между для направления
              runSpacing:
                  10, // пробелы между чайлдами для не основного направления
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: _listOfQuizs
                  .map(
                    (quizone) => QuizButtonPage(
                        toPage: QuizPage(
                          data: quizone,
                        ),
                        quiz: quizone),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (context) => QuizPage(
                    //              data: quizone,
                    //             ),
                    //       ),
                    //     );
                    //     // Navigator.of(context).pushAndRemoveUntil(
                    //     //   MaterialPageRoute(builder: (BuildContext context) => QuizPage(data: quizone,)),
                    //     //   ModalRoute.withName('/'),
                    //     // );
                    //   },
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(
                    //       horizontal: 5.0,
                    //       vertical: 2.0,
                    //     ),
                    //     padding: const EdgeInsets.all(10.0),
                    //     width: double.infinity,
                    //     // maxWidth: 300,
                    //     constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
                    //     decoration: BoxDecoration(
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.black,
                    //             blurRadius: 10.0,
                    //             offset: Offset(1.0, 1.0),
                    //           ),
                    //         ],
                    //         borderRadius: BorderRadius.circular(2.0),
                    //         gradient: baseGradient1),
                    //     child: Text(
                    //       quizone.title,
                    //       textAlign: TextAlign.center,
                    //       style: whiteTextStyle1,
                    //     ),
                    //   ),
                    // ),
                  )
                  .toList()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cupertinoDialog(context);
        },
        tooltip: 'Очистить достижения?',
        child: Icon(
          Icons.cleaning_services,
          color: Colors.amber,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class QuizButtonPage extends StatefulWidget {
  // final String title;
  final Widget toPage;
  final QuestionData quiz;

  QuizButtonPage({Key key, this.toPage, this.quiz}) : super(key: key);

  @override
  _QuizButtonPageState createState() => _QuizButtonPageState();
}

class _QuizButtonPageState extends State<QuizButtonPage> {
  int _countResult = 0;

  int _questionIndex = 0;

  List<Icon> _icon = [];

  int _achievements = 0;

  @override
  void initState() {
    loadStateFromPref();
    super.initState();
  }
  
  void loadStateFromPref() async {
    //print('2');
    //print(widget.quiz.keyTitle);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.quiz.keyTitle)) {
      // значит уже заходили сюда и нужно состояние восстановить или написать, что уже проходили один раз, так что сбрасывайте прогресс
      setState(() {
        var quizMap = jsonDecode(prefs.getString(widget.quiz.keyTitle));
        _countResult = quizMap['countResult'] ?? 0;
        _questionIndex = quizMap['questionIndex'] ?? 0;
        _achievements = quizMap['achievements'] ?? 0;
        var iconList = quizMap['icon'];
        _icon = [];
        for (var item in iconList) {
          if (item == 'bad') {
            _icon.add(Icon(badIconAnswer, color: Colors.green));
          } else if (item == 'good') {
            _icon.add(Icon(goodIconAnswer, color: Colors.redAccent));
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _goToPage(context);
        // Navigator.of(context).push(
        //   _createRoute()
        //   // MaterialPageRoute(
        //   //   builder: (context) => toPage,
        //   // ),
        // );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0,
            ),
            padding: const EdgeInsets.all(5.0),
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
                borderRadius: BorderRadius.circular(5.0),
                gradient: baseGradient1),
            child: Column(
              children: [
                Text(
                  widget.quiz.title,
                  textAlign: TextAlign.center,
                  style: whiteTextStyle1Small,
                ),
                ProgressBar1(
                  icons: _icon,
                  count: _countResult,
                  questionIndex: _questionIndex,
                  total: widget.quiz.dataAnswer.length,
                  achievement: _achievements,
                ),
                // !!!! нужно и на каком остановился и на сколько правильных, а сейчас, на каком остановился только
                // !!!! при возврате не меняется ((( похоже нужно через provider делать все таки)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation) {
        return widget.toPage;
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation,
          Widget child) {
        return SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    );
  }

  _goToPage(BuildContext context) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SelectionScreen()),
    // );
    final result = await Navigator.of(context).push(_createRoute());
    loadStateFromPref();
// print(result);
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text("$result")));
  }
}
