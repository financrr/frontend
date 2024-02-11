import 'package:financrr_frontend/themes.dart';
import 'package:financrr_frontend/util/extensions.dart';
import 'package:financrr_frontend/widgets/animations/zoom_tap_animation.dart';
import 'package:flutter/material.dart';

import '../util/text_utils.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final double? width;
  final IconData? prefixIcon;
  final Color Function(FinancrrTheme) buttonBackgroundColor;
  final Color Function(FinancrrTheme) buttonTextColor;
  final bool hasBorder;
  final Color Function(FinancrrTheme)? borderColor;
  final bool alignLeft;
  final String Function(BuildContext)? subText;
  final Function()? onPressed;

  CustomButton.primary({
    super.key,
    required this.text,
    this.width,
    this.prefixIcon,
    this.onPressed,
  })  : buttonBackgroundColor = ((theme) => theme.primaryButtonColor),
        buttonTextColor = ((theme) => theme.primaryButtonTextColor),
        hasBorder = false,
        borderColor = null,
        alignLeft = false,
    subText = null;

  CustomButton.secondary({
    super.key,
    required this.text,
    this.width,
    this.prefixIcon,
    this.onPressed,
  })  : buttonBackgroundColor = ((theme) => theme.primaryBackgroundColor),
        buttonTextColor = ((theme) => theme.primaryButtonColor),
        hasBorder = true,
        borderColor = ((theme) => theme.primaryButtonColor),
        alignLeft = false,
    subText = null;

  CustomButton.tertiary({
    super.key,
    required this.text,
    this.width,
    this.prefixIcon,
    this.onPressed,
    this.subText
  })  : buttonBackgroundColor = ((theme) => theme.secondaryBackgroundColor),
        buttonTextColor = ((theme) => theme.primaryTextColor),
        hasBorder = false,
        borderColor = null,
        alignLeft = true;

  @override
  State<StatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late final FinancrrTheme _financrrTheme = context.financrrTheme;
  late final AppTextStyles _textStyles = AppTextStyles.of(context);

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.buttonBackgroundColor(_financrrTheme),
            borderRadius: BorderRadius.circular(15),
            border: widget.hasBorder ? Border.all(color: widget.borderColor!(_financrrTheme), width: 3) : null),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: widget.alignLeft ? MainAxisAlignment.start : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.prefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Icon(widget.prefixIcon, size: 20, color: widget.buttonTextColor(_financrrTheme)),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _textStyles.bodyMedium
                      .text(widget.text, color: widget.buttonTextColor(_financrrTheme), fontWeightOverride: FontWeight.w700),
                  if (widget.subText != null)
                    _textStyles.bodySmall
                        .text(widget.subText!(context), color: widget.buttonTextColor(_financrrTheme), fontWeightOverride: FontWeight.w700),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
