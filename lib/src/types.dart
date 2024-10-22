import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';

class TSrcSetEntry {
  final String src;
  final String? width;
  final IEDirectives? directives;

  TSrcSetEntry({
    required this.src,
    this.width,
    dynamic directives,
  }) : directives = directives is Map<String, dynamic>
            ? IEDirectives.fromMap(directives)
            : directives as IEDirectives?;
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