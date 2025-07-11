import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 2;
  late TabController _tabController;

  final TextEditingController _searchController = TextEditingController();
  String _activeCategory = 'All';

  final List<Map<String, String>> _allNewsArticles = [
    {
      'title': 'Farmers Benefit from New Agriculture Law',
      'summary': 'A new law improves livelihoods through modern agriculture.',
      'category': 'Agriculture',
      'image': 'https://via.placeholder.com/400x250'
    },
    {
      'title': 'Weather Forecast for this Week',
      'summary': 'Weekly weather updates for better planning.',
      'category': 'Weather',
      'image': 'https://via.placeholder.com/400x250'
    },
    {
      'title': 'Financial Support for Rural Communities',
      'summary': 'New grants help boost rural economic growth.',
      'category': 'Finance',
      'image': 'https://via.placeholder.com/400x250'
    },
  ];

  final List<String> _categories = ['All', 'Finance', 'Agriculture', 'Environment'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _filteredArticles() {
    return _allNewsArticles.where((article) {
      final matchesCategory = _activeCategory == 'All' || article['category'] == _activeCategory;
      final matchesSearch = article['title']!.toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Widget buildNewsCarousel(String sectionTitle, List<Map<String, String>> articles) {
    if (articles.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          sectionTitle,
          style: const TextStyle(
            fontFamily: 'Sora',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        article['image'] ?? '',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 120,
                          color: const Color(0xFFE0E0E0),
                          child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article['title'] ?? '',
                            style: const TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            article['summary'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontFamily: 'Sora', fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),

        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF4CAF50),
              unselectedLabelColor: Colors.black54,
              labelStyle: const TextStyle(fontFamily: 'Sora', fontWeight: FontWeight.w600),
              indicatorColor: const Color(0xFF4CAF50),
              tabs: const [
                Tab(text: 'News'),
                Tab(text: 'Weather'),
                Tab(text: 'Tips'),
              ],
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                  // 📰 News Tab
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // 🔍 Search Bar
                        TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Search news...',
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

                        // 🔗 Categories
                        SizedBox(
                          height: 35,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              final isSelected = _activeCategory == category;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Text(category, style: const TextStyle(fontFamily: 'Sora', fontSize: 13)),
                                  selected: isSelected,
                                  selectedColor: const Color(0xFF4CAF50).withOpacity(0.2),
                                  backgroundColor: const Color(0xFFF5F5F5),
                                  onSelected: (_) {
                                    setState(() => _activeCategory = category);
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        // 🏆 Top Stories
                        buildNewsCarousel('Top Stories', _filteredArticles()),

                        // 🌱 Agriculture
                        buildNewsCarousel(
                          'Agriculture News',
                          _filteredArticles().where((a) => a['category'] == 'Agriculture').toList(),
                        ),

                        // 💵 Finance
                        buildNewsCarousel(
                          'Finance News',
                          _filteredArticles().where((a) => a['category'] == 'Finance').toList(),
                        ),
                      ],
                    ),
                  ),

                  // 🌤 Weather Tab
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // 🔥 Weather Forecast Title
                        const Text(
                          '7-Day Weather Forecast',
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 🌤 Modern Weather Cards Carousel
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                              final weatherIcons = [
                                LucideIcons.sun,
                                LucideIcons.cloud,
                                LucideIcons.cloudSun,
                                LucideIcons.cloudRain,
                                LucideIcons.zap,
                                LucideIcons.cloudSnow,
                                LucideIcons.cloudDrizzle
                              ];
                              final temps = [32, 30, 28, 29, 27, 26, 31];

                              return Container(
                                width: 120,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFB2FFAB), Color(0xFF4CAF50)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(weatherIcons[index], size: 32, color: Colors.white),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${temps[index]}°C',
                                      style: const TextStyle(
                                        fontFamily: 'Sora',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      days[index],
                                      style: const TextStyle(
                                        fontFamily: 'Sora',
                                        fontSize: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 30),

                        // 🌾 Crop Recommendation Section
                        const Text(
                          'Crop & Farm Recommendations',
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '🌱 Best Time to Plant',
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Favorable planting conditions expected this week. Consider planting rice, corn, and green leafy vegetables.',
                                style: TextStyle(fontFamily: 'Sora', fontSize: 13, color: Colors.black87),
                              ),
                              SizedBox(height: 16),
                              Text(
                                '🌾 Harvest Advice',
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Best to schedule harvests during dry weather (Mon-Wed). Avoid late-week rains to protect crop quality.',
                                style: TextStyle(fontFamily: 'Sora', fontSize: 13, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ⚠️ Weather Alert Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD180), Color(0xFFFF7043)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: const [
                              Icon(LucideIcons.alertCircle, color: Colors.white, size: 28),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '⚠️ Storm advisory issued for Friday. Consider securing equipment and rescheduling outdoor work.',
                                  style: TextStyle(fontFamily: 'Sora', fontSize: 13, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  // 💡 Tips Tab
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // 📚 Catalogs Section Title
                        const Text(
                          'Farming Catalogs & Guides',
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 📚 Catalogs Carousel
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5, // Replace with your dynamic catalog list
                            itemBuilder: (context, index) {
                              final catalogTitles = [
                                'Organic Farming Tips',
                                'Pest Management',
                                'Water Conservation',
                                'Soil Health',
                                'Climate-Resilient Crops'
                              ];
                              final catalogImages = List.generate(5, (i) => 'https://via.placeholder.com/300x150');

                              return Container(
                                width: 240,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        catalogImages[index],
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 12,
                                        bottom: 12,
                                        right: 12,
                                        child: Text(
                                          catalogTitles[index],
                                          style: const TextStyle(
                                            fontFamily: 'Sora',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 30),

                        // 🎥 YouTube Section Title
                        const Text(
                          'Video Tutorials & Tips',
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 🎥 YouTube Video Previews List
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3, // Replace with dynamic YouTube data
                          itemBuilder: (context, index) {
                            final videoThumbnails = [
                              'https://img.youtube.com/vi/VIDEO_ID1/0.jpg',
                              'https://img.youtube.com/vi/VIDEO_ID2/0.jpg',
                              'https://img.youtube.com/vi/VIDEO_ID3/0.jpg',
                            ];
                            final videoTitles = [
                              'How to Grow Organic Vegetables',
                              'Irrigation Hacks for Small Farms',
                              'Composting Basics for Healthy Soil',
                            ];
                            final videoDescriptions = [
                              'Learn step-by-step how to set up your organic garden.',
                              'Discover affordable irrigation techniques for dry seasons.',
                              'Turn waste into gold with these composting tips.',
                            ];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                                    child: Image.network(
                                      videoThumbnails[index],
                                      width: 120,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            videoTitles[index],
                                            style: const TextStyle(
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            videoDescriptions[index],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Sora',
                                              fontSize: 12,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == _currentIndex) return;
            setState(() => _currentIndex = index);
            switch (index) {
              case 0: Navigator.pushNamed(context, '/market_trend'); break;
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
