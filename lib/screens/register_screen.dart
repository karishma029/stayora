
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool agreeToTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void createAccount() {
    FocusScope.of(context).unfocus();

    // Registration API will be connected later.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FD),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              20,
              24,
              28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ==================================================
                // BACK BUTTON
                // ==================================================

                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: Color(0xFF333444),
                  ),
                ),

                const SizedBox(height: 22),

                // ==================================================
                // LOGO
                // ==================================================

                Center(
                  child: Column(
                    children: [

                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAE6FF),
                          borderRadius:
                              BorderRadius.circular(21),
                        ),
                        child: const Icon(
                          Icons.home_work_rounded,
                          size: 40,
                          color: Color(0xFF6252E8),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'StaySure',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4030B7),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ==================================================
                // TITLE
                // ==================================================

                const Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17172D),
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  'Tell us a little about yourself to get started.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF77788A),
                  ),
                ),

                const SizedBox(height: 28),

                // ==================================================
                // FULL NAME
                // ==================================================

                _fieldLabel('Full Name'),

                const SizedBox(height: 8),

                _textField(
                  controller: nameController,
                  hint: 'Enter your full name',
                  icon: Icons.person_outline_rounded,
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 18),

                // ==================================================
                // EMAIL
                // ==================================================

                _fieldLabel('Email'),

                const SizedBox(height: 8),

                _textField(
                  controller: emailController,
                  hint: 'Enter your email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 18),

                // ==================================================
                // PHONE
                // ==================================================

                _fieldLabel('Mobile Number'),

                const SizedBox(height: 8),

                _textField(
                  controller: phoneController,
                  hint: 'Enter your mobile number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 18),

                // ==================================================
                // PASSWORD
                // ==================================================

                _fieldLabel('Password'),

                const SizedBox(height: 8),

                _passwordField(
                  controller: passwordController,
                  hint: 'Create a password',
                  visible: isPasswordVisible,
                  onVisibilityChanged: () {
                    setState(() {
                      isPasswordVisible =
                          !isPasswordVisible;
                    });
                  },
                ),

                const SizedBox(height: 18),

                // ==================================================
                // CONFIRM PASSWORD
                // ==================================================

                _fieldLabel('Confirm Password'),

                const SizedBox(height: 8),

                _passwordField(
                  controller: confirmPasswordController,
                  hint: 'Re-enter your password',
                  visible: isConfirmPasswordVisible,
                  onVisibilityChanged: () {
                    setState(() {
                      isConfirmPasswordVisible =
                          !isConfirmPasswordVisible;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // ==================================================
                // TERMS
                // ==================================================

                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: agreeToTerms,
                        activeColor:
                            const Color(0xFF6252E8),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(4),
                        ),
                        onChanged: (value) {
                          setState(() {
                            agreeToTerms =
                                value ?? false;
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 7),

                    const Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 3),
                        child: Text(
                          'I agree to the Terms & Conditions and Privacy Policy.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Color(0xFF686979),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // ==================================================
                // CREATE ACCOUNT BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF6252E8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ==================================================
                // LOGIN
                // ==================================================

                Center(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [

                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF707181),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                FontWeight.w700,
                            color:
                                Color(0xFF6252E8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // FIELD LABEL
  // ==============================================================

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF363747),
      ),
    );
  }

  // ==============================================================
  // NORMAL TEXT FIELD
  // ==============================================================

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
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
          horizontal: 14,
        ),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _focusedBorder(),
      ),
    );
  }

  // ==============================================================
  // PASSWORD FIELD
  // ==============================================================

  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool visible,
    required VoidCallback onVisibilityChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          size: 20,
          color: Color(0xFF707287),
        ),
        suffixIcon: IconButton(
          onPressed: onVisibilityChanged,
          icon: Icon(
            visible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 20,
            color: const Color(0xFF77798A),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 14,
        ),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _focusedBorder(),
      ),
    );
  }

  // ==============================================================
  // BORDER
  // ==============================================================

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(
        color: Color(0xFFE2E0EA),
      ),
    );
  }

  // ==============================================================
  // FOCUSED BORDER
  // ==============================================================

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(
        color: Color(0xFF6252E8),
        width: 1.4,
      ),
    );
  }
}
