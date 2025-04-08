import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(32),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 200,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fitness_center, size: 50, color: Colors.blue),
              SizedBox(height: 16),
              Text(
                'Welcome to GetFit!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Start your fitness journey today.'),
            ],
          ),
        ),
      ),
    );
  }
}