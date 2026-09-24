
import 'package:flutter/material.dart';

class AboutStayoraScreen extends StatelessWidget {
  const AboutStayoraScreen({super.key});

  final Color primaryPurple = const Color(0xFF6252E8);
  final Color secondaryPurple = const Color(0xFF8B7CF6);
  final Color backgroundColor = const Color(0xFFF8F7FD);
  final Color darkText = const Color(0xFF19192E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'About Stayora',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),

            // App Logo
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryPurple,
                    secondaryPurple,
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.home_work_rounded,
                color: Colors.white,
                size: 48,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              'Stayora',
              style: TextStyle(
                color: darkText,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Find a stay that fits you',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            _infoCard(
              icon: Icons.lightbulb_outline_rounded,
              title: 'Our Idea',
              description:
                  'Stayora helps students and working professionals find accommodation based on their personal requirements instead of simply browsing a long list of hostels.',
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.auto_awesome_rounded,
              title: 'Smart Matching',
              description:
                  'Users can provide requirements such as location, budget, sharing preference, food, Wi-Fi, AC and other facilities. Stayora uses these preferences to show suitable accommodation options.',
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.compare_arrows_rounded,
              title: 'Compare & Shortlist',
              description:
                  'Users can compare accommodation options, save their favourites and shortlist places before making a decision.',
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.calendar_month_rounded,
              title: 'Visit & Book',
              description:
                  'Stayora allows users to schedule property visits and continue with the booking process after selecting a suitable stay.',
            ),

            const SizedBox(height: 25),

            // Mission
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEAE6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    color: primaryPurple,
                    size: 32,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Our Mission',
                    style: TextStyle(
                      color: darkText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Make finding the right stay simpler, smarter and more convenient.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Stayora',
              style: TextStyle(
                color: primaryPurple,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
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
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFEAE6FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: primaryPurple,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

