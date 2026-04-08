import 'package:flutter/services.dart';
import 'package:xml/xml.dart';
import '../models/house_model.dart';

class HouseSvgProcessor {
  static Future<String> processSvg(House house) async {
    // Load SVG string from assets
    final String fullPath = 'assets/images/house/${house.name}';
    String svgString = await rootBundle.loadString(fullPath);

    final document = XmlDocument.parse(svgString);

    // 1. Remove elements based on house properties
    _removeElementById(document, 'left-window', !house.leftWindow);
    _removeElementById(document, 'right-window', !house.rightWindow);
    _removeElementById(document, 'chimney', !house.chimney);

    svgString = document.toXmlString();

    // 2. Replace colors in <style> tag
    // The style tag usually looks like:
    // <style type="text/css">
    // .st0{fill:#8F6645;}
    // .st1{fill:#EEEEEE;}
    // ...
    // </style>
    
    final styleTags = document.findAllElements('style');
    for (var styleTag in styleTags) {
      String styleContent = styleTag.innerText;
      for (int i = 0; i < 10; i++) {
        final String regexStr = 'st$i\\s*\\{\\s*fill:\\s*#[a-fA-F0-9]+;\\s*\\}';
        final String replacement = 'st$i { fill: #${house.colorPalette.getColor(i)}; }';
        styleContent = styleContent.replaceAll(RegExp(regexStr), replacement);
      }
      // Re-assign updated content to style tag
      // Since innerText might not be directly settable in a way that reflects in the document easily,
      // we can replace the text node inside.
      styleTag.children.clear();
      styleTag.children.add(XmlText(styleContent));
    }

    return document.toXmlString();
  }

  static void _removeElementById(XmlDocument document, String id, bool shouldRemove) {
    if (!shouldRemove) return;
    
    // Find all elements with the given ID attribute
    final elements = document.descendants
        .whereType<XmlElement>()
        .where((element) => element.getAttribute('id') == id)
        .toList();
    
    for (var element in elements) {
      element.parent?.children.remove(element);
    }
  }
}
