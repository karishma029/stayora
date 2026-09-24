
import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static const Color primaryPurple = Color(0xFF6252E8);
  static const Color backgroundColor = Color(0xFFF8F7FD);
  static const Color darkText = Color(0xFF19192E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Terms & Conditions',
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
                color: const Color(0xFFEAE6FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: primaryPurple,
                    size: 35,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Stayora Terms & Conditions',
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
              title: 'Acceptance of Terms',
              content:
                  'By using the Stayora application, you agree to follow these Terms & Conditions. If you do not agree with these terms, please do not use the application.',
            ),

            _section(
              number: '2',
              title: 'Use of Stayora',
              content:
                  'Stayora is designed to help users discover, compare, shortlist, visit and book accommodation options. Users should provide accurate information while using the application.',
            ),

            _section(
              number: '3',
              title: 'User Information',
              content:
                  'Users are responsible for ensuring that the personal information provided in the application is accurate and up to date.',
            ),

            _section(
              number: '4',
              title: 'Hostel Information',
              content:
                  'Hostel information such as pricing, facilities, availability, ratings and location may be provided by property owners or other sources. Users should verify important details with the property before making a final decision.',
            ),

            _section(
              number: '5',
              title: 'Bookings',
              content:
                  'A booking request made through Stayora may be subject to availability and confirmation from the accommodation provider. Users should review booking details before confirming.',
            ),

            _section(
              number: '6',
              title: 'Visits',
              content:
                  'Users can schedule property visits through the application. Visit timings may depend on property availability and confirmation.',
            ),

            _section(
              number: '7',
              title: 'Payments',
              content:
                  'Any payment made for accommodation is subject to the applicable terms of the accommodation provider and selected payment method.',
            ),

            _section(
              number: '8',
              title: 'Prohibited Activities',
              content:
                  'Users should not misuse the application, provide false information, attempt unauthorized access, or use Stayora for unlawful activities.',
            ),

            _section(
              number: '9',
              title: 'Changes to the Service',
              content:
                  'Stayora may update, modify or improve application features from time to time. Features and availability may change as the application evolves.',
            ),

            _section(
              number: '10',
              title: 'Contact & Support',
              content:
                  'If you have questions regarding these terms or need assistance, you can contact Stayora through the Help & Support section of the application.',
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
                  color: const Color(0xFFEAE6FF),
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

