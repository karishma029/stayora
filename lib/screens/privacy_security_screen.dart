
import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() =>
      _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState
    extends State<PrivacySecurityScreen> {
  static const Color primaryPurple = Color(0xFF6252E8);
  static const Color backgroundColor = Color(0xFFF8F7FD);
  static const Color darkText = Color(0xFF19192E);
  static const Color softPurple = Color(0xFFEAE6FF);

  bool appLock = false;
  bool biometricLock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Privacy & Security',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Security Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: softPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.security_rounded,
                    color: primaryPurple,
                    size: 38,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keep your account secure',
                          style: TextStyle(
                            color: darkText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Manage your privacy and security preferences.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Security',
              style: TextStyle(
                color: darkText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // App Lock
            _settingTile(
              icon: Icons.lock_outline_rounded,
              title: 'App Lock',
              subtitle: 'Require a lock when opening Stayora',
              trailing: Switch(
                value: appLock,
                activeColor: primaryPurple,
                onChanged: (value) {
                  setState(() {
                    appLock = value;
                  });

                  if (value) {
                    _showMessage(
                      'App Lock enabled for this demo.',
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 10),

            // Biometric Lock
            _settingTile(
              icon: Icons.fingerprint_rounded,
              title: 'Biometric Lock',
              subtitle: 'Use fingerprint or face authentication',
              trailing: Switch(
                value: biometricLock,
                activeColor: primaryPurple,
                onChanged: appLock
                    ? (value) {
                        setState(() {
                          biometricLock = value;
                        });

                        _showMessage(
                          value
                              ? 'Biometric Lock enabled for this demo.'
                              : 'Biometric Lock disabled.',
                        );
                      }
                    : null,
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Privacy',
              style: TextStyle(
                color: darkText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Privacy Policy
            _actionTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              subtitle: 'Learn how your information is handled',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/privacy-policy',
                );
              },
            ),

            const SizedBox(height: 10),

            // Terms
            _actionTile(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              subtitle: 'Read the terms for using Stayora',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/terms-conditions',
                );
              },
            ),

            const SizedBox(height: 10),

            // Data Information
            _actionTile(
              icon: Icons.info_outline_rounded,
              title: 'Data & Permissions',
              subtitle: 'Understand app permissions and data usage',
              onTap: () {
                _showDataDialog();
              },
            ),

            const SizedBox(height: 28),

            // Security Note
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE5E2F2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: primaryPurple,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'For better security, never share your passwords, OTPs or other sensitive information with anyone.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE5E2F2),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: softPurple,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: primaryPurple,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: darkText,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        trailing: trailing,
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE5E2F2),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: softPurple,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: primaryPurple,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: darkText,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _showDataDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Data & Permissions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Stayora may use information such as your profile details, accommodation preferences, saved hostels, bookings and scheduled visits to provide application features.\n\n'
            'Permission availability may vary depending on the features enabled in the application.',
            style: TextStyle(
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: primaryPurple,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: primaryPurple,
      ),
    );
  }
}

