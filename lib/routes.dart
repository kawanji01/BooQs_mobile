import 'package:booqs_mobile/pages/dictionary/search_en_ja.dart';
import 'package:booqs_mobile/pages/flashcard/create.dart';
import 'package:booqs_mobile/pages/flashcard/edit.dart';
import 'package:booqs_mobile/pages/flashcard/edit_card.dart';
import 'package:booqs_mobile/pages/flashcard/play.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notification/index.dart';
import 'package:booqs_mobile/pages/reminder/index.dart';
import 'package:booqs_mobile/pages/user/login.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/pages/user/sign_up.dart';

const indexPage = '/';
const flashcardCreatePage = '/flashcard/create';
const flashcardEditPage = '/flashcard/edit';
const flashcardCardEditPage = '/flashcard/edit-card';
const flashcardPlayPage = '/flashcard/play';

// new
const searchEnJaPage = '/dictionary/search_en_ja';
const reminderIndexPage = '/reminder/index';
const notificationIndexPage = '/notification/index';
const userMyPage = '/user/mypage';
const signUpPage = '/user/sign_up';
const loginPage = '/user/login';

final routes = {
  indexPage: (context) => const MyHomePage(),
  flashcardCreatePage: (context) => const CreateFlashcardPage(),
  flashcardEditPage: (context) => const EditFlashcardPage(),
  flashcardCardEditPage: (context) => const EditFlashcardCardPage(),
  flashcardPlayPage: (context) => const FlashcardPlayPage(),
  // New
  searchEnJaPage: (context) => const SearchEnJaPage(),
  reminderIndexPage: (context) => const ReminderIndexPage(),
  notificationIndexPage: (context) => const NotificationIndexPage(),
  userMyPage: (context) => const UserMyPage(),
  signUpPage: (context) => const SignUpPage(),
  loginPage: (context) => const LoginPage(),
};
