import 'package:flutter/material.dart';
import 'package:green_pal_ui/theme/colors.dart';

class GreenPalCircleButton extends StatelessWidget {
  const GreenPalCircleButton({super.key, required this.onPressed, required this.icon, this.size});
  final Function() onPressed;
  final IconData icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      constraints: BoxConstraints.tightFor(
        width: size ?? 45,
        height: size ?? 45,
      ),
      shape: const CircleBorder(
        side: BorderSide(
          color: GreenPalColors.border,
          width: 1,
        ),
      ),
      fillColor: Theme.of(context).scaffoldBackgroundColor,
      child: Icon(icon),
    );
  }
}
