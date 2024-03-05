import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
bool isMobile = UniversalPlatform.isAndroid || UniversalPlatform.isIOS;

double webTotalMargin(BuildContext context){
  return MediaQuery.of(context).size.width/4.5;
}
class PlatformUtils {
  static bool get isMobile {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isIOS || Platform.isAndroid;
    }
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isLinux || Platform.isFuchsia || Platform.isWindows || Platform.isMacOS;
    }
  }
}