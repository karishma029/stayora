
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const Color primaryPurple = Color(0xFF6252E8);
  static const Color backgroundColor = Color(0xFFF8F7FD);
  static const Color darkText = Color(0xFF19192E);
  static const Color softPurple = Color(0xFFEAE6FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Privacy Policy',
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
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: softPurple,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    color: primaryPurple,
                    size: 35,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Your Privacy Matters',
                      style: TextStyle(
                        color: darkText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            _section(
              number: '1',
              title: 'Information We Collect',
              content:
                  'Stayora may collect information that you provide while using the application, such as your name, email address, phone number, city and accommodation preferences.',
            ),

            _section(
              number: '2',
              title: 'How We Use Your Information',
              content:
                  'The information you provide may be used to personalize accommodation recommendations, support Smart Match results, manage saved hostels, schedule visits and process booking-related information.',
            ),

            _section(
              number: '3',
              title: 'Accommodation Preferences',
              content:
                  'Preferences such as budget, location, sharing type, food, Wi-Fi, AC and other requirements may be used to identify accommodation options that match your needs.',
            ),

            _section(
              number: '4',
              title: 'Bookings & Visits',
              content:
                  'Information related to bookings and scheduled visits may be used to display your booking and visit details within the application.',
            ),

            _section(
              number: '5',
              title: 'Saved Hostels',
              content:
                  'When you save a hostel, the selected accommodation may be stored so that you can access it later from your Saved Hostels section.',
            ),

            _section(
              number: '6',
              title: 'Notifications',
              content:
                  'If notifications are enabled, Stayora may display updates related to bookings, scheduled visits, recommendations, offers or application updates.',
            ),

            _section(
              number: '7',
              title: 'Data Security',
              content:
                  'Stayora aims to protect user information and reduce unauthorized access. Users should also protect their account information and avoid sharing sensitive login details with others.',
            ),

            _section(
              number: '8',
              title: 'Third-Party Services',
              content:
                  'Some application features may depend on external services or accommodation providers. Information shared with such services may be subject to their respective privacy practices.',
            ),

            _section(
              number: '9',
              title: 'User Choices',
              content:
                  'Users can manage available application preferences such as notifications, location services and other settings through the Settings section.',
            ),

            _section(
              number: '10',
              title: 'Changes to This Policy',
              content:
                  'This Privacy Policy may be updated when Stayora introduces new features or changes how information is handled. Users are encouraged to review this page periodically.',
            ),

            const SizedBox(height: 15),

            Center(
              child: Text(
                'Last updated: September 2026',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required String number,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE5E2F2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: softPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: primaryPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            content,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

