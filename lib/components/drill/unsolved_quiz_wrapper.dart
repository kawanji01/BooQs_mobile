import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/components/drill/quiz_header.dart';
import 'package:booqs_mobile/components/quiz/item/answer_part.dart';
import 'package:booqs_mobile/components/quiz/item/question_part.dart';
import 'package:booqs_mobile/components/quiz/unsolved_item.dart';
import 'package:booqs_mobile/components/quiz/item/unsolved_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedQuizWrapper extends ConsumerWidget {
  const DrillUnsolvedQuizWrapper({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = quiz.drill;
    final Review? review = quiz.review;

    final header = DrillQuizHeader(quiz: quiz);
    final question = QuizItemQuestionPart(quiz: quiz, drill: drill!);
    final answer = QuizItemAnswerPart(
      quiz: quiz,
      unsolved: true,
    );
    final footer = QuizItemUnsolvedFooter(quiz: quiz, review: review);

    // 解答時に問題をフェイドアウトする際にリビルドされてレイアウトが崩れるのを防ぐために、外部からwidgetを渡す
    // ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
    return QuizUnsolvedItem(
        quiz: quiz,
        header: header,
        question: question,
        answer: answer,
        footer: footer);
  }
}
