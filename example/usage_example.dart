import 'package:flutter/material.dart';
import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';
import '../lib/src/responsive_widget.dart';
import '../lib/src/types.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ResponsiveImage Examples')),
        body: ListView(
          children: [
            ResponsiveImage(
              srcSet: [
                TSrcSetEntry(src: 'image-300w.jpg', width: '300w'),
                TSrcSetEntry(src: 'image-600w.jpg', width: '600w'),
                TSrcSetEntry(src: 'image-1200w.jpg', width: '1200w'),
              ],
              src: 'image-1200w.jpg',
              deliveryAddress: 'https://your-imageengine-address.imgeng.in/',
              directives: IEDirectives(
                width: 800,
                height: 600,
                compression: 75,
              ),
              stripFromSrc: '/images/',
            ),
            const SizedBox(height: 20),
            ResponsiveImage(
              srcSet: [
                TSrcSetEntry(
                  src: 'custom-image-500w.webp',
                  width: '500w',
                  directives: IEDirectives(format: IEFormat.webp),
                ),
                TSrcSetEntry(
                  src: 'custom-image-1000w.webp',
                  width: '1000w',
                  directives: IEDirectives(format: IEFormat.webp),
                ),
              ],
              src: 'custom-image-1000w.webp',
              deliveryAddress: 'https://another-imageengine-address.imgeng.in/',
              allowedExtensions: [IEFormat.webp, IEFormat.jpg],
            ),
          ],
        ),
      ),
    );
  }
}
