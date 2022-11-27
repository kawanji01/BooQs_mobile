import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/widgets/answer_setting/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillAnswerSettingButton extends ConsumerWidget {
  const DrillAnswerSettingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 解答設定
    Future<void> moveToAnswerSetting() async {
      // bottomSheetを表示するときにインタラクションも消しておく
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        // showModalBottomSheetで表示される中身
        builder: (context) => const AnswerSettingScreen(
          primary: 'answerSetting',
        ),
      );
      ref.refresh(asyncDrillUnsolvedQuizzesProvider);
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        backgroundColor: const Color(0xfff3f3f4),
      ),
      onPressed: () => {moveToAnswerSetting()},
      icon: const Icon(
        Icons.settings,
        color: Colors.black54,
      ),
      label: const Text(
        ' 解答設定',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
      ),
    );
  }
}
