import 'package:flutter/material.dart';

import '../res/app_styles.dart';
import '../res/app_dimensions.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final VoidCallback onClick;
  final Color textColor;
  final Color textHoverColor;
  final Color color;
  final Color hoverColor;
  final bool hasBorder;
  final Color? borderColor;
  final Color? hoverBorderColor;
  final Color? iconColor;
  final Color? iconHoverColor;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onClick,
    required this.textColor,
    required this.textHoverColor,
    required this.color,
    required this.hoverColor,
    required this.hasBorder,
    this.iconColor,
    this.iconHoverColor,
    this.borderColor,
    this.hoverBorderColor,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          AppStyles.globalButtonStyle,
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: AppDimension.moyen),
        ),
        foregroundColor: getColor(widget.textColor, widget.textHoverColor),
        backgroundColor: getColor(widget.color, widget.hoverColor),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        elevation: MaterialStateProperty.all(0.0),
        side: widget.hasBorder
            ? getBorder(widget.borderColor!, widget.hoverBorderColor!)
            : null,
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 40),
        ),
      ),
      onPressed: widget.onClick,
      child: Text(
        widget.title,
        style: AppStyles.buttonTitleStyle,
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(Color color, Color colorPressed) {
    final getBorder = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(color: colorPressed, width: 1);
      } else {
        return BorderSide(color: color, width: 1);
      }
    };
    return MaterialStateProperty.resolveWith(getBorder);
  }
}
