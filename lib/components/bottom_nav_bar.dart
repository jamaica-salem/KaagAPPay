import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:kaagappay/helpers/navigate_pages.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  final Color primaryGreen = const Color(0xFF4CAF50);

  final List<_NavItem> _items = const [
    _NavItem(label: 'Home', icon: LucideIcons.home),
    _NavItem(label: 'Marketplace', icon: LucideIcons.store),
    _NavItem(label: 'Guides', icon: LucideIcons.bookOpen),
    _NavItem(label: 'Settings', icon: LucideIcons.settings),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleNavigation(int index) {
    widget.onTap(index);

    _animationController.forward().then((_) => _animationController.reverse());

    // Navigate using named routes from NavigatePages
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final isSelected = widget.currentIndex == index;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => _handleNavigation(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: isSelected ? _scaleAnimation.value : 1.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Icon(
                        _items[index].icon,
                        color: isSelected ? Colors.white : Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _items[index].label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;

  const _NavItem({required this.label, required this.icon});
}
