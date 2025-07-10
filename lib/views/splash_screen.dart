import 'package:flutter/material.dart';

/// SplashScreen displays the app logo with a fade-in animation.
/// This is the first screen shown while the app initializes.
///
/// Best practices applied:
/// - Uses StatelessWidget for cleaner rebuilds.
/// - Uses AnimationController with TickerProviderStateMixin.
/// - Handles potential animation errors gracefully.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  /// Initializes the animation controller and animation.
  @override
  void initState() {
    super.initState();

    try {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2), // Animation duration
      );

      _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
      );

      _animationController.forward(); // Start the animation

      // Optional: Navigate to home after delay (replace with your own logic)
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });

    } catch (e) {
      // Log the error (you can use Firebase Crashlytics or any logger here)
      debugPrint('Error initializing animation: $e');
    }
  }

  /// Disposes the animation controller to free resources.
  @override
  void dispose() {
    try {
      _animationController.dispose();
    } catch (e) {
      debugPrint('Error disposing animation: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using SafeArea to avoid status bar or notch issues on different devices.
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Use your app's theme color here
        body: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              'assets/BrandingTBG.SVG', // 🔑 Make sure this path is correct and declared in pubspec.yaml
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                // Handles edge case: if image fails to load
                return const Icon(Icons.error, size: 80, color: Colors.red);
              },
            ),
          ),
        ),
      ),
    );
  }
}
