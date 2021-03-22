import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// список викторин 1 Историческая типа вопрос-ответ 2 По сувенирам? вопрос-ответ (маленькая)
// 3 по дотстопримечательностям (фото - слово из букв) 4 достопримечательности вопрос-ответ
// собери картинку а еще по области
final goodIconAnswer = Icons.wb_sunny; //Icons.favorite;
final badIconAnswer = Icons.adb;

final listOfQuiz = [
  QuestionData(
    title: 'История Нижнего Новгорода',
    keyTitle: 'history_nn',
    dataAnswer: dataHistory,
    timeForAnswer: 30,
  ),
  QuestionData(
    title: 'Нижегородская область',
    keyTitle: 'region_nn',
    dataAnswer: dataRegion,
    timeForAnswer: 30,
  ),
];

class Question {
  final String title;
  final List<Map> answers;

  Question({@required this.title, @required this.answers});
}

class QuestionData {
  final String title;
  final String keyTitle;
  final List<Question> dataAnswer;
  final int timeForAnswer;

  QuestionData({
    @required this.title,
    @required this.keyTitle,
    @required this.dataAnswer,
    @required this.timeForAnswer,
  });

  List<Question> get question =>
      [...dataAnswer]; //геттер, который возвращает новый список вопросов
}

final dataHistory = [
  Question(title: 'В каком году был основан Нижний Новгород', answers: [
    {
      'answer': 'В 1312 году',
    },
    {'answer': 'В 1221 году', 'isCorrect': 1},
    {
      'answer': 'В 1213 году',
    },
    {
      'answer': 'В 1321 году',
    },
  ]),
  Question(
      title: 'На слиянии каких рек расположился Нижний Новгород',
      answers: [
        {
          'answer': 'Реки Кама и Белая',
        },
        {'answer': 'Реки Ока и Волга', 'isCorrect': 1},
        {
          'answer': 'Реки Которосль и Волга',
        },
        {
          'answer': 'Реки Волга и Дон',
        },
      ]),
  Question(title: 'Символ Нижнего Новгорода', answers: [
    {
      'answer': 'Бурый медведь',
    },
    {
      'answer': 'Рыжая лиса',
    },
    {
      'answer': 'Серебряный орлан',
    },
    {'answer': 'Красный олень', 'isCorrect': 1},
  ]),
  Question(title: 'Житель Нижнего Новгорода', answers: [
    {'answer': 'Нижегородец', 'isCorrect': 1},
    {
      'answer': 'Нижненовгородец',
    },
    {
      'answer': 'Новгородец',
    },
    {
      'answer': 'Нижненовец',
    },
  ]),
  // Как называются жители Нижнего Новгорода? (нижегородцы)
];

final dataRegion = [
  Question(title: 'Город-спутник, в котором есть стекольный завод', answers: [
    {
      'answer': 'Кстово',
    },
    {
      'answer': 'Богородск',
    },
    {'answer': 'Бор', 'isCorrect': 1},
    {
      'answer': 'Дзержинск',
    },
  ]),
  Question(
      title: 'Озеро в области, в котором, по легенде, находится город Китеж',
      answers: [
        {
          'answer': 'Пырское',
        },
        {'answer': 'Светлояр', 'isCorrect': 1},
        {
          'answer': 'Большое святое',
        },
        {
          'answer': 'Белое',
        },
      ]),
];
