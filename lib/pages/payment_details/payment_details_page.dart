import 'package:cloud_kitchen/pages/payment_details/payment_details_page_body.dart';
import 'package:flutter/material.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({super.key});

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Payment Details'),
        backgroundColor: Color.fromARGB(255, 223, 123, 80),
      ),
      body: Column(
        children: [
          Container(
              child: Expanded(
                  child: SingleChildScrollView(child: PaymentDetailsPageBody()))),
        ],
      ),
    );
  }
}