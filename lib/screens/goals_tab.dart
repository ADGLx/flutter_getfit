import 'package:flutter/material.dart';

class GoalsTab extends StatefulWidget {
  const GoalsTab({super.key});

  @override
  State<GoalsTab> createState() => _GoalsTabState();
}

class _GoalsTabState extends State<GoalsTab> {
  final List<Map<String, dynamic>> _goals = [
    {
      'title': 'Lose Weight',
      'subtitle': 'Target: 5 kg in 2 months',
      'icon': Icons.monitor_weight,
      'color': Colors.yellow,
    },
    {
      'title': 'Run 5K',
      'subtitle': 'Target: 30 minutes',
      'icon': Icons.directions_run,
      'color': Colors.green,
    },
    {
      'title': 'Strength Training',
      'subtitle': '3 times per week',
      'icon': Icons.fitness_center,
      'color': Colors.blue, // default blue
    },
    {
      'title': 'Calorie Intake',
      'subtitle': 'Target: 2000 kcal/day',
      'icon': Icons.local_fire_department,
      'color': Colors.red,
    },
  ];

  void _editGoal(BuildContext context, int index) {
    final TextEditingController controller =
        TextEditingController(text: _goals[index]['subtitle']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit "${_goals[index]['title']}" Goal'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Target'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _goals[index]['subtitle'] = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addGoal(BuildContext context) {
    final titleController = TextEditingController();
    final subtitleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Goal Title'),
            ),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(labelText: 'Goal Target'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text.trim();
              final subtitle = subtitleController.text.trim();

              if (title.isNotEmpty && subtitle.isNotEmpty) {
                setState(() {
                  _goals.add({
                    'title': title,
                    'subtitle': subtitle,
                    'icon': Icons.flag,
                    'color': Colors.blueGrey,
                  });
                });
              }

              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

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
        ...List.generate(_goals.length, (index) {
          final goal = _goals[index];
          return _buildGoalCard(
            title: goal['title'],
            subtitle: goal['subtitle'],
            icon: goal['icon'],
            color: goal['color'],
            onEdit: () => _editGoal(context, index),
          );
        }),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => _addGoal(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Goal'),
        ),
      ],
    );
  }

  Widget _buildGoalCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onEdit,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
