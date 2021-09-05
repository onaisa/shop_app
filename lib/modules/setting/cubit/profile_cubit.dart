import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/profilmodel.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  Profilmodel? profilmodel;
  void getprofile() {
    emit(GetProfileLodingState());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      profilmodel = Profilmodel.fromJson(value.data);
      print('profil is ${profilmodel!.status}');
      emit(GetProfileSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileErorrState());
    });
  }

  void updateProfile({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(UpdateProfileLodingState());
    DioHelper.putData(url: 'update-profile', token: token, data: {
      'email': "$email",
      'password': "$password",
      'phone': "$phone",
      'name': "$name",
    }).then((value) {
      profilmodel = Profilmodel.fromJson(value.data);
      print('update is ${profilmodel!.status}');
      emit(UpdateProfileSucsessState(profilmodel!));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateProfileErorrState(error.toString()));
    });
  }
}
