import 'package:flutter/material.dart';
import 'package:green_pal_tracker/graph/ui/blocs/shared/graph_data_item.dart';
import 'package:green_pal_ui/theme/spacing.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EnergyLineChart extends StatelessWidget {
  const EnergyLineChart({super.key, required this.items});

  final List<GraphDataItem> items;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: SfCartesianChart(
        margin: const EdgeInsets.all(GreenPalSpacing.zero),
        primaryXAxis: DateTimeAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelStyle: Theme.of(context).textTheme.bodySmall,
          majorTickLines: const MajorTickLines(color: Colors.transparent, size: 5),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelStyle: Theme.of(context).textTheme.bodySmall,
          majorTickLines: const MajorTickLines(color: Colors.transparent, size: 5),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        plotAreaBorderColor: Colors.transparent,
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          lineColor: Colors.grey,
        ),
        series: <CartesianSeries>[
          LineSeries<GraphDataItem, DateTime>(
            dataSource: items,
            xValueMapper: (GraphDataItem data, _) => data.timestamp,
            yValueMapper: (GraphDataItem data, _) => data.value,
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
    );
  }
}
