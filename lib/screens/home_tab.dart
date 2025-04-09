import 'package:flutter/material.dart';
import 'recent_events_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Welcome Card
            Card(
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                height: 180,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fitness_center, size: 50, color: Colors.orange),
                    SizedBox(height: 16),
                    Text(
                      'Welcome to GetFit!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start your fitness journey today.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // First Row of Cards (Activity)
            Row(
              children: [
                Expanded(
                  child: _buildActivityCard(
                    icon: Icons.directions_run,
                    title: "Today's Activity",
                    value1: "5,280",
                    label1: "Steps",
                    value2: "1,250",
                    label2: "Calories",
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActivityCard(
                    icon: Icons.trending_up,
                    title: "Weekly Progress",
                    value1: "+12%",
                    label1: "Activity",
                    value2: "4/7",
                    label2: "Workouts",
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            // Second Row of Cards (Friends)
              Row(
                children: [
                  // First card - Friends Network
                  Expanded(
                    child: SizedBox(
                      height: 320, // Fixed height for both cards
                      child: _buildFriendsCard(
                        icon: Icons.group_add,
                        title: "Friends Network",
                        color: Colors.purple,
                        friends: const ["Alex", "Sam", "Jordan", "Taylor"],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Second card - Weekly Leaderboard
                  Expanded(
                    child: SizedBox(
                      height: 320, // Same fixed height
                      child: _buildLeaderboardCard(
                        icon: Icons.leaderboard,
                        title: "Weekly Leaderboard",
                        color: Colors.amber,
                        leaderboard: const [
                          {"name": "Alex", "points": "5,800"},
                          {"name": "You", "points": "5,280"},
                          {"name": "Sam", "points": "4,950"},
                        ],
                      ),
                    ),
                  ),
                ],
              ),

                const SizedBox(height: 24),
                RecentEventsCard(),
                        ],
                      ),
                    ),
                  );
                }

  Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required String value1,
    required String label1,
    required String value2,
    required String label2,
    required Color color,
  }) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMetric(value1, label1),
                _buildMetric(value2, label2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsCard({
  required IconData icon,
  required String title,
  required Color color,
  required List<String> friends,
}) {
  return Card(
    elevation: 6,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: friends
                .map((friend) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            child: Icon(Icons.person, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(friend),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.message, size: 20),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Add Friends'),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildLeaderboardCard({
  required IconData icon,
  required String title,
  required Color color,
  required List<Map<String, String>> leaderboard,
}) {
  return Card(
    elevation: 6,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: leaderboard
                .asMap()
                .entries
                .map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Text(
                            '${entry.key + 1}.',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: entry.value['name'] == 'You'
                                ? Colors.blue[100]
                                : Colors.grey[200],
                            child: Text(
                              entry.value['name']!.substring(0, 1),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: entry.value['name'] == 'You'
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            entry.value['name']!,
                            style: TextStyle(
                              fontWeight: entry.value['name'] == 'You'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            entry.value['points']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              child: const Text('View Full Leaderboard'),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildMetric(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}