import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        // backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Account Section
          _buildSectionTitle('Account'),
          _buildListTile(
            context,
            'Profile Info',
            Icons.person,
            '/profileSettings',
          ),
          _buildListTile(
            context,
            'Privacy',
            Icons.lock,
            '/privacySettings',
          ),
          _buildListTile(
            context,
            'Security',
            Icons.security,
            '/securitySettings',
          ),
          const Divider(),

          // Chats Section
          _buildSectionTitle('Chats'),
          _buildListTile(
            context,
            'Chat Backup',
            Icons.backup,
            '/chatBackup',
          ),
          _buildListTile(
            context,
            'Themes',
            Icons.color_lens,
            '/themes',
          ),
          _buildListTile(
            context,
            'Chat Settings',
            Icons.settings,
            '/chatSettings',
          ),
          const Divider(),

          // Notifications Section
          _buildSectionTitle('Notifications'),
          _buildListTile(
            context,
            'Message Notifications',
            Icons.notifications,
            '/messageNotifications',
          ),
          _buildListTile(
            context,
            'Group Notifications',
            Icons.group,
            '/groupNotifications',
          ),
          _buildListTile(
            context,
            'Call Notifications',
            Icons.call,
            '/callNotifications',
          ),
          const Divider(),

          // Storage and Data Section
          _buildSectionTitle('Storage and Data'),
          _buildListTile(
            context,
            'Manage Storage',
            Icons.storage,
            '/manageStorage',
          ),
          _buildListTile(
            context,
            'Data Usage',
            Icons.data_usage,
            '/dataUsage',
          ),
          const Divider(),

          // Help Section
          _buildSectionTitle('Help'),
          _buildListTile(
            context,
            'Help Center',
            Icons.help,
            '/helpCenter',
          ),
          _buildListTile(
            context,
            'About',
            Icons.info,
            '/about',
          ),
          const Divider(),

          // Logout Button
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () async {
              // Add your logout logic here
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    String routeName,
  ) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
