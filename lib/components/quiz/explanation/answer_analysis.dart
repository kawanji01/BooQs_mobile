import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/weakness/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationAnswerAnalysis extends ConsumerWidget {
  const QuizExplanationAnswerAnalysis({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    final Weakness? weakness = quiz.weakness;

    Widget answersCount() {
      if (answerAnalysis == null) {
        return const Text('まだ解答したことがありません。', style: TextStyle(fontSize: 16));
      }
      final int answersCount = answerAnalysis.answerHistoriesCount;
      const label = Text(
        '回数数： ',
        style: TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );

      final value = Text(
        '$answersCount回',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [label, value],
      );
    }

    Widget incorrectAnswersCount() {
      if (answerAnalysis == null) {
        return Container();
      }
      final int incorrectAnswersCount =
          answerAnalysis.incorrectAnswerHistoriesCount;
      const label = Text(
        '間違えた回数： ',
        style: TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );
      final value = Text(
        '$incorrectAnswersCount回',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [label, value],
      );
    }

    Widget correctAnswerRate() {
      if (answerAnalysis == null) {
        return Container();
      }
      final double correctAnswerRate = answerAnalysis.correctAnswerRate;
      Color color = Colors.blue;
      if (correctAnswerRate < 50) {
        color = Colors.red;
      }

      final label = Text(
        '${t.answerAnalyses.correct_answer_rate}： ',
        style:
            TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
      );
      final value = Text(
        '$correctAnswerRate%',
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [label, value],
      );
    }

    Widget lastAnswerDate() {
      if (answerAnalysis == null) {
        return Container();
      }

      Color color = Colors.red;
      IconData icon = Icons.close;
      String lastAnswer = t.answerAnalyses.incorrect;
      if (answerAnalysis.lastAnswerCorrect) {
        color = Colors.blue;
        lastAnswer = t.answerAnalyses.correct;
        icon = Icons.circle_outlined;
      }
      final answerInfo = RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            icon,
            color: color,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' $lastAnswer', style: TextStyle(color: color, fontSize: 16))
      ]));

      final label = Text(
        '前回の解答： ',
        style:
            TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
      );
      final String answeredAt = DateTimeFormatter.createTimeAgoString(
          dateTime: answerAnalysis.lastAnsweredAt, locale: locale);

      final value = Text(
        '$answeredAtに ',
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
      );
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [label, value, answerInfo],
      );
    }

    return Column(
      children: [
        SharedItemLabel(
            text: t.answerAnalyses.answer_analyses,
            icon: Icons.analytics_outlined),
        const SizedBox(height: 8),
        answersCount(),
        const SizedBox(height: 4),
        incorrectAnswersCount(),
        const SizedBox(height: 4),
        correctAnswerRate(),
        const SizedBox(height: 4),
        lastAnswerDate(),
        const SizedBox(height: 8),
        WeaknessSettingButton(quizId: quiz.id, weakness: weakness),
        const SizedBox(height: 80),
      ],
    );
  }
}
