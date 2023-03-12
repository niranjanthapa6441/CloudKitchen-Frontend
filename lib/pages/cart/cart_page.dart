import 'package:cloud_kitchen/pages/cart/cart_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/instance_manager.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Cart'),
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
          ),
          Container(
              child: Expanded(
                  child: SingleChildScrollView(child: CartPageBody()))),
        ],
      ),
    );
  }
}
