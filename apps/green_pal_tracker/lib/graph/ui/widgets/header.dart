import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:green_pal_tracker/shared/utils/date_utils.dart';
import 'package:green_pal_ui/theme/spacing.dart';
import 'package:green_pal_ui/widgets/circle_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class GraphHeader extends StatelessWidget {
  const GraphHeader({
    super.key,
    required this.title,
    required this.initialDate,
    required this.initialUnit,
    required this.onDateSelected,
    required this.onToggle,
  });

  final String title;
  final DateTime initialDate;
  final int initialUnit;
  final Function(DateTime) onDateSelected;
  final Function(int) onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: GreenPalSpacing.normal),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GreenPalCircleButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    if (context.mounted) {
                      onDateSelected(date);
                    }
                  }
                },
                icon: Icons.calendar_month,
              ),
              const Gap(GreenPalSpacing.small),
              Text(
                initialDate.dayOfWeekOrRelative,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              ToggleSwitch(
                minWidth: 60.0,
                initialLabelIndex: initialUnit,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey.shade300,
                activeBgColor: [Theme.of(context).primaryColor],
                inactiveFgColor: Colors.black,
                totalSwitches: 2,
                labels: const ['W', 'KW'],
                onToggle: (index) {
                  if (index != null) onToggle(index);
                },
              ),
            ],
          ),
          const Gap(GreenPalSpacing.largeXl),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Icon(Icons.info_outline, color: Colors.black),
            ],
          )
        ],
      ),
    );
  }
}
