import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/appshop_cubit.dart';
import 'package:shop_app/modules/sarch/searchscreen.dart';
import 'package:shop_app/shared/component/component.dart';

class LayOutScreen extends StatelessWidget {
  LayOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppshopCubit layoutCubit = AppshopCubit.get(context);
    return BlocConsumer<AppshopCubit, AppshopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'salla',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  onPressed: () {
                    gotonavigat(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: layoutCubit.currenIndex,
              onTap: (int index) {
                layoutCubit.changCurrenIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'setting',
                ),
              ]),
          body: layoutCubit.screens[layoutCubit.currenIndex],
        );
      },
    );
  }
}
