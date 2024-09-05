import 'package:flutter/material.dart';

import '../models/statistic_model.dart';

import '../widgets/statistic_item.dart';

class StatisticGrid extends StatelessWidget {
  StatisticGrid({super.key});

  final List<StatisticModel> statList = [
    StatisticModel(
        icon: Icons.warning_amber,
        title: "Avertissement",
        value: "1",
        color: Colors.orange),
    StatisticModel(
        icon: Icons.task_alt,
        title: "Présences",
        value: "5",
        color: Colors.lightGreen),
    StatisticModel(
        icon: Icons.cancel_outlined,
        title: "Absences",
        value: "2",
        color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: statList
          .map(
            (stat) => StatisticItem(stat: stat),
          )
          .toList(),
    );
  }
}
