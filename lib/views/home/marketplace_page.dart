import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';
import 'package:kaagappay/helpers/navigate_pages.dart';
import 'package:kaagappay/components/custom_app_bar.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  static const Color primaryGreen = Color(0xFF4CAF50);
  int _currentIndex = 1;

  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _marketplaceItems = [
    {
      'name': 'Onions',
      'stock': '10',
      'location': 'Pampanga City',
      'price': '₱100/kg',
      'category': 'Crops/Seeds',
      'image': 'lib/assets/onions.jpg'
    },
    {
      'name': 'Tomatoes',
      'stock': '25',
      'location': 'Tarlac',
      'price': '₱90/kg',
      'category': 'Crops/Seeds',
      'image': 'lib/assets/tomatoes.jpg'
    },
    {
      'name': 'Carrots',
      'stock': '15',
      'location': 'Baguio',
      'price': '₱80/kg',
      'category': 'Crops/Seeds',
      'image': 'lib/assets/carrots.jpg'
    },
    {
      'name': 'Fertilizer',
      'stock': '50',
      'location': 'Nueva Ecija',
      'price': '₱1200/sack',
      'category': 'Materials',
      'image': 'lib/assets/fertilizer.jpg'
    },
    {
      'name': 'Pesticide',
      'stock': '5 gallons',
      'location': 'Isabela',
      'price': '₱1500/gallon',
      'category': 'Materials',
      'image': 'lib/assets/pesticide.jpg'
    },
  ];

  final List<String> _categories = ['All', 'Crops/Seeds', 'Materials'];

  @override
  Widget build(BuildContext context) {
    final filteredItems = _marketplaceItems.where((item) {
      final matchesSearch = item['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || item['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
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
                'Marketplace',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search marketplace...',
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
                  ),
                  const SizedBox(width: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, NavigatePages.sellProduct);
                      },
                      icon: const Icon(LucideIcons.plus, size: 16, color: Colors.white),
                      label: const Text(
                        'Sell',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ChoiceChip(
                        label: Text(category, style: const TextStyle(fontFamily: 'Sora', fontSize: 13)),
                        selected: isSelected,
                        selectedColor: primaryGreen.withOpacity(0.2),
                        backgroundColor: const Color(0xFFF5F5F5),
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return MouseRegion( // 👈 Added MouseRegion here
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          NavigatePages.productDetails,
                          arguments: item,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item['image'],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image, color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(fontFamily: 'Sora', fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Stocks left: ${item['stock']}',
                                    style: const TextStyle(fontFamily: 'Sora', fontSize: 13, color: Colors.black54),
                                  ),
                                  Text(
                                    item['location'],
                                    style: const TextStyle(fontFamily: 'Sora', fontSize: 13, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              item['price'],
                              style: const TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (filteredItems.isEmpty)
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
              case 0: Navigator.pushNamed(context, NavigatePages.marketTrend); break;
              case 1: Navigator.pushNamed(context, NavigatePages.marketplace); break;
              case 2: Navigator.pushNamed(context, NavigatePages.news); break;
              case 3: Navigator.pushNamed(context, NavigatePages.settings); break;
            }
          },
        ),
      ),
    );
  }
}
