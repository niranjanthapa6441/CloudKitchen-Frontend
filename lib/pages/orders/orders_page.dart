import 'package:cloud_kitchen/pages/orders/orders_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersState();
}

class _OrdersState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Order Details'),
        backgroundColor: Color.fromARGB(255, 223, 123, 80),
      ),
      body: Column(
        children: [
          Container(
              child: Expanded(
                  child: SingleChildScrollView(child: OrdersPageBody()))),
        ],
      ),
    );
  }
}
