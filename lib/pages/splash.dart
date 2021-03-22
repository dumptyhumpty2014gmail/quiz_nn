import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/share_style.dart';
import '../pages/base_page.dart';
// import 'package:flutter_navigator20/pages/home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);
  void _cupertinoDialog(context) {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Разрешить рекламным сетям использовать собранную информацию для персонализации рекламных обновлений'), // !!!! ссылку на страницу с GDPR
              actions: [
                CupertinoDialogAction(
                    child: Text('Да'),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isPolitic', true);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => BasePage()),
                          (Route<dynamic> route) => false
                          );
                    }),
                CupertinoDialogAction(
                    child: Text('Нет'),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isPolitic', false);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => BasePage()),
                          (Route<dynamic> route) => false
                          );
                    }),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    // !!!! нужно будет проверять, если первый запуск, то запускать страницу с выбором языка (на будущее, а пока политики достаточно
    // и ознакомлением  с политиокй конфиденциальности guessfairy
    // если не сохранено "Да" или "Нет" по политике конфиденциальности, то открываем диалоговое окно
    // но не запускаем переход через 1 секунду

    Future.delayed(Duration(seconds: 1), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('isPolitic')) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => BasePage()));
      } else {
        _cupertinoDialog(context);
      }
    });

    return Scaffold(
      backgroundColor: baseBackgroundColor,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/quiz_nn1.png'),
        ),
      ),
    );
  }
}
