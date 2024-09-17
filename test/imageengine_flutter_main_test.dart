import 'package:imageengine_flutter/imageengine_flutter_main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imageengine_flutter/src/utils.dart';
import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';

void main() {
  group('generateOptimizedSrcSetString', () {
    test('generates correct srcset string', () {
      final srcSet = [
        TSrcSetEntry(src: '/image.jpg', width: '500w', directives: {'rotate': 90}),
        TSrcSetEntry(src: '/image.jpg', width: '1000w', directives: {'rotate': 180}),
      ];
      
      final result = generateOptimizedSrcSetString(
        srcSet,
        600,                    // availableWidth
        'https://example.com',  // deliveryAddress
        '/default.jpg',         // defaultSrc
        2000,                   // defaultWidth
        '/assets',
        [IEFormat.jpg, IEFormat.png]
      );
      
      expect(result, 'https://example.com/image.jpg?imgeng=/w_1000/r_180 1000w');
    });

    test('handles default case', () {
      final srcSet = [
        TSrcSetEntry(src: '/image.jpg', width: '500w'),
      ];
      
      final result = generateOptimizedSrcSetString(
        srcSet,
        1000,
        'https://example.com',
        '/default.jpg',
        2000,
        null,
        [IEFormat.jpg]
      );
      
      expect(result, 'https://example.com/default.jpg?imgeng=/w_2000 2000w');
    });

    test('strips prefix from src', () {
      final srcSet = [
        TSrcSetEntry(src: '/assets/image.jpg', width: '500w'),
      ];
      
      final result = generateOptimizedSrcSetString(
        srcSet,
        400,
        'https://example.com',
        '/default.jpg',
        2000,
        '/assets',
        [IEFormat.jpg]
      );
      
      expect(result, 'https://example.com/image.jpg?imgeng=/w_500 500w');
    });
  });
}