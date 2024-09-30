import 'package:flutter/material.dart';
import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';
import 'types.dart';
import 'utils.dart';

class ResponsiveImage extends StatelessWidget {
  final List<TSrcSetEntry> srcSet;
  final String src;
  final IEDirectives? directives;
  final String deliveryAddress;
  final String? stripFromSrc;
  final List<IEFormat> allowedExtensions;
  final int? width;

  static const List<IEFormat> defaultAllowedExtensions = [
    IEFormat.png, IEFormat.gif, IEFormat.jpg, IEFormat.jpeg, IEFormat.bmp,
    IEFormat.webp, IEFormat.jp2, IEFormat.svg, IEFormat.mp4, IEFormat.jxr,
    IEFormat.avif, IEFormat.jxl
  ];

  const ResponsiveImage({
    required this.srcSet,
    required this.src,
    this.directives,
    required this.deliveryAddress,
    this.stripFromSrc,
    this.allowedExtensions = defaultAllowedExtensions,
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final targetWidth = constraints.maxWidth.isFinite 
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;

        final imageUrl = generateOptimizedImageUrl(
          srcSet,
          targetWidth.toDouble(),
          deliveryAddress,
          src,
          width,
          stripFromSrc,
          allowedExtensions,
        );
        
        return Image.network(
          imageUrl,
          headers: {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
            // Add other headers if necessary
          },
        );
      },
    );
  }

}