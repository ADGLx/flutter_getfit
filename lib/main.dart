import 'package:flutter/material.dart';
import 'screens/home_tab.dart';
import 'screens/goals_tab.dart';
import 'screens/progress_tab.dart';
import 'screens/settings_tab.dart';
import 'screens/login_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetFit',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: LoginTab(
        onLogin: (email, password) {
          // Handle login logic here
          print('Login with $email and $password');
        },
        onSignUp: () {
          // Navigate to sign up page
          print('Navigate to sign up');
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(ThemeMode) changeTheme;
  final ThemeMode currentThemeMode;

  const MyHomePage({
    super.key,
    required this.changeTheme,
    required this.currentThemeMode,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedEventType; // Track selected event type

  final List<String> _eventTypes = [
    'Exercise',
    'Weight Progress',
    'Calories Count',
    'Steps Taken'
  ];

  void _addEvent() {
    _selectedEventType = _eventTypes[0]; // Set default value
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add New Event'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedEventType,
                  items: _eventTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedEventType = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Event Type',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Event Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Event Details',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_selectedEventType != null) {
                    // Save the event with selected type
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$_selectedEventType event added'),
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GetFit'),
          actions: [
            IconButton(
              icon: Icon(
                widget.currentThemeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                widget.changeTheme(
                  widget.currentThemeMode == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.api), text: 'Goals'),
              Tab(icon: Icon(Icons.align_vertical_bottom_sharp), text: 'Progress'),
              Tab(icon: Icon(Icons.app_settings_alt), text: 'Settings'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            GoalsTab(),
            ProgressTab(),
            SettingsTab(),
          ],
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 20.0, right: 20.0),
        //   child: FloatingActionButton(
        //     onPressed: _addEvent,
        //     tooltip: 'Add Event',
        //     elevation: 8.0, // Increased elevation
        //     highlightElevation: 12.0, // Elevation when pressed
        //     child: const Icon(Icons.add),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}