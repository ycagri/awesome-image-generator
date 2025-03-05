import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension CustomFinders on CommonFinders {
  Finder byUrl(String assetName) => _ImageUrlFinder(assetName);
}

class _ImageUrlFinder extends Finder {
  final String url;

  _ImageUrlFinder(this.url);

  @override
  Iterable<Element> apply(Iterable<Element> candidates) {
    return candidates.where((element) {
      final widget = element.widget;
      if (widget is Image) {
        final imageProvider = widget.image;
        if (imageProvider is NetworkImage) {
          return imageProvider.url == url;
        }
      }
      return false;
    });
  }

  @override
  String get description => 'Image with url name $url';
}
