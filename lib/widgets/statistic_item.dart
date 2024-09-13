import 'package:flutter/material.dart';

import '../models/statistic_model.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({super.key, required this.stat});

  final StatisticModel stat;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(color: Colors.white),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:
                              appTheme.colorScheme.onPrimary.withOpacity(0.15)),
                      child: Icon(
                        Icons.next_plan_outlined,
                        color: appTheme.colorScheme.onPrimary,
                      ),
                    ),
                    const Text(" Check In"),
                  ],
                ),
                Text(
                  "10:20 am",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.size.width * 0.05),
                ),
                const Text(
                  "On Time",
                )
              ],
            )),
      ),
    );
  }
}
