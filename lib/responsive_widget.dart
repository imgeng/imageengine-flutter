import 'package:flutter/material.dart';
import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';
import 'src/types.dart';
import 'src/utils.dart';

class ResponsiveImage extends StatelessWidget {
  final List<TSrcSetEntry> srcSet;
  final String src;
  final IEDirectives? directives;
  final String deliveryAddress;
  final String? stripFromSrc;
  final List<IEFormat> allowedExtensions;

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
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final entry = _chooseAppropriateImage(constraints.maxWidth);
        final processedSrc = _processUrl(entry.src);
        final imageUrl = constructUrl(deliveryAddress + processedSrc, entry.directives ?? directives ?? IEDirectives());
        
        return Image.network(imageUrl);
      },
    );
  }

  TSrcSetEntry _chooseAppropriateImage(double availableWidth) {
    return srcSet.lastWhere(
      (entry) => availableWidth <= int.parse(entry.width.replaceAll('w', '')),
      orElse: () => TSrcSetEntry(src: src, width: '100w'),
    );
  }

  String _processUrl(String url) {
    if (stripFromSrc != null) {
      url = url.replaceAll(stripFromSrc!, '');
    }
    final extension = url.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(IEFormat.values.firstWhere(
      (format) => format.toString().split('.').last == extension,
      orElse: () => IEFormat.jpg,
    ))) {
      print('Warning: Unsupported image format: $extension');
    }
    return url;
  }
}