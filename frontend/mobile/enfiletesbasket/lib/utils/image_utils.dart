import 'dart:convert';
import 'dart:typed_data';

Uint8List decodeBase64Image(String base64String) {
  return base64Decode(base64String);
}
