import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/quiz/show.dart';
import 'package:flutter/material.dart';

class QuizDetailButton extends StatelessWidget {
  const QuizDetailButton({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      // 左寄せ
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black54,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          QuizShowPage.push(context, quiz.id);
        },
        child: const Text(
          '詳細',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
