import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:green_pal_ui/theme/spacing.dart';
import 'package:green_pal_ui/widgets/circle_button.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({
    super.key,
    required this.message,
    required this.onRetry,
  });
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(GreenPalSpacing.largeXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const Gap(GreenPalSpacing.normal),
            GreenPalCircleButton(
              onPressed: onRetry,
              size: 45,
              icon: Icons.refresh,
            ),
          ],
        ),
      ),
    );
  }
}
