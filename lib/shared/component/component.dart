import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/appshop_cubit.dart';
import 'package:shop_app/models/favoritesmodel.dart';

void gotonavigat(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
}

void NavigateAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => Widget), (route) => false);
}

Widget DefoaltTextFormFiled({
  Widget? suficon,
  bool ispassword = false,
  required Widget preicon,
  required String label,
  required String validate,
  required TextEditingController controller,
  required TextInputType texttype,
}) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: TextFormField(
      keyboardType: texttype,
      obscureText: ispassword,
      controller: controller,
      validator: (String? value) {
        if (value!.isEmpty)
          return validate;
        else
          return null;
      },
      decoration: InputDecoration(
        suffixIcon: suficon,
        prefixIcon: preicon,
        labelText: label,
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget defaoltbuttom({
  required Widget text,
  required Function function,
}) {
  return ElevatedButton(
      onPressed: () {
        function;
      },
      child: text);
}

void MyToast({
  required String msg,
  required toaststate state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: selecttoastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
      gravity: ToastGravity.BOTTOM);
}

enum toaststate { sucsses, error, woring }
Color selecttoastColor(toaststate state) {
  Color color;
  switch (state) {
    case toaststate.error:
      color = Colors.red;
      break;
    case toaststate.woring:
      color = Colors.orange;
      break;
    case toaststate.sucsses:
      color = Colors.green;
      break;
  }
  return color;
}

Widget BuildProductItem(
        {required ProductModel model, required BuildContext context}) =>
    Container(
      height: 130.0,
      // color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image(
                image: NetworkImage(model.image!),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.3,
                    ),
                  ),
                  Row(children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ]),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            AppshopCubit.get(context).isfavorites[model.id] ==
                                    true
                                ? Colors.blue
                                : Colors.grey[200],
                        radius: 20.0,
                        child: IconButton(
                            onPressed: () {
                              AppshopCubit.get(context)
                                  .changFavorites(model.id!);
                              print(" id is ${model.id!}");
                            },
                            icon: Icon(Icons.favorite_border_outlined)),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        backgroundColor:
                            AppshopCubit.get(context).isCart[model.id] == true
                                ? Colors.green
                                : Colors.grey[200],
                        radius: 20.0,
                        child: IconButton(
                            onPressed: () {
                              AppshopCubit.get(context).changCart(model.id!);
                            },
                            icon: Icon(Icons.add_shopping_cart)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
