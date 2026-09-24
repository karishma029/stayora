
import 'package:flutter/material.dart';

import '../data/hostel_data.dart';
import '../services/matching_service.dart';
import 'smart_match_results_screen.dart';

class RequirementsScreen extends StatefulWidget {
  const RequirementsScreen({super.key});

  @override
  State<RequirementsScreen> createState() => _RequirementsScreenState();
}

class _RequirementsScreenState extends State<RequirementsScreen> {
  // ------------------------------------------------------------
  // Selected requirements
  // ------------------------------------------------------------

  String? selectedLocation;
  String? selectedGender;
  String? selectedSharing;
  String? selectedBudget;

  // ------------------------------------------------------------
  // Facility requirements
  // ------------------------------------------------------------

  bool foodRequired = true;
  bool wifiRequired = true;
  bool acRequired = false;
  bool laundryRequired = false;
  bool parkingRequired = false;
  bool securityRequired = true;

  // ------------------------------------------------------------
  // Distance
  // ------------------------------------------------------------

  double distance = 3.0;

  // ------------------------------------------------------------
  // Colors
  // ------------------------------------------------------------

  static const Color primaryPurple = Color(0xFF6252E8);
  static const Color secondaryPurple = Color(0xFF8B7CF6);
  static const Color backgroundColor = Color(0xFFF8F7FD);
  static const Color darkText = Color(0xFF19192E);
  static const Color softPurple = Color(0xFFEAE6FF);

  // ------------------------------------------------------------
  // Budget conversion
  // ------------------------------------------------------------

  int _getMaxBudget() {
    switch (selectedBudget) {
      case '₹5k - ₹7k':
        return 7000;

      case '₹7k - ₹9k':
        return 9000;

      case '₹9k - ₹12k':
        return 12000;

      case '₹12k - ₹15k':
        return 15000;

      case '₹15k+':
        return 20000;

      default:
        return 7000;
    }
  }

  // ------------------------------------------------------------
  // Find Matches
  // ------------------------------------------------------------

  void _findMatches() {
    // Check mandatory selections
    if (selectedLocation == null ||
        selectedGender == null ||
        selectedSharing == null ||
        selectedBudget == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Please select location, gender, sharing and budget.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );

      return;
    }

    // Smart matching
    final List<Map<String, dynamic>> results =
        MatchingService.findMatches(
      hostels: HostelData.hostels,
      location: selectedLocation!,
      gender: selectedGender!,
      sharing: selectedSharing!,
      maxBudget: _getMaxBudget(),
      food: foodRequired,
      wifi: wifiRequired,
      ac: acRequired,
      security: securityRequired,
      parking: parkingRequired,
      laundry: laundryRequired,
    );

    // No hostels available in selected location
    if (results.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'No hostels found in the selected location.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );

      return;
    }

    // Open smart match results
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SmartMatchResultsScreen(
            matches: results,
          );
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // Dropdown helper
  // ------------------------------------------------------------

