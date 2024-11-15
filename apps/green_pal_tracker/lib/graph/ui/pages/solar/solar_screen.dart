import 'package:flutter/material.dart';
import 'package:green_pal_tracker/graph/ui/widgets/header.dart';
import 'package:green_pal_ui/theme/spacing.dart';

class SolarScreen extends StatelessWidget {
  const SolarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: GreenPalSpacing.large),
      children: [
        GraphHeader(
          title: "Solar Generation",
          initialDate: DateTime.now(),
          onDateSelected: (d) {},
          onToggle: (i) {},
        ),
      ],
    );
  }
}
