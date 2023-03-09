import 'package:cloud_kitchen/pages/orders/orders_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../route_helper/route_helper.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersState();
}

class _OrdersState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Orders'),
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
          ),
          const Expanded(child: SingleChildScrollView(child: OrdersPageBody())),
        ],
      ),
    );
  }
}
