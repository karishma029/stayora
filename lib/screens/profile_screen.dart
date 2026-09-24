
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FD),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF19192E),
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        child: Column(
          children: [

            // ================= PROFILE HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6252E8),
                    Color(0xFF8B7CF6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [

                  Container(
                    height: 82,
                    width: 82,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'K',
                        style: TextStyle(
                          color: Color(0xFF6252E8),
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Karishma',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'karishma@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Hostel Explorer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ================= STATS =================
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    Icons.favorite_rounded,
                    '3',
                    'Saved',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    Icons.receipt_long_rounded,
                    '1',
                    'Bookings',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    Icons.event_available_rounded,
                    '1',
                    'Visits',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            _sectionTitle('My Activity'),

            const SizedBox(height: 10),

            // ================= SAVED HOSTELS =================
            _menuTile(
              icon: Icons.favorite_rounded,
              title: 'Saved Hostels',
              subtitle: 'View your shortlisted hostels',
              iconColor: const Color(0xFFE25578),
              iconBackground: const Color(0xFFFFE7EE),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/saved-hostels',
                );
              },
            ),

            // ================= BOOKINGS =================
            _menuTile(
              icon: Icons.receipt_long_rounded,
              title: 'My Bookings',
              subtitle: 'View and manage your bookings',
              iconColor: const Color(0xFF6252E8),
              iconBackground: const Color(0xFFEAE6FF),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/my-bookings',
                );
              },
            ),

            // ================= VISITS =================
            _menuTile(
              icon: Icons.event_available_rounded,
              title: 'Scheduled Visits',
              subtitle: 'Manage your hostel visits',
              iconColor: const Color(0xFF2C9A5B),
              iconBackground: const Color(0xFFE5F6EC),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/scheduled-visits',
                );
              },
            ),

            const SizedBox(height: 20),

            _sectionTitle('Account'),

            const SizedBox(height: 10),

            // ================= PERSONAL INFORMATION =================
            _menuTile(
              icon: Icons.person_outline_rounded,
              title: 'Personal Information',
              subtitle: 'Manage your profile details',
              iconColor: const Color(0xFF6252E8),
              iconBackground: const Color(0xFFEAE6FF),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/personal-information',
                );
              },
            ),

            // ================= NOTIFICATIONS =================
            _menuTile(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              subtitle: 'Manage your notifications',
              iconColor: const Color(0xFFFF9F43),
              iconBackground: const Color(0xFFFFF1DE),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/notifications',
                );
              },
            ),

            // ================= SETTINGS =================
            _menuTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'App preferences and settings',
              iconColor: const Color(0xFF626273),
              iconBackground: const Color(0xFFEDEDF2),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/settings',
                );
              },
            ),

            const SizedBox(height: 20),

            _sectionTitle('Support'),

            const SizedBox(height: 10),

            // ================= HELP =================
            _menuTile(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              subtitle: 'Get help with your account',
              iconColor: const Color(0xFF6252E8),
              iconBackground: const Color(0xFFEAE6FF),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Help & Support coming soon'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),

            // ================= ABOUT =================
            _menuTile(
              icon: Icons.info_outline_rounded,
              title: 'About Stayora',
              subtitle: 'Learn more about the app',
              iconColor: const Color(0xFF2C9A5B),
              iconBackground: const Color(0xFFE5F6EC),
              onTap: () {
                _showAbout(context);
              },
            ),

            const SizedBox(height: 20),

            // ================= LOGOUT =================
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFE25578),
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFFE25578),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFFFFC8D5),
                  ),
                  backgroundColor: const Color(0xFFFFF5F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Stayora • Find a stay that fits you',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF9999A8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget _statCard(
    IconData icon,
    String value,
    String label,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE3E1EC),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 21,
            color: const Color(0xFF6252E8),
          ),

          const SizedBox(height: 7),

          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF19192E),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF858696),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF19192E),
        ),
      ),
    );
  }

  // ============================================================
  // MENU TILE
  // ============================================================

  Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBackground,
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
          vertical: 4,
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

  // ============================================================
  // ABOUT
  // ============================================================

  void _showAbout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            22,
            14,
            22,
            25,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  height: 4,
                  width: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8D6E1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 22),

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

                const SizedBox(height: 14),

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

                const SizedBox(height: 15),

                const Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9999A8),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // LOGOUT DIALOG
  // ============================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF19192E),
            ),
          ),

          content: const Text(
            'Are you sure you want to logout from Stayora?',
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
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF858696),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Logged out successfully',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE25578),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

