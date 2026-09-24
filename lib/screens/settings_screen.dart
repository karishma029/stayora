
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool locationServices = true;
  bool biometricLock = false;

  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FD),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF19192E),
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF19192E),
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =====================================================
            // APP PREFERENCES
            // =====================================================

            _sectionTitle('App Preferences'),

            const SizedBox(height: 10),

            _settingTile(
              icon: Icons.dark_mode_outlined,
              iconColor: const Color(0xFF6252E8),
              iconBackground: const Color(0xFFEAE6FF),
              title: 'Dark Mode',
              subtitle: 'Change the appearance of Stayora',
              trailing: Switch(
                value: darkMode,
                activeColor: const Color(0xFF6252E8),
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });

                  _showMessage(
                    value
                        ? 'Dark Mode enabled'
                        : 'Dark Mode disabled',
                  );
                },
              ),
            ),

            _settingTile(
              icon: Icons.location_on_outlined,
              iconColor: const Color(0xFFE25578),
              iconBackground: const Color(0xFFFFE7EE),
              title: 'Location Services',
              subtitle: 'Use location for better hostel matches',
              trailing: Switch(
                value: locationServices,
                activeColor: const Color(0xFF6252E8),
                onChanged: (value) {
                  setState(() {
                    locationServices = value;
                  });

                  _showMessage(
                    value
                        ? 'Location Services enabled'
                        : 'Location Services disabled',
                  );
                },
              ),
            ),

            _settingTile(
              icon: Icons.language_rounded,
              iconColor: const Color(0xFF2C9A5B),
              iconBackground: const Color(0xFFE5F6EC),
              title: 'Language',
              subtitle: 'Choose your preferred language',
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF858696),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'Telugu',
                    child: Text('Telugu'),
                  ),
                  DropdownMenuItem(
                    value: 'Hindi',
                    child: Text('Hindi'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    selectedLanguage = value;
                  });

                  _showMessage(
                    'Language changed to $value',
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            // =====================================================
            // PRIVACY & SECURITY
            // =====================================================

            _sectionTitle('Privacy & Security'),

            const SizedBox(height: 10),

            _settingTile(
              icon: Icons.fingerprint_rounded,
              iconColor: const Color(0xFF6252E8),
              iconBackground: const Color(0xFFEAE6FF),
              title: 'App Lock',
              subtitle: 'Protect your Stayora account',
              trailing: Switch(
                value: biometricLock,
                activeColor: const Color(0xFF6252E8),
                onChanged: (value) {
                  setState(() {
                    biometricLock = value;
                  });

                  _showMessage(
                    value
                        ? 'App Lock enabled'
                        : 'App Lock disabled',
                  );
                },
              ),
            ),

            _actionTile(
              icon: Icons.privacy_tip_outlined,
              iconColor: const Color(0xFF2C9A5B),
              iconBackground: const Color(0xFFE5F6EC),
              title: 'Privacy',
              subtitle: 'Manage your privacy preferences',
              onTap: () {
                _showPrivacyDialog();
              },
            ),

            _actionTile(
              icon: Icons.security_outlined,
              iconColor: const Color(0xFFFF9F43),
              iconBackground: const Color(0xFFFFF1DE),
              title: 'Security',
              subtitle: 'Account security information',
              onTap: () {
                _showSecurityDialog();
              },
            ),

            const SizedBox(height: 22),

            // =====================================================
            // DATA
            // =====================================================

            _sectionTitle('Data & Storage'),

            const SizedBox(height: 10),

            _actionTile(
              icon: Icons.cleaning_services_outlined,
              iconColor: const Color(0xFFE25578),
              iconBackground: const Color(0xFFFFE7EE),
              title: 'Clear Saved Preferences',
              subtitle: 'Reset your app preferences',
              onTap: () {
                _showClearDialog();
              },
            ),

            const SizedBox(height: 22),

            // =====================================================
            // ABOUT
            // =====================================================

            _sectionTitle('About'),

            const SizedBox(height: 10),

            _actionTile(
              icon: Icons.info_outline_rounded,
              iconColor: const Color(0xFF6252E8),
              iconBackground: const Color(0xFFEAE6FF),
              title: 'About Stayora',
              subtitle: 'Version 1.0.0',
              onTap: () {
                _showAboutDialog();
              },
            ),

            _actionTile(
              icon: Icons.description_outlined,
              iconColor: const Color(0xFF626273),
              iconBackground: const Color(0xFFEDEDF2),
              title: 'Terms & Conditions',
              subtitle: 'Read Stayora terms',
              onTap: () {
                _showMessage(
                  'Terms & Conditions coming soon',
                );
              },
            ),

            _actionTile(
              icon: Icons.policy_outlined,
              iconColor: const Color(0xFF2C9A5B),
              iconBackground: const Color(0xFFE5F6EC),
              title: 'Privacy Policy',
              subtitle: 'Read our privacy policy',
              onTap: () {
                _showMessage(
                  'Privacy Policy coming soon',
                );
              },
            ),

            const SizedBox(height: 25),

            // =====================================================
            // VERSION
            // =====================================================

            Center(
              child: Column(
                children: const [
                  Text(
                    'Stayora',
                    style: TextStyle(
                      color: Color(0xFF6252E8),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Find a stay that fits you.',
                    style: TextStyle(
                      color: Color(0xFF9999A8),
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Color(0xFFB0AFBA),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // SECTION TITLE
  // =============================================================

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF19192E),
      ),
    );
  }

  // =============================================================
  // SETTING TILE
  // =============================================================

  Widget _settingTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE3E1EC),
        ),
      ),
      child: Row(
        children: [

          Container(
            height: 43,
            width: 43,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 21,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF29293B),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF858696),
                  ),
                ),
              ],
            ),
          ),

          trailing,
        ],
      ),
    );
  }

  // =============================================================
  // ACTION TILE
  // =============================================================

  Widget _actionTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE3E1EC),
        ),
      ),
      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 5,
        ),

        leading: Container(
          height: 43,
          width: 43,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 21,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF29293B),
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF858696),
            ),
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15,
          color: Color(0xFF9999A8),
        ),
      ),
    );
  }

  // =============================================================
  // MESSAGE
  // =============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =============================================================
  // PRIVACY DIALOG
  // =============================================================

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Privacy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF19192E),
            ),
          ),
          content: const Text(
            'Stayora uses your profile and hostel preferences '
            'to provide personalized hostel recommendations.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF858696),
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
                  color: Color(0xFF6252E8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =============================================================
  // SECURITY DIALOG
  // =============================================================

  void _showSecurityDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Security',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF19192E),
            ),
          ),
          content: const Text(
            'Your Stayora account security settings can be '
            'managed from this section.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF858696),
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
                  color: Color(0xFF6252E8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =============================================================
  // CLEAR PREFERENCES
  // =============================================================

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Clear Preferences?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF19192E),
            ),
          ),
          content: const Text(
            'This will reset your current app preferences.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF858696),
            ),
          ),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF858696),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  darkMode = false;
                  locationServices = true;
                  biometricLock = false;
                  selectedLanguage = 'English';
                });

                Navigator.pop(context);

                _showMessage(
                  'Preferences reset successfully',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6252E8),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  // =============================================================
  // ABOUT DIALOG
  // =============================================================

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAE6FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.home_work_rounded,
                  color: Color(0xFF6252E8),
                  size: 34,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Stayora',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF19192E),
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Find a stay that fits you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF858696),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF9999A8),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFF6252E8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

