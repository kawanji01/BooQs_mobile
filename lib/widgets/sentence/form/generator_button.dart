import 'package:booqs_mobile/widgets/sentence/form/generator_screen.dart';
import 'package:flutter/material.dart';

class SentenceFormGeneratorButton extends StatefulWidget {
  const SentenceFormGeneratorButton(
      {Key? key,
      required this.langNumber,
      required this.originalController,
      required this.keyword})
      : super(key: key);
  final int langNumber;
  final TextEditingController originalController;
  final String? keyword;

  @override
  State<SentenceFormGeneratorButton> createState() =>
      _SentenceFormGeneratorButtonState();
}

class _SentenceFormGeneratorButtonState
    extends State<SentenceFormGeneratorButton> {
  final _keywordController = TextEditingController();
  final _temperatureController = TextEditingController();

  @override
  void initState() {
    _keywordController.text = widget.keyword ?? '';
    _temperatureController.text = '7';
    super.initState();
  }

  @override
  void dispose() {
    _keywordController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () => {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            // showModalBottomSheetで表示される中身
            builder: (context) => SentenceFormGeneratorScreen(
                  langNumber: widget.langNumber,
                  originalController: widget.originalController,
                  keywordController: _keywordController,
                  temperatureController: _temperatureController,
                ))
      },
      icon: const Icon(Icons.auto_fix_high, color: Colors.white),
      label: const Text(
        'AIで例文を生成する',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
