import 'package:booqs_mobile/components/dictionary_map/radio_list.dart';
import 'package:booqs_mobile/components/dictionary_map/search_form.dart';
import 'package:flutter/material.dart';

class DictionaryMapSearchScreen extends StatelessWidget {
  const DictionaryMapSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('DictionaryMapSearchScreen'),
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          const DictionaryMapSearchForm(),
          // FlutterでRenderFlex overflowedのエラーが発生するとき、それは通常、フレックスボックス（Row、Column、Flex）内のウィジェットが利用可能なスペースを超えて拡大しようとしたときに発生する。
          // この場合、画面からはみ出すフレックスボックスの小要素をExpandedをwrapすると解決できる。
          Expanded(
            child: GestureDetector(
              onTap: () {
                // キーボードを閉じる
                FocusScopeNode currentFocus = FocusScope.of(context);
                // フォーカスがすでにない状況でunfocus()を呼び出すと、エラーが発生する可能性がある
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: const DictionaryMapRadioList(),
            ),
          ),
        ],
      ),
    );
  }
}
