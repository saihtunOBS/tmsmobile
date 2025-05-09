import 'package:html/parser.dart';

String htmlParser(String text) {
  var document = parse(text);
  return document.body?.text ?? '';
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
