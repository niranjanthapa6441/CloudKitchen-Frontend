import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'order_page_body.dart';

class OrderPage extends StatefulWidget {
  int orderId;
  OrderPage({required this.orderId, Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Order'),
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: OrderPageBody(orderId: widget.orderId)))
        ],
      ),
    );
  }
}
