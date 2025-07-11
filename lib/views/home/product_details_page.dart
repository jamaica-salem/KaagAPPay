import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';
import 'package:kaagappay/components/custom_app_bar.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  static const Color primaryGreen = Color(0xFF4CAF50);

  final String farmerName = 'Juan Dela Cruz';
  final String farmerPhone = '+63 912 345 6789';
  final String farmerLocation = 'Pampanga City';
  final String facebookProfile = 'https://www.facebook.com/example.profile';

  void _launchFacebook(String facebookUrl) async {
    final Uri url = Uri.parse(facebookUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $facebookUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Back Button + Header
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.arrow_back, size: 24, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    product['image'] ?? '',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 220,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Product Name & Price
                Text(
                  product['name'] ?? '',
                  style: const TextStyle(fontFamily: 'Sora', fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  product['price'] ?? '',
                  style: const TextStyle(fontFamily: 'Sora', fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black87),
                ),

                const SizedBox(height: 12),

                // Stock and Location
                Row(
                  children: [
                    const Icon(LucideIcons.package, size: 16, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text('Stocks left: ${product['stock'] ?? ''} kg', style: const TextStyle(fontFamily: 'Sora', fontSize: 13, color: Colors.black54)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(LucideIcons.mapPin, size: 16, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text(product['location'] ?? '', style: const TextStyle(fontFamily: 'Sora', fontSize: 13, color: Colors.black54)),
                  ],
                ),

                const SizedBox(height: 24),

                // Farmer Details Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Farmer Information',
                        style: TextStyle(fontFamily: 'Sora', fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      _buildFarmerInfoRow(LucideIcons.user, farmerName),
                      const SizedBox(height: 8),
                      _buildFarmerInfoRow(LucideIcons.phone, farmerPhone),
                      const SizedBox(height: 8),
                      _buildFarmerInfoRow(LucideIcons.mapPin, farmerLocation),
                      const SizedBox(height: 8),
                      _buildFarmerInfoRow(LucideIcons.facebook, 'JuanDelaCruzFB'),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchFacebook(facebookProfile),
                          icon: const Icon(LucideIcons.facebook, color: Colors.white, size: 18),
                          label: const Text(
                            'View Facebook Profile',
                            style: TextStyle(fontFamily: 'Sora', fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Other Products',
                  style: TextStyle(fontFamily: 'Sora', fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),

                SizedBox(
                  height: 210,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildOtherProductCard('lib/assets/carrots.jpg', 'Carrots', '₱80/kg', 15),
                      _buildOtherProductCard('lib/assets/tomatoes.jpg', 'Tomatoes', '₱90/kg', 8),
                      _buildOtherProductCard('lib/assets/onions.jpg', 'Onions', '₱100/kg', 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: 1, onTap: (index) {}),
      ),
    );
  }

  Widget _buildFarmerInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(fontFamily: 'Sora', fontSize: 14)),
        ),
      ],
    );
  }

  Widget _buildOtherProductCard(String imagePath, String name, String price, int stocksLeft) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF5F5F5),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              width: 140,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 140,
                height: 100,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Sora', fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(price, style: const TextStyle(fontFamily: 'Sora', fontSize: 12, color: Colors.black54)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              'Stocks left: $stocksLeft kg',
              style: const TextStyle(fontFamily: 'Sora', fontSize: 11, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
