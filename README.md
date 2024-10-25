# ImageEngine Flutter

Hassle-free optimized responsive images for Flutter applications.

## Features

- Responsive image loading
- Image optimization with directives
- Automatic srcSet handling

## Getting started

Add to your `pubspec.yaml`:

## Usage

1. Import the package:

```dart
import 'package:imageengine_flutter/imageengine_flutter.dart';
```

2. Use the `ResponsiveImage` widget:

```dart
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
  deliveryAddress: 'https://blazing-fast-pics.cdn.imgeng.in',
)


For a complete example, see the `example` folder.


