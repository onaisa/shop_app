import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/usermodel.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? usermodel;
  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoudingState());
    await DioHelper.postData(url: 'register', data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
    }).then((value) {
      // print(value.data);

      usermodel = UserModel.fromJson(value.data);
      print(usermodel!.message);
      print(usermodel!.status);
      if (usermodel!.status == true) {
        print(usermodel!.data!.token);
      }
      emit(RegisterSucessState(usermodel!));
    }).catchError((error) {
      emit(RegisterErorrState(message: error.toString()));
      print(error.toString());
    });
  }
}
