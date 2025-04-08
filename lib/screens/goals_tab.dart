import 'package:flutter/material.dart';

class GoalsTab extends StatelessWidget {
  const GoalsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Your Fitness Goals',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        _buildGoalCard('Lose Weight', 'Target: 5 kg in 2 months', Icons.monitor_weight),
        _buildGoalCard('Run 5K', 'Target: 30 minutes', Icons.directions_run),
        _buildGoalCard('Strength Training', '3 times per week', Icons.fitness_center),
      ],
    );
  }

  Widget _buildGoalCard(String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}