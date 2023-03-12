import 'package:cloud_kitchen/Response/payments.dart';
import 'package:cloud_kitchen/controller/payment_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/Color/colors.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class PaymentDetailsPageBody extends StatefulWidget {
  const PaymentDetailsPageBody({super.key});

  @override
  State<PaymentDetailsPageBody> createState() => _PaymentDetailsPageBodyState();
}

class _PaymentDetailsPageBodyState extends State<PaymentDetailsPageBody> {
  ScrollController scrollController = ScrollController();

  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<PaymentController>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: Dimensions.height10, left: Dimensions.width10),
          child: BigText(
            text: "Payment History",
            size: Dimensions.font20,
            color: Colors.black,
          ),
        ),
        GetBuilder<PaymentController>(builder: (payments) {
          return GestureDetector(
            child: payments.isLoaded
                ? Container(
                    height: Dimensions.height10 * 55,
                    padding: EdgeInsets.only(bottom: Dimensions.height20),
                    child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: payments.customerPaymentDetails.length + 1,
                        itemBuilder: (context, index) {
                          if (index != payments.totalElements &&
                              index == payments.customerPaymentDetails.length) {
                            return _buildSingleLoadingIndicator();
                          } else if (index == payments.totalElements &&
                              index == payments.customerPaymentDetails.length) {
                            return Container();
                          }
                          return _buildPayment(
                              index, payments.customerPaymentDetails[index]);
                        }),
                  )
                : _buildLoadingIndicator(),
          );
        }),
      ],
    );
  }

  Widget _buildPayment(int index, Payments payments) {
    String orderDate = payments.paymentDate.toString();
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
      height: Dimensions.width10 * 17,
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
                    width: Dimensions.width30 * 35,
                    height: Dimensions.height10 * 16,
                    padding: EdgeInsets.only(top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: "Paid Via:",
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: "Method:",
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: "Paid Amount:",
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height20 * 0.92,
                        ),
                        SmallText(
                          text: "Status:",
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font10 * 1.6,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height10),
                    width: Dimensions.width30 * 30,
                    height: Dimensions.height10 * 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: payments.paymentPartner.toString(),
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: payments.paymentMethod.toString(),
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        SmallText(
                          text: payments.paidAmount.toString(),
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height20 * 0.92,
                        ),
                        SmallText(
                          text: payments.status.toString(),
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font10 * 1.6,
                        ),
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

  Widget _buildLoadingIndicator() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 62,
        child: ListView.builder(
          padding: EdgeInsets.zero,

          itemCount: 5, // You can adjust the number of shimmering cells
          itemBuilder: (_, __) => Container(
            padding: EdgeInsets.only(
                right: Dimensions.width10,
                left: Dimensions.width10,
                bottom: Dimensions.height20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height10 * 10,
                  width: Dimensions.width10 * 10,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: Dimensions.height10 * 2.4,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSingleLoadingIndicator() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 13,
        child: Container(
          padding: EdgeInsets.only(
              right: Dimensions.width10,
              left: Dimensions.width10,
              bottom: Dimensions.height20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.height10 * 10,
                width: Dimensions.width10 * 10,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: Dimensions.height10 * 2.4,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
