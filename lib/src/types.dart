import 'package:flutter/widgets.dart';
import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';

class TSrcSetEntry {
  final String src;
  final String width;
  final IEDirectives? directives;

  TSrcSetEntry({
    required this.src,
    required this.width,
    dynamic directives,
  }) : directives = directives is Map<String, dynamic>
            ? IEDirectives.fromMap(directives)
            : directives as IEDirectives?;
}

class TImageEngineProvider {
  final Widget child;
  final String deliveryAddress;
  final String? stripFromSrc;

  TImageEngineProvider({
    required this.child,
    required this.deliveryAddress,
    this.stripFromSrc,
  });
}

class TImageProps {
  final String src;
  final IEDirectives? directives;
  final List<TSrcSetEntry>? srcSet;
  final Map<String, dynamic>? otherProps;

  TImageProps({
    required this.src,
    this.directives,
    this.srcSet,
    this.otherProps,
  });
}

class TSourceProps {
  final List<TSrcSetEntry> srcSet;
  final Map<String, dynamic>? otherProps;

  TSourceProps({
    required this.srcSet,
    this.otherProps,
  });
}

class TPictureProps {
  final List<Widget> children;

  TPictureProps({
    required this.children,
  });
}