import 'package:flutter/cupertino.dart';

extension SpaceExtension on num {
  /// Vertical space -> 10.h means SizedBox(height: 10)
  SizedBox get h => SizedBox(height: toDouble());

  /// Horizontal space -> 10.w means SizedBox(width: 10)
  SizedBox get w => SizedBox(width: toDouble());
}