  Widget _buildDropdown({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: primaryPurple,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
            hint: Text(
              'Select $title',
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primaryPurple,
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Facility option
  // ------------------------------------------------------------

  Widget _buildFacilityOption({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: value
              ? primaryPurple.withOpacity(0.35)
              : Colors.grey.shade200,
        ),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: primaryPurple,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 2,
        ),
        secondary: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: value
                ? softPurple
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            color: value
                ? primaryPurple
                : Colors.grey.shade600,
            size: 21,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Section title
  // ------------------------------------------------------------

  Widget _buildSectionTitle({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Build
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // --------------------------------------------------------
      // App Bar
      // --------------------------------------------------------

      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: darkText,
        title: const Text(
          'Find Your Perfect Stay',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // --------------------------------------------------------
      // Bottom button
      // --------------------------------------------------------

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 15,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SizedBox(
            height: 54,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _findMatches,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 21,
                  ),
                  SizedBox(width: 9),
                  Text(
                    'Find My Matches',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // --------------------------------------------------------
      // Body
      // --------------------------------------------------------

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------
              // Intro card
              // ------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      primaryPurple,
                      secondaryPurple,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tell us what you need',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'We will find hostels that match your lifestyle and budget.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.travel_explore_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ------------------------------------------------
              // Location
              // ------------------------------------------------

              _buildSectionTitle(
                title: 'Where do you want to stay?',
                subtitle: 'Choose your preferred location',
              ),

              const SizedBox(height: 14),

              _buildDropdown(
                title: 'Location',
                value: selectedLocation,
                icon: Icons.location_on_outlined,
                items: const [
                  'Gachibowli',
                  'Kondapur',
                  'Hitech City',
                  'Madhapur',
                  'Secunderabad',
                  'Other',
                ],
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Gender
              // ------------------------------------------------

              _buildSectionTitle(
                title: 'Who is the stay for?',
                subtitle: 'Select your preferred hostel type',
              ),

              const SizedBox(height: 14),

              _buildDropdown(
                title: 'Gender',
                value: selectedGender,
                icon: Icons.person_outline_rounded,
                items: const [
                  'Female',
                  'Male',
                  'Any',
                ],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Sharing
              // ------------------------------------------------

              _buildSectionTitle(
                title: 'How many people?',
                subtitle: 'Choose your preferred sharing type',
              ),

              const SizedBox(height: 14),

              _buildDropdown(
                title: 'Sharing',
                value: selectedSharing,
                icon: Icons.people_outline_rounded,
                items: const [
                  'Single',
                  '2 Sharing',
                  '3 Sharing',
                  '4 Sharing',
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSharing = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Budget
              // ------------------------------------------------

              _buildSectionTitle(
                title: 'What is your budget?',
                subtitle: 'Select your monthly rent range',
              ),

              const SizedBox(height: 14),

              _buildDropdown(
                title: 'Budget',
                value: selectedBudget,
                icon: Icons.currency_rupee_rounded,
                items: const [
                  '₹5k - ₹7k',
                  '₹7k - ₹9k',
                  '₹9k - ₹12k',
                  '₹12k - ₹15k',
                  '₹15k+',
                ],
                onChanged: (value) {
                  setState(() {
                    selectedBudget = value;
                  });
                },
              ),

              const SizedBox(height: 28),

              // ------------------------------------------------
              // Facilities
              // ------------------------------------------------

              _buildSectionTitle(
                title: 'What facilities do you need?',
                subtitle: 'Select the facilities important to you',
              ),

              const SizedBox(height: 14),

              _buildFacilityOption(
                title: 'Food',
                icon: Icons.restaurant_rounded,
                value: foodRequired,
                onChanged: (value) {
                  setState(() {
                    foodRequired = value;
                  });
                },
              ),

              _buildFacilityOption(
                title: 'Wi-Fi',
                icon: Icons.wifi_rounded,
                value: wifiRequired,
                onChanged: (value) {
                  setState(() {
                    wifiRequired = value;
                  });
                },
              ),

              _buildFacilityOption(
                title: 'Air Conditioning',
                icon: Icons.ac_unit_rounded,
                value: acRequired,
                onChanged: (value) {
                  setState(() {
                    acRequired = value;
                  });
                },
              ),

              _buildFacilityOption(
                title: 'Laundry',
                icon: Icons.local_laundry_service_rounded,
                value: laundryRequired,
                onChanged: (value) {
                  setState(() {
                    laundryRequired = value;
                  });
                },
              ),

              _buildFacilityOption(
                title: 'Parking',
                icon: Icons.local_parking_rounded,
                value: parkingRequired,
                onChanged: (value) {
                  setState(() {
                    parkingRequired = value;
                  });
                },
              ),

              _buildFacilityOption(
                title: '24/7 Security',
                icon: Icons.security_rounded,
                value: securityRequired,
                onChanged: (value) {
                  setState(() {
                    securityRequired = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Distance
              // ------------------------------------------------

              _buildSectionTitle(
                title: 'How far can you travel?',
                subtitle: 'Choose the maximum distance from your preferred area',
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  14,
                  16,
                  10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.near_me_outlined,
                              color: primaryPurple,
                              size: 21,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Maximum distance',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: darkText,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: softPurple,
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${distance.toStringAsFixed(0)} km',
                            style: const TextStyle(
                              color: primaryPurple,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: distance,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      activeColor: primaryPurple,
                      inactiveColor:
                          primaryPurple.withOpacity(0.15),
                      onChanged: (value) {
                        setState(() {
                          distance = value;
                        });
                      },
                    ),
                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1 km',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '10 km',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // Smart matching information
              // ------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: softPurple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: primaryPurple,
                      size: 21,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Stayora will score hostels based on your requirements and show the best matching options first.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.45,
                          color: darkText,
                          fontWeight: FontWeight.w500,
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
    );
  }
}

