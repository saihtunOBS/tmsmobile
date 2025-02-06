import 'package:html/parser.dart';


String htmlParser(String text) {
  var document = parse(text);
  return document.body?.text ?? '';
}
