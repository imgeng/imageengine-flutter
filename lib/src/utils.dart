import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';
import 'types.dart';

String constructUrl(String src, IEDirectives directives) {
  return buildIEUrl(src, directives);
}

String generateOptimizedImageUrl(List<TSrcSetEntry> srcSet, double availableWidth, String deliveryAddress, String defaultSrc, int? defaultWidth, String? stripFromSrc, List<IEFormat> allowedExtensions) {
  var chosenEntry = chooseAppropriateImage(srcSet, availableWidth, defaultSrc, defaultWidth).first;
  final processedSrc = processUrl(chosenEntry.src, stripFromSrc, allowedExtensions);
  final directives = chosenEntry.directives ?? IEDirectives();
  final finalDirectives = IEDirectives.fromMap({
    ...directives.toMap(),
    if (chosenEntry.width != null)
      'width': int.parse(chosenEntry.width!.replaceAll("w", "")),
  });
  return constructUrl(deliveryAddress + processedSrc, finalDirectives);
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
  TSrcSetEntry? bestFit;
  for (var entry in srcSet) {
    if (entry == null) continue;
    int entryWidth = int.parse(entry.width!.replaceAll('w', ''));
    if (availableWidth >= entryWidth && (bestFit == null || entryWidth > int.parse(bestFit.width!.replaceAll('w', '')))) {
      bestFit = entry;
    }
  }
  if (bestFit != null && int.parse(bestFit.width!.replaceAll('w', '')) < defaultWidth! && defaultWidth < availableWidth) {
    bestFit = null;
  }
  return [bestFit ?? TSrcSetEntry(src: defaultSrc, width: defaultWidth?.toString(), directives: IEDirectives())];
}
