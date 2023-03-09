import 'package:cloud_kitchen/Response/orders.dart';
import 'package:cloud_kitchen/controller/order_controller.dart';
import 'package:cloud_kitchen/route_helper/route_helper.dart';
import 'package:cloud_kitchen/utils/color/colors.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:cloud_kitchen/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/small_text.dart';

class OrdersPageBody extends StatefulWidget {
  const OrdersPageBody({super.key});

  @override
  State<OrdersPageBody> createState() => _OrdersPageBodyState();
}

class _OrdersPageBodyState extends State<OrdersPageBody> {
  ScrollController scrollController = ScrollController();
  var _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Dimensions.height10 * 20,
          width: Dimensions.width10 * 300,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 223, 123, 80),
          ),
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height20, left: Dimensions.width20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: "Pending Orders",
                  color: Colors.white,
                ),
                SizedBox(
                  height: Dimensions.height50,
                ),
                Center(
                  child: BigText(
                    text: "You Don't have any recent orders",
                    color: Colors.white,
                    size: Dimensions.font10 * 1.4,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: Dimensions.height10, left: Dimensions.width10),
          child: BigText(
            text: "Order History",
            size: Dimensions.font20,
            color: Colors.black,
          ),
        ),
        GetBuilder<OrderController>(builder: (orders) {
          return GestureDetector(
            child: orders.isLoaded
                ? Container(
                    height: Dimensions.height10 * 111,
                    child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orders.customerOrderDetails.length,
                        itemBuilder: (context, index) {
                          return _buildCustomerBookingDetailItemPage(
                              index, orders.customerOrderDetails[index]);
                        }),
                  )
                : const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Color.fromARGB(255, 3, 3, 3),
                    ),
                  ),
          );
        }),
      ],
    );
  }

  Widget _buildCustomerBookingDetailItemPage(int index, Orders orders) {
    String orderDate = orders.orderDate.toString();
    DateTime dateTime = DateTime.parse(orderDate);
    int year = dateTime.year;
    String monthName = DateFormat('MMMM').format(dateTime);
    int day = dateTime.day;
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
          top: Dimensions.height10,
          bottom: Dimensions.height10),
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
      height: Dimensions.width10 * 20,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                //imageContainer
                Container(
                  width: Dimensions.width10 * 11,
                  height: Dimensions.height10 * 12,
                  margin: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width10,
                      bottom: Dimensions.height10,
                      top: Dimensions.height10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(
                        text: day.toString(),
                        color: Color.fromARGB(255, 9, 9, 9),
                        size: Dimensions.font30,
                      ),
                      SmallText(
                        text: monthName,
                        color: Color.fromARGB(255, 9, 9, 9),
                        size: Dimensions.font10 * 1.8,
                      ),
                      SmallText(
                        text: year.toString(),
                        color: Color.fromARGB(255, 14, 13, 13),
                        size: Dimensions.font10 * 1.6,
                      )
                    ],
                  ),
                ),
                //textContainer
                Expanded(
                  child: Container(
                    width: Dimensions.width30 * 30,
                    height: Dimensions.height10 * 19,
                    padding: EdgeInsets.only(top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: "Order Time: ",
                          color: AppColors.mainBlackColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: "Total Items: ",
                          color: AppColors.mainBlackColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: "Paid Amount: ",
                          color: AppColors.mainBlackColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: "Status: ",
                          color: AppColors.mainBlackColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: Dimensions.height20 * 0.92,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height10),
                    width: Dimensions.width30 * 30,
                    height: Dimensions.height10 * 19,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: orders.orderTime.toString(),
                          color: AppColors.mainBlackColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: orders.totalItems.toString(),
                          color: AppColors.mainBlackColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: orders.totalPrice.toString(),
                          color: AppColors.mainBlackColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: orders.status.toString(),
                          color: AppColors.mainBlackColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: Dimensions.height20 * 0.92,
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SmallText(
                                text: "Show More",
                                color: AppColors.mainBlackColor,
                                size: Dimensions.font15,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.mainBlackColor,
                              ),
                            ],
                          ),
                          onTap: () =>
                              Get.toNamed(RouteHelper.getOrderDetail(index)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
