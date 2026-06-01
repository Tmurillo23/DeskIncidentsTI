import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static const String _name = 'DeskIncidentsTI';

  static void debug(String message) {
    if (kDebugMode) {
      developer.log(message, name: _name, level: 500);
    }
  }

  static void info(String message) {
    developer.log(message, name: _name, level: 800);
  }

  static void warning(String message) {
    developer.log(message, name: _name, level: 900);
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _name,
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}