import 'package:booqs_mobile/data/provider/quiz.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/quiz/edit_button.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/answer.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/answer_analysis.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/distractors.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/explanation.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/question.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/note.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/word.dart';
import 'package:booqs_mobile/widgets/review/large_setting_button.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationScreen extends ConsumerStatefulWidget {
  const QuizExplanationScreen({Key? key, required this.answerNotification})
      : super(key: key);
  final AnswerNotification answerNotification;

  @override
  _QuizExplanationScreenState createState() => _QuizExplanationScreenState();
}

class _QuizExplanationScreenState extends ConsumerState<QuizExplanationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Quiz quiz = widget.answerNotification.quiz;
      ref.refresh(asyncQuizFamily(quiz.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final AnswerNotification _answerNotification = widget.answerNotification;
    final Quiz _quiz = _answerNotification.quiz;
    final future = ref.watch(asyncQuizFamily(_quiz.id));

    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    Widget _question() {
      return future.when(
        data: (data) => QuizExplanationQuestion(quiz: data!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationQuestion(quiz: _quiz),
      );
    }

    Widget _answer() {
      return future.when(
        data: (quiz) => QuizExplanationAnswer(quiz: quiz!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationAnswer(quiz: _quiz),
      );
    }

    Widget _distractors() {
      return future.when(
        data: (quiz) => QuizExplanationDistractors(quiz: quiz!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationDistractors(quiz: _quiz),
      );
    }

    // 復習
    Widget _reviewButton() {
      return future.when(
        data: (quiz) =>
            ReviewLargeSettingButton(quizId: _quiz.id, review: quiz!.review),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // 解説
    Widget _explanation() {
      return future.when(
        data: (quiz) => QuizExplanationExplanation(quiz: quiz!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationExplanation(quiz: _quiz),
      );
    }

    Widget _editButtons() {
      return future.when(
        data: (quiz) => QuizEditButton(
          quiz: quiz!,
          isShow: false,
        ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // 解答分析と弱点設定
    Widget _answerAnalysis() {
      return future.when(
        data: (quiz) => QuizExplanationAnswerAnalysis(quiz: quiz!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // ノート
    Widget _note() {
      return future.when(
        data: (quiz) => QuizExplanationNote(quiz: quiz!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // 出典（辞書と例文）
    Widget _word() {
      return future.when(
        data: (quiz) => QuizExplanationWord(quiz: quiz!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // keyboardにフォームが隠れないようにする。 ref: https://www.choge-blog.com/programming/flutter-keyboard-modalbottomsheet/
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // 80%の高さで表示させる
      child: SizedBox(
          height: height,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 24,
                  ),
                  _question(),
                  _answer(),
                  _distractors(),
                  _reviewButton(),
                  const SizedBox(height: 16),
                  _explanation(),
                  _editButtons(),
                  const SizedBox(height: 40),
                  _answerAnalysis(),
                  _note(),
                  const SizedBox(height: 56),
                  _word(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          )),
    );
  }
}
