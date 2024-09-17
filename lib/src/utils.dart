import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';
import 'types.dart';

String constructUrl(String src, IEDirectives directives) {
  return buildIEUrl(src, directives);
}

String generateOptimizedSrcSetString(List<TSrcSetEntry> srcSet, double availableWidth, String deliveryAddress, String defaultSrc, int? defaultWidth, String? stripFromSrc, List<IEFormat> allowedExtensions) {
  var chosenEntries = chooseAppropriateImage(srcSet, availableWidth, defaultSrc, defaultWidth);
  return chosenEntries.map((entry) {
    final processedSrc = processUrl(entry.src, stripFromSrc, allowedExtensions);
    final widthDirective = int.parse(entry.width.replaceAll("w", ""));
    final directives = entry.directives ?? IEDirectives();
    final finalDirectives = IEDirectives.fromMap({
      ...directives.toMap(),
      'width': widthDirective,
    });
    final fullImageUrl = constructUrl(deliveryAddress + processedSrc, finalDirectives);
    return '$fullImageUrl ${entry.width}';
  }).join(', ');
}

String processUrl(String url, String? stripFromSrc, List<IEFormat> allowedExtensions) {
  if (stripFromSrc != null) {
    url = url.replaceAll(stripFromSrc, '');
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

List<TSrcSetEntry> chooseAppropriateImage(List<TSrcSetEntry> srcSet, double availableWidth, String defaultSrc, int? defaultWidth) {
  for (var entry in srcSet) {
    if (availableWidth <= int.parse(entry.width.replaceAll('w', ''))) {
      return [entry];
    }
  }
  return [TSrcSetEntry(src: defaultSrc, width: '${defaultWidth}w')];
}
