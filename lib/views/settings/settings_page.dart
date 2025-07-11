import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';
import 'package:kaagappay/helpers/navigate_pages.dart';
import 'package:kaagappay/components/custom_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _currentIndex = 3; // Settings tab index

  static const Color primaryGreen = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Settings List
                _buildSettingTile(
                  icon: LucideIcons.user,
                  label: 'User Profile',
                  onTap: () => Navigator.pushNamed(context, NavigatePages.profile),
                ),
                const SizedBox(height: 10),

                _buildSettingTile(
                  icon: LucideIcons.info,
                  label: 'About Us',
                  onTap: () => Navigator.pushNamed(context, NavigatePages.aboutUs),
                ),
                const SizedBox(height: 10),

                _buildSettingTile(
                  icon: LucideIcons.shield,
                  label: 'Privacy Policy',
                  onTap: () => Navigator.pushNamed(context, NavigatePages.privacyPolicy),
                ),
                const SizedBox(height: 10),

                _buildSettingTile(
                  icon: LucideIcons.phone,
                  label: 'Contact',
                  onTap: () => Navigator.pushNamed(context, NavigatePages.contact),
                ),
                const SizedBox(height: 10),

                _buildSettingTile(
                  icon: LucideIcons.messageCircle,
                  label: 'Feedback',
                  onTap: () => Navigator.pushNamed(context, NavigatePages.feedback),
                ),
                const SizedBox(height: 10),

                _buildSettingTile(
                  icon: LucideIcons.helpCircle,
                  label: 'Help Center',
                  onTap: () => Navigator.pushNamed(context, NavigatePages.helpCenter),
                ),
                const SizedBox(height: 10),

                _buildSettingTile(
                  icon: LucideIcons.logOut,
                  label: 'Log Out',
                  isDestructive: true,
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex, // This highlights the active icon (Settings = 3)
          onTap: (index) {
            if (index == _currentIndex) return; // Prevents unnecessary navigation if already on this page

            setState(() {
              _currentIndex = index;
            });

            switch (index) {
              case 0:
                Navigator.pushNamed(context, NavigatePages.marketTrend);
                break;
              case 1:
                Navigator.pushNamed(context, NavigatePages.marketplace);
                break;
              case 2:
                Navigator.pushNamed(context, NavigatePages.news);
                break;
              case 3:
                Navigator.pushNamed(context, NavigatePages.settings);
                break;
            }
          },
        ),

      ),
    );
  }

  // Reusable tile widget
  Widget _buildSettingTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : primaryGreen),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Sora',
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: isDestructive ? Colors.red : const Color(0xFF333333),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: const Color(0xFFF9F9F9),
      onTap: onTap,
    );
  }

  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacementNamed(context, NavigatePages.login);
              // TODO: Add actual logout clearing if needed
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
