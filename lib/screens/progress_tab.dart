import 'package:flutter/material.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Your Progress',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            children: [
              _buildProgressCard('Weight', '68 kg', Icons.monitor_weight, Colors.blue),
              _buildProgressCard('Steps', '8,542', Icons.directions_walk, Colors.green),
              _buildProgressCard('Calories', '1,850', Icons.local_fire_department, Colors.orange),
              _buildProgressCard('Workouts', '12/15', Icons.fitness_center, Colors.purple),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}