import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // =====================================================
  // LOGIN
  // =====================================================

  void login() {
    FocusScope.of(context).unfocus();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FF),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),

          child: Column(
            children: [

              const SizedBox(height: 30),

              // =================================================
              // LOGO
              // =================================================

              Container(
                width: 70,
                height: 70,

                decoration: BoxDecoration(
                  color: const Color(0xFFE9E4FF),
                  borderRadius: BorderRadius.circular(22),
                ),

                child: const Icon(
                  Icons.home_rounded,
                  size: 43,
                  color: Color(0xFF6852E8),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'StaySure',

                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3023A8),
                ),
              ),

              const SizedBox(height: 35),

              // =================================================
              // TITLE
              // =================================================

              const Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Welcome back!',

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17172E),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              const Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Login to continue',

                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF77798B),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // EMAIL / PHONE
              // =================================================

              _buildTextField(
                controller: emailController,
                hintText: 'Email or Phone',
                icon: Icons.person_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // =================================================
              // PASSWORD
              // =================================================

              TextField(
                controller: passwordController,

                obscureText: obscurePassword,

                decoration: InputDecoration(
                  hintText: 'Password',

                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF999AAA),
                  ),

                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: Color(0xFF707287),
                  ),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword =
                            !obscurePassword;
                      });
                    },

                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,

                      size: 20,

                      color: const Color(0xFF77798B),
                    ),
                  ),

                  filled: true,
                  fillColor: Colors.white,

                  contentPadding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 15,
                  ),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10),

                    borderSide: const BorderSide(
                      color: Color(0xFFE4E2ED),
                    ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10),

                    borderSide: const BorderSide(
                      color: Color(0xFFE4E2ED),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10),

                    borderSide: const BorderSide(
                      color: Color(0xFF6252E8),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // =================================================
              // REMEMBER ME / FORGOT PASSWORD
              // =================================================

              Row(
                children: [

                  SizedBox(
                    width: 24,
                    height: 24,

                    child: Checkbox(
                      value: rememberMe,

                      activeColor:
                          const Color(0xFF6252E8),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(4),
                      ),

                      onChanged: (value) {
                        setState(() {
                          rememberMe =
                              value ?? false;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 6),

                  const Text(
                    'Remember me',

                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666879),
                    ),
                  ),

                  const Spacer(),

                  TextButton(
                    onPressed: () {},

                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),

                    child: const Text(
                      'Forgot Password?',

                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6252E8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // =================================================
              // LOGIN BUTTON
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: login,

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF6252E8),

                    foregroundColor: Colors.white,

                    elevation: 0,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),

                  child: const Text(
                    'Login',

                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // =================================================
              // DIVIDER
              // =================================================

              Row(
                children: [

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(
                      horizontal: 12,
                    ),

                    child: Text(
                      'Or login with',

                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF858696),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // =================================================
              // SOCIAL LOGIN
              // =================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  _socialButton(
                    icon: 'G',
                    onPressed: () {},
                  ),

                  const SizedBox(width: 15),

                  _socialButton(
                    icon: '●',
                    onPressed: () {},
                  ),

                  const SizedBox(width: 15),

                  _socialButton(
                    icon: 'f',
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // =================================================
              // REGISTER
              // =================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Text(
                    "Don't have an account? ",

                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666879),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              const RegisterScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      'Register',

                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6252E8),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // TEXT FIELD
  // =====================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,

      keyboardType: keyboardType,

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: const TextStyle(
          fontSize: 13,
          color: Color(0xFF999AAA),
        ),

        prefixIcon: Icon(
          icon,
          size: 20,
          color: const Color(0xFF707287),
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 15,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: const BorderSide(
            color: Color(0xFFE4E2ED),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: const BorderSide(
            color: Color(0xFFE4E2ED),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: const BorderSide(
            color: Color(0xFF6252E8),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // SOCIAL BUTTON
  // =====================================================

  Widget _socialButton({
    required String icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,

      borderRadius:
          BorderRadius.circular(25),

      child: Container(
        width: 52,
        height: 42,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(21),

          border: Border.all(
            color: const Color(0xFFE3E1EC),
          ),
        ),

        alignment: Alignment.center,

        child: Text(
          icon,

          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,

            color: icon == 'f'
                ? const Color(0xFF4267B2)
                : const Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}