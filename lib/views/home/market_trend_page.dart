import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';
import 'package:kaagappay/components/custom_app_bar.dart';

class MarketTrendPage extends StatefulWidget {
  const MarketTrendPage({Key? key}) : super(key: key);

  @override
  State<MarketTrendPage> createState() => _MarketTrendPageState();
}

class _MarketTrendPageState extends State<MarketTrendPage> {
  static const Color primaryGreen = Color(0xFF4CAF50);
  int _currentIndex = 0;

  String _searchQuery = '';
  String _selectedMonth = 'July';
  String _selectedYear = '2025';
  String _selectedType = 'All';

  final List<Map<String, dynamic>> _marketTrends = [
    {
      'name': 'Onions',
      'price': '₱120/kg',
      'change': '+5%',
      'icon': LucideIcons.sun,
      'type': 'Vegetables',
    },
    {
      'name': 'Garlic',
      'price': '₱150/kg',
      'change': '-2%',
      'icon': LucideIcons.leaf,
      'type': 'Vegetables',
    },
    {
      'name': 'Carrots',
      'price': '₱90/kg',
      'change': '+1%',
      'icon': LucideIcons.carrot,
      'type': 'Vegetables',
    },
    {
      'name': 'Cabbage',
      'price': '₱70/kg',
      'change': '+0%',
      'icon': LucideIcons.rocket,
      'type': 'Vegetables',
    },
    {
      'name': 'Potatoes',
      'price': '₱100/kg',
      'change': '-1%',
      'icon': LucideIcons.box,
      'type': 'Vegetables',
    },
    {
      'name': 'Tomatoes',
      'price': '₱110/kg',
      'change': '+3%',
      'icon': LucideIcons.flame,
      'type': 'Vegetables',
    },
    {
      'name': 'Mangoes',
      'price': '₱140/kg',
      'change': '+4%',
      'icon': LucideIcons.apple,
      'type': 'Fruits',
    },
    {
      'name': 'Bananas',
      'price': '₱60/kg',
      'change': '+2%',
      'icon': LucideIcons.banana,
      'type': 'Fruits',
    },
    {
      'name': 'Rice',
      'price': '₱50/kg',
      'change': '+1%',
      'icon': LucideIcons.wheatOff,
      'type': 'Grains',
    },
    {
      'name': 'Corn',
      'price': '₱35/kg',
      'change': '-1%',
      'icon': LucideIcons.wheat,
      'type': 'Grains',
    },
  ];

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> _years = ['2023', '2024', '2025'];
  final List<String> _types = ['All', 'Vegetables', 'Fruits', 'Grains'];

  @override
  Widget build(BuildContext context) {
    // Filtering by name and type
    final filteredTrends = _marketTrends.where((item) {
      final nameMatch = item['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final typeMatch = _selectedType == 'All' || item['type'] == _selectedType;
      return nameMatch && typeMatch;
    }).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: const CustomAppBar(),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Market Trends',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),

              // Search Bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search goods...',
                  hintStyle: const TextStyle(fontFamily: 'Sora', color: Colors.grey),
                  prefixIcon: const Icon(LucideIcons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Filters Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: PopupMenuButton<String>(
                          onSelected: (value) => setState(() => _selectedMonth = value),
                          itemBuilder: (context) => _months
                              .map((month) => PopupMenuItem(value: month, child: Text(month)))
                              .toList(),
                          child: Chip(
                            label: Row(
                              children: [
                                Text(_selectedMonth, style: const TextStyle(fontFamily: 'Sora', fontSize: 12)),
                                const Icon(Icons.arrow_drop_down, size: 18),
                              ],
                            ),
                            avatar: const Icon(LucideIcons.calendar, size: 16, color: Colors.black),
                            backgroundColor: const Color(0xFFE8F5E9),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: PopupMenuButton<String>(
                          onSelected: (value) => setState(() => _selectedYear = value),
                          itemBuilder: (context) => _years
                              .map((year) => PopupMenuItem(value: year, child: Text(year)))
                              .toList(),
                          child: Chip(
                            label: Row(
                              children: [
                                Text(_selectedYear, style: const TextStyle(fontFamily: 'Sora', fontSize: 12)),
                                const Icon(Icons.arrow_drop_down, size: 18),
                              ],
                            ),
                            avatar: const Icon(LucideIcons.calendarDays, size: 16, color: Colors.black),
                            backgroundColor: const Color(0xFFE8F5E9),
                          ),
                        ),
                      ),
                    ],
                  ),

                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: PopupMenuButton<String>(
                      onSelected: (value) => setState(() => _selectedType = value),
                      itemBuilder: (context) => _types
                          .map((type) => PopupMenuItem(value: type, child: Text(type)))
                          .toList(),
                      icon: const Icon(LucideIcons.filter, size: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredTrends.length,
                itemBuilder: (context, index) {
                  final item = filteredTrends[index];
                  final isPositive = item['change'].toString().startsWith('+');

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryGreen.withOpacity(0.1),
                          child: Icon(item['icon'], color: primaryGreen),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'], style: const TextStyle(fontFamily: 'Sora', fontSize: 16, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text(item['price'], style: const TextStyle(fontFamily: 'Sora', fontSize: 13, color: Colors.black54)),
                            ],
                          ),
                        ),
                        Text(
                          item['change'],
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isPositive ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              if (filteredTrends.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text('No results found.', style: TextStyle(fontFamily: 'Sora', color: Colors.grey)),
                  ),
                ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == _currentIndex) return;
            setState(() => _currentIndex = index);
            switch (index) {
              case 0: Navigator.pushNamed(context, '/marketTrend'); break;
              case 1: Navigator.pushNamed(context, '/marketplace'); break;
              case 2: Navigator.pushNamed(context, '/news'); break;
              case 3: Navigator.pushNamed(context, '/settings'); break;
            }
          },
        ),
      ),
    );
  }
}
