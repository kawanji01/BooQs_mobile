import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLogoutButton extends ConsumerStatefulWidget {
  const UserLogoutButton({Key? key}) : super(key: key);

  @override
  UserLogoutButtonState createState() => UserLogoutButtonState();
}

class UserLogoutButtonState extends ConsumerState<UserLogoutButton> {
  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();
    // ログアウトボタン
    return InkWell(
      onTap: () async {
        // 画面全体にローディングを表示
        EasyLoading.show(status: 'loading...');
        await RemoteSessions.logout();
        await UserSetup.logOut(user);
        ref.read(currentUserProvider.notifier).updateUser(null);
        /* ref.read(answerSettingProvider.notifier).state = null;
        ref.read(todaysAnswersCountProvider.notifier).state = 0;
        ref.read(todaysCorrectAnswersCountProvider.notifier).state = 0; */
        // ref.invalidate(asyncCurrentUserProvider);
        // ローディングを消す
        EasyLoading.dismiss();
        if (!mounted) return;
        final snackBar = SnackBar(content: Text(t.sessions.log_out_succeeded));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        HomePage.push(context);
      },
      child: LargeGreenButton(label: t.sessions.log_out, icon: Icons.logout),
    );
  }
}
