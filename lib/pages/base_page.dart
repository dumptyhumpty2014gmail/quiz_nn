import 'package:flutter/material.dart';
import '../models/share_style.dart';
import '../pages/list_quizes.dart';
import '../widgets/base_button.dart';
//import 'package:quiz_nn/widgets/webview_tripster.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Викторины: города и страны'),
      ),
      backgroundColor: baseBackgroundColor,
      body: SingleChildScrollView(
        // backgroundColor: baseBackgroundColor,
        child: Container(
          // color: baseBackgroundColor,
          child: Center(
            child: Wrap(
              direction: Axis.horizontal, // направление. при вертикальном, если не будут убираться, то появится столбец дополнительный horizontal
              spacing: 10, // пробелы между для направления
              runSpacing: 10, // пробелы между чайлдами для не основного направления
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
              BaseButtonPage(title: 'Начать игру', toPage: ListQuizPage(),),  
              BaseButtonPage(title: 'Настройки', toPage: ListQuizPage(),),  
              BaseButtonPage(title: 'Об игре', toPage: ListQuizPage(),),
              // !кнопка выход SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              BaseButtonExit(title: 'Выход')
              // !!! виджет трипстера по НН на вебвью
              //WebViewExample(),
            ]),
          ),
        ),
      ),
    );
  }
}
