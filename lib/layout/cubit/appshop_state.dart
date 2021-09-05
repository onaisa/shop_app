part of 'appshop_cubit.dart';

@immutable
abstract class AppshopState {}

class AppshopInitial extends AppshopState {}

class ChangeBottomNaviState extends AppshopState {}

// home states
class ShopLoadingHomeDataState extends AppshopState {}

class ShopSucssesHomeDataState extends AppshopState {
  final HomeModel model;
  ShopSucssesHomeDataState(this.model);
}

class ShopErroeHomeDataState extends AppshopState {
  final String error;
  ShopErroeHomeDataState(this.error);
}

// categories states
class ShopLoadingCategoriesState extends AppshopState {}

class ShopSucessCategoriesState extends AppshopState {}

class ShopErrorCategoriesState extends AppshopState {}

// favaoreties state
class ShopLoadingFavoretState extends AppshopState {}

class ShopSucessFavoretState extends AppshopState {}

class ShopErrorFavoretState extends AppshopState {}

class ShopLoadingChangeFavoretState extends AppshopState {}

class ShopSucessChangeFavoretState extends AppshopState {
  final ChangeFavoriteorcartModel changeFavoriteModel;
  ShopSucessChangeFavoretState(this.changeFavoriteModel);
}

class ShopErrorChangeFavoretState extends AppshopState {}

// cartstates
class ShopLoadingChangeCartState extends AppshopState {}

class ShopSucessChangeCartState extends AppshopState {
  final ChangeFavoriteorcartModel changeCartModel;
  ShopSucessChangeCartState(this.changeCartModel);
}

class ShopErrorChangeCartState extends AppshopState {}
