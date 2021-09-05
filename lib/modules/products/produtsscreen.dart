import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/appshop_cubit.dart';
import 'package:shop_app/models/categoeiesmodel.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/shared/component/component.dart';

class ProducScreen extends StatelessWidget {
  const ProducScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppshopCubit, AppshopState>(
      listener: (context, state) {
        //favoreites toast
        if (state is ShopSucessChangeFavoretState) {
          if (state.changeFavoriteModel.status!) {
            MyToast(
                msg:
                    "${AppshopCubit.get(context).changeFavoriteModel!.message!} to favotites",
                state: toaststate.sucsses);
          } else {
            MyToast(
                msg:
                    "${AppshopCubit.get(context).changeFavoriteModel!.message!} to favprites",
                state: toaststate.woring);
          }
        }
        //cart oast
        if (state is ShopSucessChangeCartState) {
          if (state.changeCartModel.status!) {
            MyToast(
                msg:
                    "${AppshopCubit.get(context).changeFavoriteModel!.message!} to cart",
                state: toaststate.sucsses);
          } else {
            MyToast(
                msg:
                    "${AppshopCubit.get(context).changeFavoriteModel!.message!} to cart",
                state: toaststate.woring);
          }
        }
      },
      builder: (context, state) {
        AppshopCubit shopCubit = AppshopCubit.get(context);
        if (shopCubit.homeModel != null && shopCubit.categoriesModel != null) {
          return HomeWidget(
              homemodel: shopCubit.homeModel!,
              catmodel: shopCubit.categoriesModel!,
              context: context);
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}

Widget HomeWidget(
        {required HomeModel homemodel,
        required CategoriesModel catmodel,
        context}) =>
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homemodel.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              ' CATEGORIES',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      BuildCategoresItem(catmodel.data!.categories[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 20.0,
                      ),
                  itemCount: catmodel.data!.categories.length),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              ' PRODECTES',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 9.0,
            ),
            Container(
              color: Colors.grey[200],
              child: GridView.count(
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                    homemodel.data.products.length,
                    (index) => BuildGridProdectItem(
                        homemodel.data.products[index], context)),
              ),
            ),
          ],
        ),
      ),
    );

Widget BuildCategoresItem(DataModel model) => Container(
      height: 120.0,
      width: 120.0,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(image: NetworkImage(model.image!)),
          Container(
            width: 120.0,
            child: Text(
              model.name!,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
              maxLines: 1,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
            ),
            padding: EdgeInsets.symmetric(horizontal: 3.0),
          ),
        ],
      ),
    );

Widget BuildGridProdectItem(ProductModel productModel, context) => Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(productModel.image),
                  height: 150.0,
                  width: 150.0,
                ),
                if (productModel.discount != 0)
                  Container(
                    height: 25.0,
                    width: 70.0,
                    alignment: AlignmentDirectional.bottomStart,
                    child: Text(
                      'Discount',
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                      maxLines: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.7),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                  )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(children: [
                    Text(
                      '${productModel.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (productModel.discount != 0)
                      Text(
                        '${productModel.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ]),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppshopCubit.get(context)
                                    .isfavorites[productModel.id] ==
                                true
                            ? Colors.blue
                            : Colors.grey[200],
                        child: IconButton(
                            onPressed: () {
                              AppshopCubit.get(context)
                                  .changFavorites(productModel.id);
                              print(" id is ${productModel.id}");
                            },
                            icon: Icon(Icons.favorite_border_outlined)),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        backgroundColor:
                            AppshopCubit.get(context).isCart[productModel.id] ==
                                    true
                                ? Colors.green
                                : Colors.grey[200],
                        radius: 20.0,
                        child: IconButton(
                            onPressed: () {
                              AppshopCubit.get(context)
                                  .changCart(productModel.id);
                            },
                            icon: Icon(Icons.add_shopping_cart)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
