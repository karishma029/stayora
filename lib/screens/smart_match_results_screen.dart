
import 'package:flutter/material.dart';

import '../models/hostel_model.dart';
import '../data/hostel_data.dart';
import 'compare_screen.dart';
import 'hostel_details_screen.dart';

class SmartMatchResultsScreen extends StatelessWidget {
  final List<Map<String, dynamic>>? matches;

  const SmartMatchResultsScreen({
    super.key,
    this.matches,
  });

  // ============================================================
  // DEFAULT MATCHES
  // ============================================================

  List<Map<String, dynamic>> _defaultMatches() {
    return HostelData.hostels.map((hostel) {
      return {
        'hostel': hostel,
        'match': 85,
      };
    }).toList();
  }

  // ============================================================
  // COMPARE SCREEN
  // ============================================================

  void _openCompareScreen(
    BuildContext context,
    List<Map<String, dynamic>> allMatches,
  ) {
    final List<Map<String, dynamic>> compareHostels =
        allMatches.take(3).map((item) {
      final HostelModel hostel =
          item['hostel'] as HostelModel;

      final int match =
          (item['match'] as num?)?.toInt() ?? 0;

      final int safeMatch =
          match.clamp(0, 100);

      return {
        'name': hostel.name,
        'location':
            '${hostel.location}, ${hostel.city}',
        'price': '₹${hostel.price}',
        'sharing': hostel.sharing,
        'rating': hostel.rating.toString(),
        'match': '$safeMatch%',
        'matchValue': safeMatch,
        'food': hostel.food,
        'wifi': hostel.wifi,
        'ac': hostel.ac,
        'security': hostel.security,
        'parking': hostel.parking,
        'laundry': hostel.laundry,
      };
    }).toList();

    if (compareHostels.length < 2) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'At least 2 hostels are required for comparison.',
            ),
          ),
        );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CompareScreen(
            hostels: compareHostels,
          );
        },
      ),
    );
  }

  // ============================================================
  // VIEW DETAILS
  // ============================================================

  void _openDetails(
    BuildContext context,
    HostelModel hostel,
    int match,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HostelDetailsScreen(
            hostel: hostel,
            match: match,
          );
        },
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> displayMatches =
        matches ?? _defaultMatches();

    if (displayMatches.isEmpty) {
      return _buildNoResults(context);
    }

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
          'Smart Matches',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF19192E),
          ),
        ),
      ),

      body: Column(
        children: [
          // ====================================================
          // HEADER
          // ====================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              18,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEAE6FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFF6252E8),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Smart Matches',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF19192E),
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        '${displayMatches.length} hostels match your requirements',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF858696),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ====================================================
          // RESULTS
          // ====================================================

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                30,
              ),
              itemCount: displayMatches.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> item =
                    displayMatches[index];

                final HostelModel hostel =
                    item['hostel'] as HostelModel;

                final int match =
                    (item['match'] as num?)?.toInt() ?? 0;

                final int safeMatch =
                    match.clamp(0, 100);

                return _hostelCard(
                  context: context,
                  hostel: hostel,
                  match: safeMatch,
                  allMatches: displayMatches,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HOSTEL CARD
  // ============================================================

  Widget _hostelCard({
    required BuildContext context,
    required HostelModel hostel,
    required int match,
    required List<Map<String, dynamic>> allMatches,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE7E5F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // ==================================================
            // TOP
            // ==================================================

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAE6FF),
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.apartment_rounded,
                    size: 36,
                    color: Color(0xFF6252E8),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              hostel.name,
                              maxLines: 2,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.w700,
                                color:
                                    Color(0xFF19192E),
                              ),
                            ),
                          ),

                          const SizedBox(width: 6),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 5,
                            ),
                            decoration:
                                BoxDecoration(
                              color:
                                  const Color(0xFFE5F6EC),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$match%',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    Color(0xFF2C9A5B),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color:
                                Color(0xFF858696),
                          ),

                          const SizedBox(width: 3),

                          Expanded(
                            child: Text(
                              '${hostel.location}, ${hostel.city}',
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color:
                                    Color(0xFF858696),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color:
                                Color(0xFFFFB400),
                          ),

                          const SizedBox(width: 3),

                          Text(
                            hostel.rating.toString(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.w600,
                              color:
                                  Color(0xFF29293B),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Text(
                            hostel.sharing,
                            style: const TextStyle(
                              fontSize: 10,
                              color:
                                  Color(0xFF6252E8),
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ==================================================
            // PRICE
            // ==================================================

            Row(
              children: [
                Text(
                  '₹${hostel.price}',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight:
                        FontWeight.w800,
                    color:
                        Color(0xFF19192E),
                  ),
                ),

                const Text(
                  ' / month',
                  style: TextStyle(
                    fontSize: 10,
                    color:
                        Color(0xFF858696),
                  ),
                ),

                const Spacer(),

                Text(
                  hostel.gender,
                  style: const TextStyle(
                    fontSize: 10,
                    color:
                        Color(0xFF858696),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 13),

            // ==================================================
            // FACILITIES
            // ==================================================

            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                if (hostel.food)
                  _facilityChip(
                    Icons.restaurant_rounded,
                    'Food',
                  ),

                if (hostel.wifi)
                  _facilityChip(
                    Icons.wifi_rounded,
                    'Wi-Fi',
                  ),

                if (hostel.ac)
                  _facilityChip(
                    Icons.ac_unit_rounded,
                    'AC',
                  ),

                if (hostel.security)
                  _facilityChip(
                    Icons.security_rounded,
                    'Security',
                  ),

                if (hostel.parking)
                  _facilityChip(
                    Icons.local_parking_rounded,
                    'Parking',
                  ),

                if (hostel.laundry)
                  _facilityChip(
                    Icons.local_laundry_service_rounded,
                    'Laundry',
                  ),
              ],
            ),

            const SizedBox(height: 15),

            // ==================================================
            // MATCH MESSAGE
            // ==================================================

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color:
                    const Color(0xFFF4F2FF),
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    size: 15,
                    color:
                        Color(0xFF6252E8),
                  ),

                  const SizedBox(width: 7),

                  Expanded(
                    child: Text(
                      _matchMessage(match),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w500,
                        color:
                            Color(0xFF57546A),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // ACTION BUTTONS
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _openDetails(
                        context,
                        hostel,
                        match,
                      );
                    },

                    style:
                        OutlinedButton.styleFrom(
                      foregroundColor:
                          const Color(
                        0xFF6252E8,
                      ),

                      side:
                          const BorderSide(
                        color:
                            Color(0xFF6252E8),
                      ),

                      minimumSize:
                          const Size(
                        double.infinity,
                        45,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          11,
                        ),
                      ),
                    ),

                    child:
                        const Text(
                      'View Details',
                      style:
                          TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        allMatches.length < 2
                            ? null
                            : () {
                                _openCompareScreen(
                                  context,
                                  allMatches,
                                );
                              },

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF6252E8,
                      ),

                      foregroundColor:
                          Colors.white,

                      disabledBackgroundColor:
                          const Color(
                        0xFFE2E1E8,
                      ),

                      disabledForegroundColor:
                          const Color(
                        0xFF9998A5,
                      ),

                      elevation: 0,

                      minimumSize:
                          const Size(
                        double.infinity,
                        45,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          11,
                        ),
                      ),
                    ),

                    child:
                        const Text(
                      'Compare',
                      style:
                          TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FACILITY CHIP
  // ============================================================

  Widget _facilityChip(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color:
            const Color(0xFFF7F6FB),
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color:
                const Color(0xFF6252E8),
          ),

          const SizedBox(width: 4),

          Text(
            text,
            style: const TextStyle(
              fontSize: 9,
              fontWeight:
                  FontWeight.w600,
              color:
                  Color(0xFF5E5C6E),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MATCH MESSAGE
  // ============================================================

  String _matchMessage(
    int match,
  ) {
    if (match >= 90) {
      return 'Excellent match for your requirements';
    }

    if (match >= 75) {
      return 'Strong match based on your preferences';
    }

    if (match >= 60) {
      return 'Good match with most of your requirements';
    }

    return 'Some of your requirements match this hostel';
  }

  // ============================================================
  // NO RESULTS
  // ============================================================

  Widget _buildNoResults(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F7FD),

      appBar: AppBar(
        backgroundColor:
            Colors.white,

        elevation: 0,

        surfaceTintColor:
            Colors.transparent,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_rounded,
            color:
                Color(0xFF19192E),
          ),
        ),

        title: const Text(
          'Smart Matches',
          style: TextStyle(
            fontSize: 18,
            fontWeight:
                FontWeight.bold,
            color:
                Color(0xFF19192E),
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              Container(
                height: 95,
                width: 95,

                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFFEAE6FF),
                  shape:
                      BoxShape.circle,
                ),

                child: const Icon(
                  Icons.search_off_rounded,
                  size: 48,
                  color:
                      Color(0xFF6252E8),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              const Text(
                'No Exact Match Found',
                textAlign:
                    TextAlign.center,

                style:
                    TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.w800,
                  color:
                      Color(0xFF19192E),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                'We could not find a hostel that satisfies all your selected requirements.',

                textAlign:
                    TextAlign.center,

                style:
                    TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color:
                      Color(0xFF858696),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              Container(
                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  16,
                ),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    17,
                  ),

                  border:
                      Border.all(
                    color:
                        const Color(
                      0xFFE5E3EF,
                    ),
                  ),
                ),

                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons
                              .lightbulb_outline_rounded,
                          color:
                              Color(
                            0xFF6252E8,
                          ),
                        ),

                        const SizedBox(
                          width: 9,
                        ),

                        const Text(
                          'Try relaxing a filter',
                          style:
                              TextStyle(
                            fontSize: 14,
                            fontWeight:
                                FontWeight.w700,
                            color:
                                Color(
                              0xFF19192E,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      'You can increase your budget, choose “Any” for sharing, or remove one optional facility to see more hostels.',

                      style:
                          TextStyle(
                        fontSize: 11,
                        height: 1.5,
                        color:
                            Color(
                          0xFF858696,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width:
                    double.infinity,

                child:
                    ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },

                  icon:
                      const Icon(
                    Icons.tune_rounded,
                  ),

                  label:
                      const Text(
                    'Change Search Filters',
                  ),

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF6252E8,
                    ),

                    foregroundColor:
                        Colors.white,

                    elevation: 0,

                    minimumSize:
                        const Size(
                      double.infinity,
                      50,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

