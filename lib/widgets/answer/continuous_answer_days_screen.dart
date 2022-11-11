import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/audio_players_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/answer/share_button.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerContinuousAnswerDaysScreen extends ConsumerWidget {
  const AnswerContinuousAnswerDaysScreen(
      {Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 開始経験値（初期 + 問題集周回報酬 + 解答日数報酬）
    final int initialExp = answerCreator.startPoint +
        answerCreator.lapClearPoint +
        answerCreator.answerDaysPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.continuousAnswerDaysPoint;

    // 記録
    final int counter = answerCreator.continuousAnswerDaysCount ?? 0;

    // 効果音
    final bool seEnabled = ref.watch(seEnabledProvider);
    if (seEnabled) {
      AudioPlayersService.playContinousSound();
    }
    //
    Widget _heading() {
      return Text('$counter日連続解答',
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange));
    }

    Widget _twitterShareButton() {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();

      final String tweet = '$counter日連続で問題を解きました！！';
      final String url =
          '${DiQtURL.root(context)}/users/${user.publicUid}?continuous=$counter';
      return AnswerShareButton(text: tweet, url: url);
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            _heading(),
            ExpGainedExpIndicator(
              initialExp: initialExp,
              gainedExp: gainedExp,
            ),
            const SizedBox(height: 16),
            _twitterShareButton()
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
