import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/appshop_cubit.dart';
import 'package:shop_app/models/favoritesmodel.dart';
import 'package:shop_app/modules/setting/cubit/profile_cubit.dart';
import 'package:shop_app/shared/component/component.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppshopCubit, AppshopState>(listener: (context, state) {
      if (state is ShopSucessChangeFavoretState) {
        if (state.changeFavoriteModel.status!) {
          MyToast(
              msg:
                  "${AppshopCubit.get(context).changeFavoriteModel!.message!} to favotites",
              state: toaststate.sucsses);
        } else {
          MyToast(
              msg:
                  "${AppshopCubit.get(context).changeFavoriteModel!.message!} to favprites",
              state: toaststate.woring);
        }
      }

      //cart oast
      if (state is ShopSucessChangeCartState) {
        if (state.changeCartModel.status!) {
          MyToast(
              msg:
                  "${AppshopCubit.get(context).changeFavoriteModel!.message!} to cart",
              state: toaststate.sucsses);
        } else {
          MyToast(
              msg:
                  "${AppshopCubit.get(context).changeFavoriteModel!.message!} to cart",
              state: toaststate.woring);
        }
      }
    }, builder: (context, state) {
      if (state is ShopLoadingFavoretState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ShopErrorFavoretState) {
        return Center(child: Text('can not get favorites'));
      } else
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return BuildProductItem(
                  context: context,
                  model: AppshopCubit.get(context)
                      .favoretesModel!
                      .data!
                      .favourites[index]!
                      .product!);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 2.0,
                color: Colors.grey,
              );
            },
            itemCount: AppshopCubit.get(context)
                .favoretesModel!
                .data!
                .favourites
                .length,
          ),
        );
    });
  }
}
