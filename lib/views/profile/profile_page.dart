import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';
import 'package:kaagappay/components/primary_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF4CAF50);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'lib/assets/LogoTBG.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.bell),
                  color: Colors.black,
                  onPressed: () {
                    // TODO: Handle notification click
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(LucideIcons.arrowLeft, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('lib/assets/farmer_placeholder.png'),
                  ),
                ),
                const SizedBox(height: 15),

                const Text(
                  'Juan Dela Cruz',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'juandelacruz@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Para sa kinabukasan ng mga anak, kakayanin lahat.',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                const Text(
                  '09123456789',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'www.facebook.com/juandelacruz',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Gapan City, Nueva Ecija',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        onPressed: () {
                          // TODO: Edit Profile action
                        },
                        icon: LucideIcons.edit2,
                        label: 'Edit Profile',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryButton(
                        onPressed: () {
                          // TODO: Share Profile action
                        },
                        icon: LucideIcons.share2,
                        label: 'Share Profile',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            // TODO: Add navigation logic here based on index
          },
        ),
      ),
    );
  }
}
