// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'ak_player_platform_interface.dart';

/// A web implementation of the AkPlayerPlatform of the AkPlayer plugin.
class AkPlayerWeb extends AkPlayerPlatform {
  /// Constructs a AkPlayerWeb
  AkPlayerWeb();

  static void registerWith(Registrar registrar) {
    AkPlayerPlatform.instance = AkPlayerWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }
}
