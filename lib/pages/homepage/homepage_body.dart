import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../Response/foods.dart';
import '../../controller/food_controller.dart';
import '../../utils/Color/colors.dart';
import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
          ),
          child: Row(
            children: [BigText(text: "Popular Foods")],
          ),
        ),
        GetBuilder<FoodController>(builder: (foods) {
          return GestureDetector(
            child: Container(
              height: Dimensions.height10 * 35,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: foods.foods.length,
                  itemBuilder: (context, index) {
                    return _buildPageItem(index, foods.foods[index]);
                  }),
            ),
          );
        }),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
          ),
          child: Row(
            children: [BigText(text: "Popular Restaurants")],
          ),
          height: Dimensions.height40,
        ),
        Container(
          height: Dimensions.height10 * 75,
          padding: EdgeInsets.only(
              right: Dimensions.width5, left: Dimensions.width5),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: ((context, index) {
              return Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height5, bottom: Dimensions.height5),
                padding: EdgeInsets.only(
                  left: Dimensions.width10,
                  right: Dimensions.width10,
                ),
                height: Dimensions.height10 * 12,
                width: Dimensions.width20 * 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 238, 236, 236),
                      blurRadius: Dimensions.radius5,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 249, 248, 248),
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 251, 250, 250),
                      offset: Offset(5, 0),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: Dimensions.height10 * 10,
                      width: Dimensions.width10 * 10,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10)),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10,
                          right: Dimensions.width10,
                          top: Dimensions.height15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: "Name",
                            size: Dimensions.font10 * 1.7,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Container(
                            height: Dimensions.height10 * 3,
                            child: BigText(
                              text: "Address",
                              color: Colors.black,
                              size: Dimensions.font10 * 1.4,
                            ),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndTextWidget(
                                    icon: Icons.star,
                                    text: 'erwer',
                                    iconColor: AppColors.iconColor1,
                                  ),
                                  IconAndTextWidget(
                                    icon: Icons.timer,
                                    text: '15 mins',
                                    iconColor: AppColors.mainColor,
                                  ),
                                  IconAndTextWidget(
                                    icon: Icons.location_on,
                                    text: '1.5 k.m.',
                                    iconColor: AppColors.iconColor1,
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(index, Foods foods) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var _currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      var matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var _currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, _currScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var _currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else {
      var _currScale = 0.8;
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1);

      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.height10 * 20,
            width: Dimensions.width10 * 200,
            margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.height10,
                right: Dimensions.height10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Color.fromARGB(255, 87, 76, 148),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstant.baseURL +
                        AppConstant.apiVersion +
                        foods.imagePath.toString()))),
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.height20 * 6,
              width: Dimensions.width10 * 32,
              margin: EdgeInsets.only(
                  left: Dimensions.height10,
                  right: Dimensions.height10,
                  bottom: Dimensions.height20),
              decoration: BoxDecoration(
                border: Border.all(width: 0.01),
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 238, 236, 236),
                    blurRadius: Dimensions.radius5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 249, 248, 248),
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 251, 250, 250),
                    offset: Offset(5, 0),
                  )
                ],
              ),
              child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.height15,
                      right: Dimensions.height15),
                  child: Column(
                    children: [
                      BigText(text: foods.name.toString()),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        height: Dimensions.height10 * 3,
                        child: BigText(
                          text: foods.restaurantName.toString(),
                          color: Colors.black,
                          size: Dimensions.font10 + 2,
                        ),
                      ),
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconAndTextWidget(
                                icon: Icons.star,
                                text: foods.rating.toString(),
                                iconColor: AppColors.iconColor1,
                              ),
                              IconAndTextWidget(
                                icon: Icons.timer,
                                text: '15 mins',
                                iconColor: AppColors.mainColor,
                              ),
                              IconAndTextWidget(
                                icon: Icons.location_on,
                                text: '1.5 k.m.',
                                iconColor: AppColors.iconColor1,
                              ),
                            ]),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
