import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/sarechmodel.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void getSearch(String text) {
    emit(GetSearchLoudingState());

    DioHelper.postData(
        url: 'products/search',
        token: token,
        data: {"text": text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print('search is ${searchModel!.status}');

      emit(GetSearchSucessesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }

  // void finishSearch(List list) {
  //   list.clear();
  //   emit(FinishSearchState());
  // }
}
