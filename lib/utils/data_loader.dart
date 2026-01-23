import 'dart:convert';
import 'package:flutter/services.dart';

class DataLoader {
  static Future<Map<String, dynamic>> loadJsonMap(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load JSON from $assetPath: $e');
    }
  }

  static Future<List<dynamic>> loadJsonList(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      return json.decode(jsonString) as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to load JSON from $assetPath: $e');
    }
  }
}
