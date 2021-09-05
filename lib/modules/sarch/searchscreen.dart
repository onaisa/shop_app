import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/appshop_cubit.dart';

import 'package:shop_app/models/sarechmodel.dart';
import 'package:shop_app/modules/sarch/cubit/search_cubit.dart';
import 'package:shop_app/shared/component/component.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchcontroller = TextEditingController();

  final FocusNode _focusnode = FocusNode();

  // @override
  // void dispose() {
  //   _focusnode.dispose();

  //   searchcontroller.clear();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit search = SearchCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    focusNode: _focusnode,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'earch must not be empty';
                      } else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      SearchCubit.get(context).getSearch(value);
                    },
                    // onChanged: (String value) {},
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: searchcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      labelText: 'search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                if (state is GetSearchLoudingState)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is GetSearchErrorState)
                  Center(
                    child: Text('pealse check of conecte'),
                  ),
                if (state is GetSearchSucessesState)
                  Expanded(
                    child: search.searchModel!.data!.datasearch.length == 0
                        ? Center(
                            child: Text('no result'),
                          )
                        : ListView.separated(
                            itemBuilder: (context, int i) {
                              if (search
                                  .searchModel!.data!.datasearch.isEmpty) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BuildSearchItem(
                                      model: search
                                          .searchModel!.data!.datasearch[i]!,
                                      context: context),
                                );
                              }
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.grey,
                                height: 2.0,
                              );
                            },
                            itemCount:
                                search.searchModel!.data!.datasearch.length),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget BuildSearchItem(
        {required ProductsearchModel model, required BuildContext context}) =>
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
                  // Spacer(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     CircleAvatar(
                  //       backgroundColor:
                  //           AppshopCubit.get(context).isfavorites[model.id] ==
                  //                   true
                  //               ? Colors.blue
                  //               : Colors.grey[200],
                  //       radius: 20.0,
                  //       child: IconButton(
                  //           onPressed: () {
                  //             AppshopCubit.get(context)
                  //                 .changFavorites(model.id.hashCode);
                  //             print(" id is ${model.id.hashCode}");
                  //           },
                  //           icon: Icon(Icons.favorite_border_outlined)),
                  //     ),
                  //     SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     CircleAvatar(
                  //       backgroundColor:
                  //           AppshopCubit.get(context).isCart[model.id] == true
                  //               ? Colors.green
                  //               : Colors.grey[200],
                  //       radius: 20.0,
                  //       child: IconButton(
                  //           onPressed: () {
                  //             AppshopCubit.get(context).changCart(model.id!);
                  //           },
                  //           icon: Icon(Icons.add_shopping_cart)),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
