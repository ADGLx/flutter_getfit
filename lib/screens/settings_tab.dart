import 'package:flutter/material.dart';
import 'login_tab.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        _buildSettingsOption(Icons.notifications, 'Notifications', true),
        _buildSettingsOption(Icons.dark_mode, 'Dark Mode', false),
        _buildSettingsOption(Icons.account_circle, 'Account Settings', false),
        _buildSettingsOption(Icons.help, 'Help & Support', false),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: () {
                  Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => 
                        LoginTab( onLogin: (email, password) {
            // Handle login logic here
            print('Login with $email and $password');
          },
          onSignUp: () {
            // Navigate to sign up page
            print('Navigate to sign up');
          })
                        
                        ,
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
            
          },
        ),
      ],
    );
  }

  Widget _buildSettingsOption(IconData icon, String title, bool isSwitch) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: isSwitch
            ? Switch(value: true, onChanged: (value) {})
            : const Icon(Icons.chevron_right),
      ),
    );
  }
}