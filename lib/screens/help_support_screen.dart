import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          'Help & Support',
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
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryPurple,
                    secondaryPurple,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.support_agent_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'How can we help you?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Find answers or contact our support team.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // FAQ Section
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                color: darkText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _faqTile(
              context,
              'How does Smart Match work?',
              'Smart Match compares your requirements such as location, budget, sharing, food, Wi-Fi and other preferences with available hostels.',
            ),

            _faqTile(
              context,
              'How can I save a hostel?',
              'Open any hostel details page and tap the heart icon to save or remove the hostel from your saved list.',
            ),

            _faqTile(
              context,
              'How can I schedule a visit?',
              'Open a hostel, select Schedule Visit, choose your preferred date and time, and confirm your visit.',
            ),

            _faqTile(
              context,
              'How can I book a hostel?',
              'Open the hostel details page, tap Book Now, enter your details, select a payment method and confirm your booking.',
            ),

            _faqTile(
              context,
              'Can I cancel a scheduled visit?',
              'You can open Scheduled Visits from your profile and use the cancel option for an upcoming visit.',
            ),

            const SizedBox(height: 25),

            // Contact Support
            Text(
              'Contact Support',
              style: TextStyle(
                color: darkText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _supportTile(
              context,
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'Get help through email',
              onTap: () {
                _showMessage(
                  context,
                  'Email support will be available soon.',
                );
              },
            ),

            _supportTile(
              context,
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Chat with Support',
              subtitle: 'Talk to our support team',
              onTap: () {
                _showMessage(
                  context,
                  'Live chat will be available soon.',
                );
              },
            ),

            _supportTile(
              context,
              icon: Icons.phone_outlined,
              title: 'Call Support',
              subtitle: 'Speak with our support team',
              onTap: () {
                _showMessage(
                  context,
                  'Call support will be available soon.',
                );
              },
            ),

            const SizedBox(height: 25),

            Center(
              child: Text(
                'Stayora Support • We are here to help',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqTile(
    BuildContext context,
    String question,
    String answer,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE5E2F2),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 3,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        iconColor: primaryPurple,
        collapsedIconColor: Colors.grey,
        title: Text(
          question,
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.5,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _supportTile(
    BuildContext context, {
    required IconData icon,
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
          color: const Color(0xFFE5E2F2),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        leading: Container(
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
        title: Text(
          title,
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: primaryPurple,
      ),
    );
  }
}