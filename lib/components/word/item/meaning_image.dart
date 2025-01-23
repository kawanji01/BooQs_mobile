import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemMeaningImage extends StatelessWidget {
  const WordItemMeaningImage({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    final String? meaningImageUrl = word.meaningImageUrl;
    if (meaningImageUrl == null || meaningImageUrl == '') {
      return Container();
    }
    return Container();
    // return Container(
    //   padding: const EdgeInsets.symmetric(vertical: 16),
    //   child: Center(
    //     child: CachedNetworkImage(
    //       imageUrl: meaningImageUrl,
    //       placeholder: (context, url) => const CircularProgressIndicator(),
    //       errorWidget: (context, url, error) => const Icon(Icons.error),
    //     ),
    //   ),
    // );
  }
}
