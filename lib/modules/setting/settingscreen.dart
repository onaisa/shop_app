import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';

import 'package:shop_app/modules/setting/cubit/profile_cubit.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phonController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  bool isscure = false;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileCubit()..getprofile(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSucsessState) {
              if (state.profilmodel.status == true) {
                CacheHelper.savedata(
                        key: 'token', value: state.profilmodel.data!.token)
                    .then((value) {
                  if (value) {
                    token = state.profilmodel.data!.token!;
                    MyToast(
                        msg: state.profilmodel.message!,
                        state: toaststate.sucsses);
                  }
                });
              } else {
                MyToast(
                    msg: state.profilmodel.message!, state: toaststate.error);
              }
            }
          },
          builder: (context, state) {
            ProfileCubit proCubit = ProfileCubit.get(context);

            if (proCubit.profilmodel == null ||
                state is UpdateProfileLodingState) {
              return Center(child: CircularProgressIndicator());
            } else if (proCubit.profilmodel!.data == null) {
              return Center(
                  child: Column(
                children: [
                  Container(
                    height: 40.0,
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: () {
                        proCubit.getprofile();
                      },
                      child: Text(
                        "..please try agen..",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ));
            } else {
              usernamecontroller.text = proCubit.profilmodel!.data!.name!;

              phonController.text = proCubit.profilmodel!.data!.phone!;
              emailController.text = proCubit.profilmodel!.data!.email!;
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SETTING',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
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
                            DefoaltTextFormFiled(
                              texttype: TextInputType.visiblePassword,
                              preicon: Icon(Icons.lock),
                              label: 'password',
                              validate: 'plase enter password',
                              controller: passwordController,
                              suficon: IconButton(
                                  onPressed: () {},
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
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    proCubit.updateProfile(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phonController.text,
                                        name: usernamecontroller.text);
                                  }
                                },
                                child: Text(
                                  'update',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: FloatingActionButton(
                                onPressed: () {
                                  signOut(context);
                                },
                                child: Icon(
                                  Icons.logout,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              );
            }
            ;
          },
        ));
  }
}
