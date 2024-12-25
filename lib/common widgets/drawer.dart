// lib/widgets/drawer.dart
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text(
                "Abhishek Mishra",
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text("abhishekm977@gmail.com"),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
          _buildDrawerItem(
            context,
            Icons.person,
            'My Profile',
            () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.book,
            'My Course',
            () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.workspace_premium,
            'Go Premium',
            () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.video_label,
            'Saved Videos',
            () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.edit,
            'Edit Profile',
            () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.logout,
            'LogOut',
            () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // Helper function to avoid repeating the ListTile code
  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
