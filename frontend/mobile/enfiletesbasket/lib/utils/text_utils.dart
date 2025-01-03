import 'dart:convert';

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  }
  return '${text.substring(0, maxLength)}...';
}

String decodeText(String input) {
  try {
    return utf8.decode(input.runes.toList());
  } catch (_) {
    return input;
  }
}
