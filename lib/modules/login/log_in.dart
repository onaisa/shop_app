import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/models/usermodel.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/regester/regester.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';


class LogIn extends StatefulWidget {
  LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isscure = false;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSucessState) {
            if (state.userModel.status == true) {
              CacheHelper.savedata(
                      key: 'token', value: state.userModel.data!.token)
                  .then((value) {
                if (value) {
                  token = state.userModel.data!.token!;

                  NavigateAndFinish(context, LayOutScreen());
                }
              });
            } else {
              MyToast(msg: state.userModel.message!, state: toaststate.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'login now to browse our hot offers',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefoaltTextFormFiled(
                                texttype: TextInputType.emailAddress,
                                preicon: Icon(Icons.email),
                                label: 'email',
                                validate: 'plase enter email',
                                controller: emailController),
                            SizedBox(
                              height: 15.0,
                            ),
                            DefoaltTextFormFiled(
                              texttype: TextInputType.visiblePassword,
                              preicon: Icon(Icons.lock),
                              label: 'password',
                              validate: 'plase enter password',
                              controller: passwordController,
                              suficon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isscure = !isscure;
                                    });
                                  },
                                  icon: isscure
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                              ispassword: isscure,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                                height: 40.0,
                                width: double.infinity,
                                child: BlocBuilder<LoginCubit, LoginState>(
                                  builder: (context, state) {
                                    if (state is LoginLoudingState) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else
                                      return ElevatedButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            LoginCubit.get(context).userlogin(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                          }
                                        },
                                        child: Text(
                                          'LOGIN',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                  },
                                )),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Text('Don\'t have an account?',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                SizedBox(
                                  width: 5.0,
                                ),
                                TextButton(
                                  onPressed: () {
                                    gotonavigat(context, RegesterScreen());
                                  },
                                  child: Text(
                                    'Regester now',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
