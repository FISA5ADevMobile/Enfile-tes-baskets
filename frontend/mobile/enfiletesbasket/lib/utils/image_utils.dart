import 'dart:convert';
import 'dart:typed_data';

/// Convertit une chaîne Base64 en Uint8List pour afficher une image
Uint8List decodeBase64Image(String base64String) {
  return base64Decode(base64String);
}
