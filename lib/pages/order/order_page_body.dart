import 'package:cloud_kitchen/Response/orders.dart';
import 'package:cloud_kitchen/controller/order_controller.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:cloud_kitchen/widgets/big_text.dart';
import 'package:cloud_kitchen/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../utils/Color/colors.dart';

class OrderPageBody extends StatelessWidget {
  int orderId;
  OrderPageBody({required this.orderId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orders order = Get.find<OrderController>().customerOrderDetails[orderId];
    List<OrderFoods>? orderFoods = order.orderFoods;
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 10,
                    width: Dimensions.width10 * 9,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BigText(
                          text: 'Date: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        BigText(
                          text: 'Time: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        BigText(
                          text: 'Status: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 10,
                    width: Dimensions.width10 * 12,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: order.orderDate.toString(),
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        SmallText(
                          text: order.orderTime.toString(),
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        SmallText(
                          text: order.status.toString(),
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        GetBuilder<OrderController>(builder: (orders) {
          return GestureDetector(
            child: orders.isLoaded
                ? Container(
                    height: _height(orderFoods),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: orderFoods?.length,
                        itemBuilder: (context, index) {
                          return _buildPageItem(index, orderFoods![index]);
                        }),
                  )
                : CircularProgressIndicator.adaptive(
                    backgroundColor: Color.fromARGB(255, 3, 3, 3),
                  ),
          );
        }),
        // GetBuilder<OrderController>(
        //   builder: (orders) {
        //     return GestureDetector(
        //       child: orders.isLoaded
        //           ? Container(
        //               //height: Dimensions.height10 * 32,
        //               margin: EdgeInsets.only(
        //                   top: Dimensions.height10, bottom: Dimensions.height5),
        //               child: SingleChildScrollView(
        //                 physics: AlwaysScrollableScrollPhysics(),
        //                 child: Table(
        //                   columnWidths: const {
        //                     0: FlexColumnWidth(2.8),
        //                     1: FlexColumnWidth(2.2),
        //                     2: FlexColumnWidth(2),
        //                     3: FlexColumnWidth(2),
        //                   },
        //                   border: TableBorder.all(
        //                     color: Colors.grey,
        //                     width: 1.0,
        //                     style: BorderStyle.solid,
        //                   ),
        //                   children: [
        //                     TableRow(
        //                       decoration: BoxDecoration(
        //                         color: Colors.grey[300],
        //                       ),
        //                       children: [
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: Text(
        //                             'Food Name',
        //                             style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 18,
        //                             ),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: Text(
        //                             'Quantity',
        //                             style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 18,
        //                             ),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: Text(
        //                             'Unit Price',
        //                             style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 18,
        //                             ),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: Text(
        //                             'Price',
        //                             style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 18,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     for (var i = 0; i < orderFoods!.length; i++)
        //                       TableRow(
        //                         children: [
        //                           Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child: Text(orderFoods[i].name.toString()),
        //                           ),
        //                           Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child:
        //                                 Text(orderFoods[i].quantity.toString()),
        //                           ),
        //                           Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child: Text(
        //                                 orderFoods[i].unitPrice.toString()),
        //                           ),
        //                           Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child: Text(orderFoods[i].price.toString()),
        //                           ),
        //                         ],
        //                       ),
        //                   ],
        //                 ),
        //               ),
        //             )
        //           : CircularProgressIndicator.adaptive(
        //               backgroundColor: Color.fromARGB(255, 3, 3, 3),
        //             ),
        //     );
        //   },
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 7,
                    width: Dimensions.width10 * 18,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BigText(
                          text: 'Total: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        BigText(
                          text: 'Delivery Charge: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 7,
                    width: Dimensions.width10 * 9,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: order.totalPrice.toString(),
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        SmallText(
                          text: '140',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.black,
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 7,
                    width: Dimensions.width10 * 18,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BigText(
                          text: 'Total Paid Amount: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 7,
                    width: Dimensions.width10 * 8,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: order.totalPrice.toString(),
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            //Get.toNamed(RouteHelper.availablePaymentMethods);
          },
          child: Container(
            margin: EdgeInsets.only(
                left: Dimensions.width30 + Dimensions.width30,
                right: Dimensions.width30 + Dimensions.width30,
                bottom: Dimensions.height50),
            height: Dimensions.screenHeight / 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: Color.fromARGB(255, 223, 123, 80),
            ),
            child: Center(
              child: BigText(
                text: "Generate Invoice",
                size: Dimensions.font20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildPageItem(int index, OrderFoods orderFood) {
    return Card(
      child: Container(
        height: Dimensions.height10 * 14,
        padding: EdgeInsets.only(
            right: Dimensions.width10 * 0.8,
            left: Dimensions.width10 * 0.8,
            top: Dimensions.height10 * 0.4,
            bottom: Dimensions.height10 * 0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.height10 * 0.8,
            ),
            Text(
              orderFood.name.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font10 * 1.8,
              ),
            ),
            SizedBox(
              height: Dimensions.height10 * 0.8,
            ),
            Text(
              'Quantity: ${orderFood.quantity}',
              style: TextStyle(
                fontSize: Dimensions.font10 * 1.6,
              ),
            ),
            SizedBox(
              height: Dimensions.height10 * 0.8,
            ),
            Text(
              'Unit Price: ${orderFood.unitPrice}',
              style: TextStyle(
                fontSize: Dimensions.font10 * 1.6,
              ),
            ),
            SizedBox(
              height: Dimensions.height10 * 0.8,
            ),
            Text(
              'Price: ${orderFood.price}',
              style: TextStyle(
                fontSize: Dimensions.font10 * 1.6,
              ),
            ),
            SizedBox(
              height: Dimensions.height10 * 1.6,
            ),
          ],
        ),
      ),
    );
  }

  double _height(List<OrderFoods>? orderFoods) {
    double height = 0;
    for (int i = 0; i < orderFoods!.length; i++) {
      height += Dimensions.height10 * 14.7;
    }
    return height;
  }
}
