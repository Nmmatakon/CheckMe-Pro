import 'package:flutter/material.dart';

import '../../models/statistic_model.dart';
import '../../models/session.dart';

import 'statistic_item.dart';

class StatisticGrid extends StatelessWidget {
  const StatisticGrid({required this.session, super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    final List<StatisticModel> statList = [
      StatisticModel(
          icon: Icons.next_plan_outlined,
          title: "Début",
          time: session.startTime,
          status: "Heure de début"),
      StatisticModel(
          icon: Icons.outbond_outlined,
          title: "Fin",
          time: session.endTime,
          status: "Heure de fin"),
      StatisticModel(
          icon: Icons.coffee_rounded,
          title: "N° session",
          time: "x ${session.numberOfSession} ",
          status: "Nombre de session"),
      StatisticModel(
        icon: Icons.calendar_month_outlined,
        title: "Statut",
        time: session.active ? "active" : "non active",
        status: "état de session",
      ),
    ];

    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
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
