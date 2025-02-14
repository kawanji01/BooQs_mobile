import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewHeading extends ConsumerWidget {
  const ReviewHeading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.alarm,
          color: Colors.black,
          size: 36.0,
        ),
      ),
      TextSpan(
          text:
              ' ${t.reviews.reviews}（${ref.watch(currentUserProvider.select((user) => user == null ? 0 : user.unsolvedReviewsCount))}）',
          style: const TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold))
    ]));
  }
}
