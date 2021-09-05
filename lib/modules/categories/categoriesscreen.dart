import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/appshop_cubit.dart';
import 'package:shop_app/models/categoeiesmodel.dart';

class CategoriseScreen extends StatelessWidget {
  CategoriseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppshopCubit, AppshopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildCatergoeriesItem(
                AppshopCubit.get(context)
                    .categoriesModel!
                    .data!
                    .categories[index]),
            separatorBuilder: (context, index) => Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
            itemCount: AppshopCubit.get(context)
                .categoriesModel!
                .data!
                .categories
                .length);
      },
    );
  }
}

Widget BuildCatergoeriesItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name!,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
