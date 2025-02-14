import 'package:booqs_mobile/components/sentence/item.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SentenceListItem extends StatelessWidget {
  const SentenceListItem(
      {super.key, required this.sentence, required this.isShow});
  final Sentence sentence;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return SentenceItem(sentence: sentence, isShow: isShow);
  }
}
