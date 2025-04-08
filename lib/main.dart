import 'package:flutter/material.dart';
import 'screens/home_tab.dart';
import 'screens/goals_tab.dart';
import 'screens/progress_tab.dart';
import 'screens/settings_tab.dart';

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
      home: MyHomePage(
        changeTheme: _changeTheme,
        currentThemeMode: _themeMode,
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
      ),
    );
  }
}