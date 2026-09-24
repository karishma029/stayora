
import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/scheduled_visits_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/personal_information_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/my_bookings_screen.dart';
import 'screens/saved_hostels_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/about_stayora_screen.dart';
import 'screens/terms_conditions_screen.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/privacy_security_screen.dart';
import 'screens/requirements_screen.dart';
import 'screens/smart_match_results_screen.dart';
import 'screens/search_filter_screen.dart';

void main() {
  runApp(const StayoraApp());
}

class StayoraApp extends StatelessWidget {
  const StayoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Stayora',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6252E8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F7FD),
      ),

      home: SplashScreen(),

      routes: {
        // Home
        '/home': (context) => const HomeScreen(),

        // Requirements
        '/requirements': (context) =>
            const RequirementsScreen(),

        // Search & Filters
        '/search-filter': (context) =>
            const SearchFilterScreen(),

        // Smart Match Results
        '/smart-match-results': (context) =>
            const SmartMatchResultsScreen(),

        // Saved Hostels
        '/saved-hostels': (context) =>
            const SavedHostelsScreen(),

        // My Bookings
        '/my-bookings': (context) =>
            const MyBookingsScreen(),

        // Scheduled Visits
        '/scheduled-visits': (context) =>
            const ScheduledVisitsScreen(),

        // Personal Information
        '/personal-information': (context) =>
            const PersonalInformationScreen(),

        // Notifications
        '/notifications': (context) =>
            NotificationsScreen(),

        // Settings
        '/settings': (context) =>
            const SettingsScreen(),

        // Privacy & Security
        '/privacy-security': (context) =>
            const PrivacySecurityScreen(),

        // Help & Support
        '/help-support': (context) =>
            const HelpSupportScreen(),

        // About Stayora
        '/about-stayora': (context) =>
            const AboutStayoraScreen(),

        // Terms & Conditions
        '/terms-conditions': (context) =>
            const TermsConditionsScreen(),

        // Privacy Policy
        '/privacy-policy': (context) =>
            const PrivacyPolicyScreen(),
      },
    );
  }
}

