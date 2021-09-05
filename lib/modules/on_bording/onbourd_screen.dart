import 'package:bloc/bloc.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/log_in.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class BoardModel {
  final String image;
  final String title;
  final String body;
  BoardModel({required this.image, required this.title, required this.body});
}

class OnBordScreen extends StatefulWidget {
  @override
  _OnBordScreenState createState() => _OnBordScreenState();
}

class _OnBordScreenState extends State<OnBordScreen> {
  List<BoardModel> boarding = [
    BoardModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'board 1 title',
        body:
            'board 1 Nulla amet nulla do velit nulla enim. Commodo eiusmod consequat proident laborum ipsum incididunt in sunt mollit culpa consectetur aliquip incididunt anim. Ipsum aliquip irure laboris sit. Officia labore exercitation nisi mollit velit.'),
    BoardModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'board 2 title',
        body:
            'board 2 nulla incididunt duis elit consectetur exercitation. Qui excepteur reprehenderit voluptate cupidatat qui fugiat Lorem proident anim laborum do id consectetur. Nulla officia nisi commodo consectetur excepteur esse culpa incididunt elit ea officia quis ea. Tempor qui ullamco deserunt do qui officia amet.'),
    BoardModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'board 3 title',
        body:
            'board 3 Laboris ea sint incididunt laborum Lorem officia. Deserunt nulla ex do aute cupidatat. Non magna et dolore fugiat proident nisi aliquip esse id commodo proident.'),
  ];

  bool islast = false;

  var boardconroller = PageController();

  double currentindex = 0.0;

  void submit(context) {
    CacheHelper.putBoolean(key: 'onboarding', value: true).then((value) {
      if (value) {
        NavigateAndFinish(context, LogIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'onboard',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          TextButton(
              onPressed: () {
                submit(context);
              },
              child: Text(
                'skip',
                style: Theme.of(context).textTheme.bodyText1,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  controller: boardconroller,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      islast = true;
                    } else {
                      islast = false;
                    }
                    setState(() {
                      currentindex = index.toDouble();
                    });
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: boarding.length,
                  itemBuilder: (context, index) {
                    return boardingItem(boarding[index], context);
                  }),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                new DotsIndicator(
                  dotsCount: boarding.length,
                  position: currentindex,
                  decorator: DotsDecorator(
                    size: const Size.square(
                      12.0,
                    ),
                    activeSize: const Size(40.0, 12.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    if (islast) {
                      submit(context);
                    } else {
                      boardconroller.nextPage(
                          duration: Duration(milliseconds: 900),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boardingItem(BoardModel model, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
            fit: BoxFit.contain,
          ),
        ),
        Text(
          '${model.title}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text('${model.body}'),
        SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}
