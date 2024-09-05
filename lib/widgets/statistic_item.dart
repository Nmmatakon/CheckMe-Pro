import 'package:flutter/material.dart';

import '../models/statistic_model.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({super.key, required this.stat});

  final StatisticModel stat;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Icon(stat.icon),
          title: Text(
            stat.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          color: stat.color,
          child: Text(stat.value,
              style: appTheme.textTheme.titleLarge,
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
