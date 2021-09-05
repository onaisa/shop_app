import 'package:shop_app/modules/login/log_in.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

const LOGIN = 'login';
const REGISTER = 'register';

void signOut(context) {
  token = null;
  CacheHelper.removedata(key: 'token').then((value) {
    if (value) {
      NavigateAndFinish(context, LogIn());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
