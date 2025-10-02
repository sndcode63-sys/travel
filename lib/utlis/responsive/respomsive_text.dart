import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/responsive/respomsive_size.dart';

extension ResponsiveTextVariants on Text {
  // Normal responsive
  Text get r => Text(
    data ?? "",
    key: key,
    style: (style ?? const TextStyle())
        .copyWith(fontSize: (style?.fontSize ?? 14).sp),
    strutStyle: strutStyle,
    textAlign: textAlign,
    textDirection: textDirection,
    locale: locale,
    softWrap: softWrap,
    overflow: overflow,
    textScaleFactor: textScaleFactor,
    maxLines: maxLines,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
    textHeightBehavior: textHeightBehavior,
  );

  /// Auto Resize (custom, no package)
  Widget get auto => AutoResizeText(
    data ?? "",
    style: style?.copyWith(fontSize: (style?.fontSize ?? 14).sp),
    textAlign: textAlign,
    maxLines: maxLines ?? 1,
    minFontSize: 6,
  );

  // Fitted Text
  Widget get fit => FittedBox(
    fit: BoxFit.scaleDown,
    child: r,
  );
}

class AutoResizeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final double minFontSize;

  const AutoResizeText(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
        this.maxLines,
        this.minFontSize = 8,
      });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = style?.fontSize ?? 14;

        final span = TextSpan(text: text, style: style);
        final tp = TextPainter(
          text: span,
          textAlign: textAlign ?? TextAlign.start,
          textDirection: TextDirection.ltr,
          maxLines: maxLines,
        );

        // Shrink text until it fits
        while (fontSize > minFontSize) {
          tp.text = TextSpan(
            text: text,
            style: (style ?? const TextStyle()).copyWith(fontSize: fontSize),
          );
          tp.layout(maxWidth: constraints.maxWidth);

          if (!tp.didExceedMaxLines) break;
          fontSize -= 1; // step down size
        }

        return Text(
          text,
          style: (style ?? const TextStyle()).copyWith(fontSize: fontSize),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: TextOverflow.visible, // kabhi "..." nahi hoga
        );
      },
    );
  }
}
