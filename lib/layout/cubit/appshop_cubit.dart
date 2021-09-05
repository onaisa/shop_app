import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/categoeiesmodel.dart';
import 'package:shop_app/models/changefavmodel.dart';
import 'package:shop_app/models/favoritesmodel.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/modules/categories/categoriesscreen.dart';
import 'package:shop_app/modules/favorites/favoritesscreen.dart';
import 'package:shop_app/modules/products/produtsscreen.dart';
import 'package:shop_app/modules/setting/settingscreen.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'appshop_state.dart';

class AppshopCubit extends Cubit<AppshopState> {
  AppshopCubit() : super(AppshopInitial());
  static AppshopCubit get(context) => BlocProvider.of(context);
  Map<int, bool> isfavorites = {};
  Map<int, bool> isCart = {};

  List screens = [
    ProducScreen(),
    CategoriseScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
  int currenIndex = 0;

  void changCurrenIndex(int index) {
    currenIndex = index;
    emit(ChangeBottomNaviState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      homeModel!.data.products.forEach((element) {
        isfavorites.addAll({element.id: element.inFav});
      });
      homeModel!.data.products.forEach((element) {
        isCart.addAll({element.id: element.inCart});
      });

      emit(ShopSucssesHomeDataState(homeModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErroeHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      // print(" categories is ${categoriesModel!.data!.categories[0].name}");
      emit(ShopSucessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
      print(error.toString());
    });
  }

  GetFavModel? favoretesModel;
  void getFavorets() {
    emit(ShopLoadingFavoretState());
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favoretesModel = GetFavModel.fromJson(value.data);
      print(" favorites is ${favoretesModel!.status}");

      emit(ShopSucessFavoretState());
    }).catchError((error) {
      emit(ShopErrorFavoretState());
      print(error.toString());
    });
  }

  ChangeFavoriteorcartModel? changeFavoriteModel;
  void changFavorites(int productId) {
    isfavorites[productId] = !isfavorites[productId]!;
    emit(ShopLoadingChangeFavoretState());
    DioHelper.postData(
      url: 'favorites',
      token: token,
      data: {'product_id': productId},
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteorcartModel.fromJson(value.data);
      print('changefavorites is ${changeFavoriteModel!.status}');
      if (changeFavoriteModel!.status == false) {
        isfavorites[productId] = !isfavorites[productId]!;
      } else {
        getFavorets();
      }
      emit(ShopSucessChangeFavoretState(changeFavoriteModel!));
    }).catchError((error) {
      isfavorites[productId] = !isfavorites[productId]!;
      emit(ShopErrorChangeFavoretState());
      print(error.toString());
    });
  }

  ChangeFavoriteorcartModel? changeCartModel;
  void changCart(int productId) {
    isCart[productId] = !isCart[productId]!;
    emit(ShopLoadingChangeCartState());
    DioHelper.postData(
      url: 'carts',
      token: token,
      data: {'product_id': productId},
    ).then((value) {
      changeCartModel = ChangeFavoriteorcartModel.fromJson(value.data);
      print('changcartfavorites is ${changeCartModel!.status}');
      if (changeCartModel!.status == false) {
        isCart[productId] = !isCart[productId]!;
      } else {
        // getFavorets();
      }
      emit(ShopSucessChangeCartState(changeCartModel!));
    }).catchError((error) {
      isCart[productId] = !isCart[productId]!;
      emit(ShopErrorChangeCartState());
      print(error.toString());
    });
  }
}
