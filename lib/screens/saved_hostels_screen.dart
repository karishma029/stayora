
import 'package:flutter/material.dart';

import '../models/saved_hostel_manager.dart';
import 'compare_screen.dart';
import 'hostel_details_screen.dart';

class SavedHostelsScreen extends StatefulWidget {
  const SavedHostelsScreen({super.key});

  @override
  State<SavedHostelsScreen> createState() =>
      _SavedHostelsScreenState();
}

class _SavedHostelsScreenState
    extends State<SavedHostelsScreen> {
  final Set<String> selectedHostels = {};

  // ============================================================
  // REMOVE HOSTEL
  // ============================================================

  void _removeHostel(
    Map<String, dynamic> hostel,
  ) {
    final String hostelName =
        hostel['name']?.toString() ?? 'Hostel';

    setState(() {
      selectedHostels.remove(hostelName);
    });

    SavedHostelManager.removeHostel(hostelName);

    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '$hostelName removed from Saved Hostels',
          ),
          duration:
              const Duration(seconds: 2),
          behavior:
              SnackBarBehavior.floating,
          backgroundColor:
              const Color(0xFF6252E8),
        ),
      );
  }

  // ============================================================
  // OPEN DETAILS
  // ============================================================

  void _openHostelDetails(
    Map<String, dynamic> hostel,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HostelDetailsScreen(
            hostelName:
                hostel['name']?.toString() ?? '',
            location:
                hostel['location']?.toString() ?? '',
            price:
                hostel['price']?.toString() ?? '',
            sharing:
                hostel['sharing']?.toString() ?? '',
            rating:
                hostel['rating']?.toString() ?? '',
            match:
                _getMatch(hostel),
          );
        },
      ),
    );
  }

  // ============================================================
  // GET MATCH VALUE
  // ============================================================

  int _getMatch(
    Map<String, dynamic> hostel,
  ) {
    final dynamic value =
        hostel['matchValue'] ?? hostel['match'];

    if (value is num) {
      return value
          .toInt()
          .clamp(0, 100);
    }

    final String text =
        value?.toString().replaceAll('%', '') ?? '0';

    return int.tryParse(text)
            ?.clamp(0, 100) ??
        0;
  }

  // ============================================================
  // TOGGLE SELECTION
  // ============================================================

  void _toggleSelection(
    Map<String, dynamic> hostel,
  ) {
    final String name =
        hostel['name']?.toString() ?? '';

    if (name.isEmpty) return;

    setState(() {
      if (selectedHostels.contains(name)) {
        selectedHostels.remove(name);
      } else {
        // Maximum 3 hostels for comparison.
        if (selectedHostels.length >= 3) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'You can compare maximum 3 hostels.',
                ),
                duration:
                    Duration(seconds: 2),
                behavior:
                    SnackBarBehavior.floating,
                backgroundColor:
                    Color(0xFF6252E8),
              ),
            );
          return;
        }

        selectedHostels.add(name);
      }
    });
  }

  // ============================================================
  // PREPARE COMPARE DATA
  // ============================================================

  Map<String, dynamic> _prepareCompareData(
    Map<String, dynamic> hostel,
  ) {
    final Map<String, dynamic> data =
        Map<String, dynamic>.from(hostel);

    final int matchValue =
        _getMatch(hostel);

    data['matchValue'] = matchValue;
    data['match'] = '$matchValue%';

    // Facility defaults
    data['food'] ??= false;
    data['wifi'] ??= false;
    data['ac'] ??= false;
    data['security'] ??= false;
    data['parking'] ??= false;
    data['laundry'] ??= false;

    return data;
  }

  // ============================================================
  // OPEN COMPARE SCREEN
  // ============================================================

  void _openCompareScreen(
    List<Map<String, dynamic>> hostels,
  ) {
    if (selectedHostels.length < 2) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Please select at least 2 hostels to compare.',
            ),
            duration:
                Duration(seconds: 2),
            behavior:
                SnackBarBehavior.floating,
            backgroundColor:
                Color(0xFF6252E8),
          ),
        );

      return;
    }

    final List<Map<String, dynamic>> selected =
        hostels
            .where(
              (hostel) {
                final String name =
                    hostel['name']?.toString() ?? '';

                return selectedHostels
                    .contains(name);
              },
            )
            .take(3)
            .map(
              _prepareCompareData,
            )
            .toList();

    if (selected.length < 2) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Please select at least 2 valid hostels.',
            ),
            duration:
                Duration(seconds: 2),
            behavior:
                SnackBarBehavior.floating,
            backgroundColor:
                Color(0xFF6252E8),
          ),
        );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CompareScreen(
            hostels: selected,
          );
        },
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F7FD),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor:
            Colors.transparent,
        centerTitle: false,

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
          'Saved Hostels',
          style: TextStyle(
            fontSize: 20,
            fontWeight:
                FontWeight.bold,
            color:
                Color(0xFF19192E),
          ),
        ),

        actions: [
          ValueListenableBuilder<
              List<Map<String, dynamic>>>(
            valueListenable:
                SavedHostelManager.savedHostels,

            builder: (
              context,
              hostels,
              child,
            ) {
              if (hostels.isEmpty) {
                return const SizedBox();
              }

              return Padding(
                padding:
                    const EdgeInsets.only(
                  right: 16,
                ),
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(0xFFEAE6FF),
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Text(
                      '${hostels.length} Saved',
                      style:
                          const TextStyle(
                        color:
                            Color(0xFF6252E8),
                        fontSize: 12,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: ValueListenableBuilder<
          List<Map<String, dynamic>>>(
        valueListenable:
            SavedHostelManager.savedHostels,

        builder: (
          context,
          hostels,
          child,
        ) {
          // ======================================================
          // EMPTY STATE
          // ======================================================

          if (hostels.isEmpty) {
            if (selectedHostels.isNotEmpty) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    selectedHostels.clear();
                  });
                }
              });
            }

            return _buildEmptyState();
          }

          // Remove deleted hostels
          final Set<String> savedNames =
              hostels
                  .map(
                    (hostel) =>
                        hostel['name']?.toString() ?? '',
                  )
                  .toSet();

          selectedHostels.removeWhere(
            (name) =>
                !savedNames.contains(name),
          );

          return Column(
            children: [
              _buildCompareHeader(),

              Expanded(
                child:
                    ListView.builder(
                  padding:
                      const EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    30,
                  ),

                  itemCount:
                      hostels.length,

                  itemBuilder:
                      (context, index) {
                    final Map<String, dynamic>
                        hostel =
                        hostels[index];

                    return _buildHostelCard(
                      hostel: hostel,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // COMPARE HEADER
  // ============================================================

  Widget _buildCompareHeader() {
    final int selectedCount =
        selectedHostels.length;

    final bool canCompare =
        selectedCount >= 2;

    return Container(
      margin:
          const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        8,
      ),

      padding:
          const EdgeInsets.all(15),

      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color:
              const Color(0xFFE6E4F0),
        ),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 43,
                width: 43,

                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFFEAE6FF),
                  shape:
                      BoxShape.circle,
                ),

                child: const Icon(
                  Icons.compare_arrows_rounded,
                  color:
                      Color(0xFF6252E8),
                  size: 23,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Compare Hostels',
                      style:
                          TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(0xFF19192E),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      selectedCount == 0
                          ? 'Select hostels you want to compare.'
                          : '$selectedCount hostel${selectedCount == 1 ? '' : 's'} selected',
                      style:
                          const TextStyle(
                        fontSize: 10,
                        color:
                            Color(0xFF858696),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),

                decoration:
                    BoxDecoration(
                  color: canCompare
                      ? const Color(0xFFE5F6EC)
                      : const Color(0xFFF4F3F6),
                  borderRadius:
                      BorderRadius.circular(10),
                ),

                child: Text(
                  '$selectedCount/3',
                  style:
                      TextStyle(
                    fontSize: 10,
                    fontWeight:
                        FontWeight.bold,
                    color: canCompare
                        ? const Color(0xFF2C9A5B)
                        : const Color(0xFF858696),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 45,

            child:
                ElevatedButton.icon(
              onPressed: canCompare
                  ? () {
                      final hostels =
                          SavedHostelManager
                              .savedHostels
                              .value;

                      _openCompareScreen(
                        hostels,
                      );
                    }
                  : null,

              icon: const Icon(
                Icons.compare_arrows_rounded,
                size: 18,
              ),

              label: Text(
                canCompare
                    ? 'Compare $selectedCount Hostels'
                    : 'Select at least 2 hostels',
                style:
                    const TextStyle(
                  fontSize: 11,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF6252E8),
                foregroundColor:
                    Colors.white,

                disabledBackgroundColor:
                    const Color(0xFFE3E1E8),

                disabledForegroundColor:
                    const Color(0xFF9997A3),

                elevation: 0,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HOSTEL CARD
  // ============================================================

  Widget _buildHostelCard({
    required Map<String, dynamic> hostel,
  }) {
    final String name =
        hostel['name']?.toString() ?? '';

    final String location =
        hostel['location']?.toString() ?? '';

    final String price =
        hostel['price']?.toString() ?? '';

    final String sharing =
        hostel['sharing']?.toString() ?? '';

    final String rating =
        hostel['rating']?.toString() ?? '';

    final int match =
        _getMatch(hostel);

    final bool isSelected =
        selectedHostels.contains(name);

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      decoration:
          BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: isSelected
              ? const Color(0xFF6252E8)
              : const Color(0xFFE6E4F0),

          width:
              isSelected ? 1.5 : 1,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ==================================================
            // HEADER
            // ==================================================

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Container(
                  height: 58,
                  width: 58,

                  decoration:
                      const BoxDecoration(
                    gradient:
                        LinearGradient(
                      colors: [
                        Color(0xFF6252E8),
                        Color(0xFF8B7CF6),
                      ],
                      begin:
                          Alignment.topLeft,
                      end:
                          Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),

                  child: const Icon(
                    Icons.apartment_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF19192E),
                        ),
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: [
                          const Icon(
                            Icons
                                .location_on_outlined,
                            size: 16,
                            color:
                                Color(0xFF858696),
                          ),

                          const SizedBox(width: 4),

                          Expanded(
                            child: Text(
                              location,
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,

                              style:
                                  const TextStyle(
                                fontSize: 12,
                                color:
                                    Color(0xFF858696),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 5),

                // =================================================
                // SELECT BUTTON
                // =================================================

                InkWell(
                  borderRadius:
                      BorderRadius.circular(25),

                  onTap: () {
                    _toggleSelection(
                      hostel,
                    );
                  },

                  child: Container(
                    height: 40,
                    width: 40,

                    decoration:
                        BoxDecoration(
                      color: isSelected
                          ? const Color(
                              0xFFEAE6FF)
                          : const Color(
                              0xFFF5F4FA),

                      shape:
                          BoxShape.circle,

                      border:
                          Border.all(
                        color: isSelected
                            ? const Color(
                                0xFF6252E8)
                            : const Color(
                                0xFFE0DEE8),
                      ),
                    ),

                    child: Icon(
                      isSelected
                          ? Icons
                              .check_circle_rounded
                          : Icons
                              .radio_button_unchecked_rounded,

                      color: isSelected
                          ? const Color(
                              0xFF6252E8)
                          : const Color(
                              0xFF858696),

                      size: 23,
                    ),
                  ),
                ),

                // =================================================
                // REMOVE
                // =================================================

                IconButton(
                  onPressed: () {
                    _removeHostel(
                      hostel,
                    );
                  },

                  icon:
                      const Icon(
                    Icons.favorite_rounded,
                    color:
                        Color(0xFFE25578),
                  ),

                  tooltip:
                      'Remove from saved',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ==================================================
            // MATCH + RATING
            // ==================================================

            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(0xFFE5F6EC),
                    borderRadius:
                        BorderRadius.circular(8),
                  ),

                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      const Icon(
                        Icons
                            .check_circle_rounded,
                        size: 15,
                        color:
                            Color(0xFF2C9A5B),
                      ),

                      const SizedBox(width: 4),

                      Text(
                        '$match% Match',
                        style:
                            const TextStyle(
                          fontSize: 11,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF2C9A5B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(0xFFFFF4D9),
                    borderRadius:
                        BorderRadius.circular(8),
                  ),

                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color:
                            Color(0xFFFFB400),
                      ),

                      const SizedBox(width: 3),

                      Text(
                        rating,
                        style:
                            const TextStyle(
                          fontSize: 11,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF29293B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ==================================================
            // PRICE + SHARING
            // ==================================================

            Row(
              children: [
                const Icon(
                  Icons.currency_rupee_rounded,
                  size: 20,
                  color:
                      Color(0xFF6252E8),
                ),

                const SizedBox(width: 3),

                Text(
                  price,
                  style:
                      const TextStyle(
                    fontSize: 19,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF19192E),
                  ),
                ),

                const Text(
                  '/month',
                  style:
                      TextStyle(
                    fontSize: 12,
                    color:
                        Color(0xFF858696),
                  ),
                ),

                const Spacer(),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(0xFFEAE6FF),
                    borderRadius:
                        BorderRadius.circular(9),
                  ),

                  child: Text(
                    sharing,
                    style:
                        const TextStyle(
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          Color(0xFF6252E8),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ==================================================
            // FACILITIES
            // ==================================================

            Wrap(
              spacing: 8,
              runSpacing: 8,

              children: [
                if (hostel['food'] == true)
                  _facilityChip(
                    Icons.restaurant_rounded,
                    'Food',
                  ),

                if (hostel['wifi'] == true)
                  _facilityChip(
                    Icons.wifi_rounded,
                    'Wi-Fi',
                  ),

                if (hostel['ac'] == true)
                  _facilityChip(
                    Icons.ac_unit_rounded,
                    'AC',
                  ),

                if (hostel['security'] == true)
                  _facilityChip(
                    Icons.security_rounded,
                    'Security',
                  ),

                if (hostel['parking'] == true)
                  _facilityChip(
                    Icons.local_parking_rounded,
                    'Parking',
                  ),

                if (hostel['laundry'] == true)
                  _facilityChip(
                    Icons.local_laundry_service_rounded,
                    'Laundry',
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // ==================================================
            // VIEW DETAILS
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 46,

              child:
                  ElevatedButton(
                onPressed: () {
                  _openHostelDetails(
                    hostel,
                  );
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF6252E8),

                  foregroundColor:
                      Colors.white,

                  elevation: 0,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(13),
                  ),
                ),

                child:
                    const Text(
                  'View Details',
                  style:
                      TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
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
        horizontal: 10,
        vertical: 7,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(0xFFF5F4FA),
        borderRadius:
            BorderRadius.circular(9),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Icon(
            icon,
            size: 15,
            color:
                const Color(0xFF6252E8),
          ),

          const SizedBox(width: 5),

          Text(
            text,
            style:
                const TextStyle(
              fontSize: 11,
              fontWeight:
                  FontWeight.w500,
              color:
                  Color(0xFF29293B),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              height: 110,
              width: 110,

              decoration:
                  const BoxDecoration(
                color:
                    Color(0xFFEAE6FF),
                shape:
                    BoxShape.circle,
              ),

              child:
                  const Icon(
                Icons
                    .favorite_border_rounded,
                size: 55,
                color:
                    Color(0xFF6252E8),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'No Saved Hostels',
              style:
                  TextStyle(
                fontSize: 21,
                fontWeight:
                    FontWeight.bold,
                color:
                    Color(0xFF19192E),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Hostels you save will appear here.\n'
              'Save your favourite hostels to compare them later.',
              textAlign:
                  TextAlign.center,
              style:
                  TextStyle(
                fontSize: 14,
                color:
                    Color(0xFF858696),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF6252E8),

                foregroundColor:
                    Colors.white,

                elevation: 0,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 13,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),

              child:
                  const Text(
                'Explore Hostels',
                style:
                    TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

