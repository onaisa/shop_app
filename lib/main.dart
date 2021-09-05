import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/layout/cubit/appshop_cubit.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/modules/login/log_in.dart';

import 'package:shop_app/modules/on_bording/onbourd_screen.dart';
import 'package:shop_app/shared/blocobserver.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  bool? onbording = true;
  //  CacheHelper.getBolean(key: 'onbording');
  token =
      "Qhd7iHG2BYkkvW1eDn0Nf0O0sKnf8ZN57sn129bKDHmwY5sdHEQKh4K7p2RhLE3WcY2sOM";
  // CacheHelper.getBolean(key: 'token');
  Widget startwidget = OnBordScreen();
  // print(token.toString());
  // print(onbording.toString());
  if (onbording != false) {
    if (token != null) {
      startwidget = LayOutScreen();
    } else {
      startwidget = LogIn();
    }
  } else {
    startwidget = OnBordScreen();
  }

  runApp(MyApp(startwidget));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;

  MyApp(this.startwidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppshopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorets(),
          ),
          // BlocProvider(
          //   create: (context) => ProfileCubit()..getprofile(),
          // ),
        ],
        child: BlocConsumer<AppshopCubit, AppshopState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: MyLigthThem,
              darkTheme: MyDarkThem,
              themeMode: ThemeMode.light,
              home: startwidget,
            );
          },
        ));
  }
}
