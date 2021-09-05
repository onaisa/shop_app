import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/usermodel.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? usermodel;
  void userlogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoudingState());
    await DioHelper.postData(url: 'login', data: {
      'email': "$email",
      'password': "$password",
    }).then((value) {
      // print(value.data);

      usermodel = UserModel.fromJson(value.data);
      print(usermodel!.message);
      print(usermodel!.status);
      if (usermodel!.status == true) {
        print(usermodel!.data!.token);
      }
      emit(LoginSucessState(usermodel!));
    }).catchError((error) {
      emit(LoginErorrState(message: error.toString()));
      print(error.toString());
    });
  }
}
