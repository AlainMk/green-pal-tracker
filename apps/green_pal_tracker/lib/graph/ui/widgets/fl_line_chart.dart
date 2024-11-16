import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:green_pal_tracker/graph/ui/blocs/shared/graph_data_item.dart';
import 'package:intl/intl.dart';

class FlLineChart extends StatelessWidget {
  const FlLineChart({super.key, required this.items});
  final List<GraphDataItem> items;

  @override
  Widget build(BuildContext context) {
    final rawData = items.asMap().entries.map((entry) {
      int index = entry.key;
      return FlSpot(index.toDouble(), entry.value.value.toDouble());
    }).toList();
    return AspectRatio(
      aspectRatio: 1.2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: rawData,
              isCurved: false,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                maxIncluded: false,
                minIncluded: true,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString(), style: Theme.of(context).textTheme.bodySmall);
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // Display timestamps at intervals
                  if (value % 2 == 0) {
                    final hour = DateFormat.Hm().format(items[value.toInt()].timestamp);
                    return Text(hour, style: Theme.of(context).textTheme.bodySmall);
                  }
                  return Container();
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false, border: Border.all(color: Colors.grey)),
        ),
      ),
    );
  }
}
