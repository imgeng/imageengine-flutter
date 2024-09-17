import 'package:flutter/material.dart';
import 'package:imageengine_flutter/imageengine_flutter_main.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Shopping Cart')),
        body: ShoppingCart(),
      ),
    );
  }
}

class ShoppingCart extends StatelessWidget {
  final String deliveryAddress = 'https://blazing-fast-pics.cdn.imgeng.in';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ResponsiveImage(
            src: '/images/pic_1_variation_2.jpg',
            srcSet: [
              TSrcSetEntry(
                src: '/images/pic_1_variation_1.jpg',
                directives: {'rotate': 180},
                width: '500w',
              ),
              TSrcSetEntry(
                src: '/images/pic_1_variation_2.jpg',
                directives: {'rotate': 180},
                width: '900w',
              ),
            ],
            deliveryAddress: deliveryAddress,
          ),
          // Add more widgets as needed
        ],
      ),
    );
  }
}