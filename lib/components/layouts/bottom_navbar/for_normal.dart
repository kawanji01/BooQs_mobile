import 'package:booqs_mobile/components/layouts/bottom_navbar/account_icon.dart';
import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/chapter/index.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:booqs_mobile/pages/review/index.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/review_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbarForNormal extends ConsumerWidget {
  const BottomNavbarForNormal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String dictionary = t.layouts.dictionary;
    final String review = t.layouts.review;
    final String wordList = t.layouts.word_list;
    final String myPage = t.layouts.my_page;

    int selectedIndex = ref.watch(bottomNavbarState);
    // 教室プラン加入者がログアウトする時、マイページのindexが4になることによって発生するエラーを防ぐ。
    if (selectedIndex > 3) {
      selectedIndex = 3;
    }

    // 参考：https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
    void onItemTapped(int index) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      // ローディングがあれば消す
      EasyLoading.dismiss();
      switch (index) {
        case 0:
          HomePage.push(context);
          break;
        case 1:
          ChapterIndexPage.push(context);
          break;
        case 2:
          ReviewIndexPage.pushReplacement(context);
          break;
        case 3:
          UserMyPage.push(context);
          break;
      }
      ref.read(bottomNavbarState.notifier).state = index;
    }

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          label: dictionary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.text_format),
          label: wordList,
        ),
        BottomNavigationBarItem(
          icon: const BottomNavbarReviewIcon(),
          label: review,
        ),
        BottomNavigationBarItem(
          icon: const BottomNavbarAccountIcon(),
          label: myPage,
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.green[800],
      type: BottomNavigationBarType.fixed,
      onTap: onItemTapped,
    );
  }
}
