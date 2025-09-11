import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

extension SpaceExtension on num {
  /// Vertical responsive space -> 10.sBH means SizedBox(height: responsiveHeight)
  SizedBox get h => SizedBox(height: sBH);

  /// Horizontal responsive space -> 10.sWH means SizedBox(width: responsiveWidth)
  SizedBox get w => SizedBox(width: sWH);

  /// Screen-Based Height (sBH)
  double get sBH {
    final screenHeight = WidgetsBinding.instance.window.physicalSize.height /
        WidgetsBinding.instance.window.devicePixelRatio;
    return (this / 812) * screenHeight; // 812 = base design height
  }

  /// Screen-Based Width (sWH)
  double get sWH {
    final screenWidth = WidgetsBinding.instance.window.physicalSize.width /
        WidgetsBinding.instance.window.devicePixelRatio;
    return (this / 375) * screenWidth; // 375 = base design width
  }
}





extension ScreenFractionExtension on num {
  /// Fraction of screen height -> 0.2.sh = 20% of screen height
  double get sh {
    final screenHeight = WidgetsBinding.instance.window.physicalSize.height /
        WidgetsBinding.instance.window.devicePixelRatio;
    return screenHeight * this;
  }

  /// Fraction of screen width -> 0.3.sw = 30% of screen width
  double get sw {
    final screenWidth = WidgetsBinding.instance.window.physicalSize.width /
        WidgetsBinding.instance.window.devicePixelRatio;
    return screenWidth * this;
  }
}
