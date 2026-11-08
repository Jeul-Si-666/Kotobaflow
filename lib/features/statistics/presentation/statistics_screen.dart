import 'package:flutter/material.dart';

/// Statistics screen — Milestone 5 placeholder.
///
/// Full implementation (accuracy, streak, mistake tracking, activity history)
/// will be built in Milestone 5 (Analytics & Polish).
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        forceMaterialTransparency: true,
      ),
      body: const Center(child: Text('Statistics — coming in Milestone 5')),
    );
  }
}
