import 'package:flutter/material.dart';
import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';
import 'types.dart';
import 'utils.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class ResponsiveImage extends StatelessWidget {
  static final logger = Logger();
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
        
        return buildImageFromNetwork(imageUrl);  // Replace Image.network with this

      },
    );
  }

  Future<Uint8List?> fetchImageData(String url) async {
  try {
    HttpClient client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set(HttpHeaders.userAgentHeader, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36');
    HttpClientResponse response = await request.close();

    if (response.statusCode == 200) {
      return await consolidateHttpClientResponseBytes(response);
    } else {
      logger.e('Failed to load image. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    logger.e('Error fetching image: $e');
    return null;
  }
}

Widget buildImageFromNetwork(String url) {
  return FutureBuilder<Uint8List?>(
    future: fetchImageData(url),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasData) {
        return Image.memory(snapshot.data!);
      } else {
        return const Icon(Icons.error);
      }
    },
  );
}

}