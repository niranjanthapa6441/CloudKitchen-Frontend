import 'package:cloud_kitchen/widgets/big_text.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Container(
            margin: EdgeInsets.only(top: 60, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      child: Row(children: [
                        Icon(Icons.location_on),
                        BigText(
                          text: '2-streetAddress,City,State',
                          size: 15,
                        )
                      ]),
                      height: 30,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0)),
                    )
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
