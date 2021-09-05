import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/modules/login/log_in.dart';
import 'package:shop_app/modules/regester/cubit/register_cubit.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegesterScreen extends StatefulWidget {
  RegesterScreen({Key? key}) : super(key: key);

  @override
  _RegesterScreenState createState() => _RegesterScreenState();
}

class _RegesterScreenState extends State<RegesterScreen> {
  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phonController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  bool isscure = false;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSucessState) {
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
                      'REGESTER',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'regester now to browse our hot offers',
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
                                texttype: TextInputType.name,
                                preicon: Icon(Icons.person),
                                label: 'user name',
                                validate: 'plase enter user name',
                                controller: usernamecontroller),
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
                                texttype: TextInputType.number,
                                preicon: Icon(Icons.phone),
                                label: 'phone',
                                validate: 'plase enter phone',
                                controller: phonController),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              height: 40.0,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: usernamecontroller.text,
                                        phone: phonController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                child: Text(
                                  'REGSTER',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Text("you have an account?",
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                SizedBox(
                                  width: 3.0,
                                ),
                                TextButton(
                                  onPressed: () {
                                    gotonavigat(context, LogIn());
                                  },
                                  child: Text(
                                    'login',
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
