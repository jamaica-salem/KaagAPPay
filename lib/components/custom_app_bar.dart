import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({Key? key, this.height = 80.0}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Material(  // ✅ Add this Material wrapper
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 400,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TabBar(
                      labelColor: Color(0xFF4CAF50),
                      unselectedLabelColor: Colors.black54,
                      labelStyle: TextStyle(fontFamily: 'Sora', fontWeight: FontWeight.w600),
                      indicatorColor: Color(0xFF4CAF50),
                      tabs: [
                        Tab(text: 'Trends'),
                        Tab(text: 'System'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(LucideIcons.trendingUp, color: Color(0xFF4CAF50)),
                              title: Text('Market prices are rising for Crop ${index + 1}',
                                  style: const TextStyle(fontFamily: 'Sora', fontSize: 13)),
                              subtitle: const Text('2 hours ago', style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(LucideIcons.info, color: Colors.orange),
                              title: Text('System update scheduled for 10 PM',
                                  style: const TextStyle(fontFamily: 'Sora', fontSize: 13)),
                              subtitle: const Text('1 day ago', style: TextStyle(fontSize: 11)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('lib/assets/LogoTBG.png', height: 40, width: 40),
          ),
          IconButton(
            icon: const Icon(LucideIcons.bell),
            color: Colors.black,
            onPressed: () => _showNotifications(context),
          ),
        ],
      ),
    );
  }
}
