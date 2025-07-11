import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';

class SellProductPage extends StatefulWidget {
  const SellProductPage({Key? key}) : super(key: key);

  @override
  State<SellProductPage> createState() => _SellProductPageState();
}

class _SellProductPageState extends State<SellProductPage> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final picker = ImagePicker();
  String? _selectedType;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stocksController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image. Please try again.')),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      setState(() {
        _isSubmitting = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSubmitting = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product successfully listed for sale!')),
        );

        Navigator.pop(context);
      });
    } else if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a product image.')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _stocksController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(fontFamily: 'Sora', color: Colors.grey),
      hintStyle: const TextStyle(fontFamily: 'Sora', color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1.8),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  onPressed: () {
                    // Notification logic here
                  },
                ),
              ],
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Header with Back Button and Title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Sell Product',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Image Upload Section
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      color: const Color(0xFFF5F5F5),
                    ),
                    child: _selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_selectedImage!, fit: BoxFit.cover, width: double.infinity, height: 180),
                    )
                        : const Center(
                      child: Icon(LucideIcons.imagePlus, size: 40, color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Product Details:',
                  style: TextStyle(fontFamily: 'Sora', fontSize: 16, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _titleController,
                  decoration: _inputDecoration('Title', ''),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a product title';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _inputDecoration('Price per kilo (₱)', ''),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the price per kilo';
                    }
                    final price = double.tryParse(value);
                    if (price == null || price <= 0) {
                      return 'Please enter a valid positive number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _stocksController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Stocks (kg)', ''),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter available stocks';
                    }
                    final stock = int.tryParse(value);
                    if (stock == null || stock < 0) {
                      return 'Please enter a valid stock number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _selectedType,
                  items: const [
                    DropdownMenuItem(
                      value: 'Crop/Seeds',
                      child: Text('Crop/Seeds', style: TextStyle(fontFamily: 'Sora')),
                    ),
                    DropdownMenuItem(
                      value: 'Materials',
                      child: Text('Materials', style: TextStyle(fontFamily: 'Sora')),
                    ),
                  ],
                  decoration: _inputDecoration('Type', 'Select product type'),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the type of product';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          side: const BorderSide(color: Color(0xFF4CAF50)),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontFamily: 'Sora', fontWeight: FontWeight.w600, color: Color(0xFF4CAF50)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                            : const Text(
                          'Sell',
                          style: TextStyle(fontFamily: 'Sora', fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomNavBar(currentIndex: 1, onTap: (index) {}),
      ),
    );
  }
}
