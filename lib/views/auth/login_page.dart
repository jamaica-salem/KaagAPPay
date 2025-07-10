import 'package:flutter/material.dart';
import 'package:kaagappay/helpers/navigate_pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _fieldEmail;
  late final FocusNode _fieldPass;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fieldEmail = FocusNode();
    _fieldPass = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fieldEmail.dispose();
    _fieldPass.dispose();
    super.dispose();
  }

  void _unfocusAllFields() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF4CAF50);
    const Color secondaryGreen = Color(0xFF81C784);

    return GestureDetector(
      onTap: _unfocusAllFields,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'lib/assets/BrandingTBG.png',
                    width: 300,
                    height: 300,
                  ),
                ),

                const Text(
                  'Log In',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    focusNode: _fieldEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontFamily: 'Sora'),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(fontFamily: 'Sora'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryGreen),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (_) => FocusScope.of(context).requestFocus(_fieldPass),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    focusNode: _fieldPass,
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(fontFamily: 'Sora'),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(fontFamily: 'Sora'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryGreen),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (_) => _fieldPass.unfocus(),
                  ),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, NavigatePages.marketTrend);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, NavigatePages.signup);
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 12,
                            color: primaryGreen,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      const Expanded(child: Divider(thickness: 0.5)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(thickness: 0.5)),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset('lib/assets/google.png'),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
