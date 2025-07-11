import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';
import 'package:kaagappay/components/primary_button.dart';
import 'package:kaagappay/components/secondary_button.dart';
import 'package:kaagappay/components/custom_app_bar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();
  final FocusNode _contactFocus = FocusNode();
  final FocusNode _facebookFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();

  final ImagePicker _picker = ImagePicker();
  String _imagePath = '';

  static const Color primaryGreen = Color(0xFF4CAF50);

  int _currentIndex = 3; // For bottom navbar

  Future<void> _changeProfilePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );
      Navigator.pop(context);
    }
  }

  void _cancelEdit() {
    Navigator.pop(context);
  }

  void _unfocusAllFields() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocusAllFields,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: const CustomAppBar(),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button (same as profile page)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                // Profile Picture Section
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _imagePath.isNotEmpty
                          ? FileImage(File(_imagePath))
                          : const AssetImage('lib/assets/farmer_placeholder.png') as ImageProvider,
                    ),
                    FloatingActionButton.small(
                      onPressed: _changeProfilePicture,
                      backgroundColor: primaryGreen,
                      child: const Icon(Icons.edit, size: 18, color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Form Fields
                _buildTextField(controller: _emailController, label: 'Email Address', readOnly: true),
                const SizedBox(height: 12),
                _buildTextField(controller: _nameController, label: 'Name', focusNode: _nameFocus),
                const SizedBox(height: 12),
                _buildTextField(controller: _bioController, label: 'Bio / Introduction', focusNode: _bioFocus, maxLines: 3),
                const SizedBox(height: 12),
                _buildTextField(controller: _contactController, label: 'Contact Number', focusNode: _contactFocus, keyboardType: TextInputType.phone),
                const SizedBox(height: 12),
                _buildTextField(controller: _facebookController, label: 'Facebook Link', focusNode: _facebookFocus),
                const SizedBox(height: 12),
                _buildTextField(controller: _locationController, label: 'Location / Address', focusNode: _locationFocus),

                const SizedBox(height: 24),

                // Buttons using reusable components
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        onPressed: _cancelEdit,
                        label: 'Cancel',
                        borderColor: primaryGreen,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PrimaryButton(
                        onPressed: _saveProfile,
                        label: 'Save',
                        backgroundColor: primaryGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Bottom Navbar
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            // Add navigation logic here
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    FocusNode? focusNode,
    int maxLines = 1,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Sora',
          color: Color(0xFF333333),
          fontSize: 14,
        ),
        fillColor: const Color(0xFFE8F5E9),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE8F5E9), width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE8F5E9), width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      validator: (value) {
        if (!readOnly && (value == null || value.isEmpty)) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
