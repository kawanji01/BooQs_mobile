import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizAnswersCount extends ConsumerWidget {
  const QuizAnswersCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int todaysAnswersCount = ref.watch(todaysAnswersCountProvider);
      // １０問解答ごとに画面上端に通知を表示する。
      if (todaysAnswersCount % 10 == 0) {
        showFlash(
          context: context,
          duration: const Duration(seconds: 2),
          builder: (context, controller) {
            // ref: https://resocoder.com/2021/01/30/snackbar-toast-dialog-in-flutter-flash-package/
            // ref: https://itnext.io/highly-customizable-toast-dialog-snackbar-in-flutter-2c27e533dd63
            return Flash(
              controller: controller,
              barrierDismissible: false,
              alignment: Alignment.topCenter,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Colors.black87,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "$todaysAnswersCount問解答",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      }
    });

    final int _todaysAnswersCount = ref.watch(todaysAnswersCountProvider);
    final int _todaysCorrectAnswersCount =
        ref.watch(todaysCorrectAnswersCountProvider);
    final int _dailyGoalCount = ref.watch(
            answerSettingProvider.select((setting) => setting!.dailyGoal)) ??
        30;

    // 通常モードで表示する解答数
    Widget _answersCount() {
      String message = '';
      if (_dailyGoalCount < _todaysAnswersCount) {
        message = '$_todaysAnswersCount問解答';
      } else {
        final int remainedCount = _dailyGoalCount - _todaysAnswersCount;
        message = '目標まで残り$remainedCount問';
      }
      return Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      );
    }

    // 厳格解答モードで表示する解答数
    Widget _correctAnswersCount() {
      String message = '';
      if (_dailyGoalCount < _todaysCorrectAnswersCount) {
        message = '$_todaysAnswersCount問正解';
      } else {
        final int remainedCount = _dailyGoalCount - _todaysCorrectAnswersCount;
        message = '目標まで残り$remainedCount問正解';
      }
      return Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      );
    }

    Widget _answersCountInformation() {
      final bool strictSolvingMode = ref.watch(strictSolvingModeProvider);
      if (strictSolvingMode) {
        return _correctAnswersCount();
      }
      return _answersCount();
    }

    return Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: _answersCountInformation());
  }
}
