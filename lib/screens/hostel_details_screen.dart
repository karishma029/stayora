
import 'package:flutter/material.dart';

import '../models/hostel_model.dart';
import '../models/saved_hostel_manager.dart';
import 'booking_screen.dart';
import 'schedule_visit_screen.dart';

class HostelDetailsScreen extends StatefulWidget {
  // New way: pass complete HostelModel
  final HostelModel? hostel;

  // Old way: pass individual values
  final String? hostelName;
  final String? location;
  final String? price;
  final String? sharing;
  final String? rating;

  final int match;

  const HostelDetailsScreen({
    super.key,
    this.hostel,
    this.hostelName,
    this.location,
    this.price,
    this.sharing,
    this.rating,
    this.match = 0,
  });

  // ============================================================
  // SAFE VALUES
  // ============================================================

  String get displayName {
    return hostel?.name ?? hostelName ?? 'Hostel';
  }

  String get displayLocation {
    if (hostel != null) {
      return '${hostel!.location}, ${hostel!.city}';
    }

    return location ?? '';
  }

  String get displayPrice {
    if (hostel != null) {
      return '₹${hostel!.price}';
    }

    return price ?? '₹0';
  }

  String get displaySharing {
    return hostel?.sharing ?? sharing ?? '';
  }

  String get displayRating {
    if (hostel != null) {
      return hostel!.rating.toString();
    }

    return rating ?? '0.0';
  }

  bool get hasFood {
    return hostel?.food ?? true;
  }

  bool get hasWifi {
    return hostel?.wifi ?? true;
  }

  bool get hasAc {
    return hostel?.ac ?? true;
  }

  bool get hasSecurity {
    return hostel?.security ?? true;
  }

  bool get hasParking {
    return hostel?.parking ?? false;
  }

  bool get hasLaundry {
    return hostel?.laundry ?? true;
  }

  // ============================================================
  // STATE
  // ============================================================

  @override
  State<HostelDetailsScreen> createState() =>
      _HostelDetailsScreenState();
}

class _HostelDetailsScreenState
    extends State<HostelDetailsScreen> {
  // ============================================================
  // SAVE / UNSAVE
  // ============================================================

  bool get isSaved {
    return SavedHostelManager.isSaved(
      widget.displayName,
    );
  }

  Map<String, dynamic> get hostelData {
    return {
      'name': widget.displayName,
      'location': widget.displayLocation,
      'price': widget.displayPrice,
      'sharing': widget.displaySharing,
      'rating': widget.displayRating,
      'match': '${widget.match}%',
      'matchValue': widget.match,

      'food': widget.hasFood,
      'wifi': widget.hasWifi,
      'ac': widget.hasAc,
      'security': widget.hasSecurity,
      'parking': widget.hasParking,
      'laundry': widget.hasLaundry,
    };
  }

  void _toggleSave() {
    SavedHostelManager.toggleHostel(
      hostelData,
    );

    setState(() {});

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            isSaved
                ? '${widget.displayName} saved to your favourites'
                : '${widget.displayName} removed from saved hostels',
          ),
          duration: const Duration(
            seconds: 2,
          ),
          behavior:
              SnackBarBehavior.floating,
          backgroundColor:
              const Color(0xFF6252E8),
        ),
      );
  }

  // ============================================================
  // SCHEDULE VISIT
  // ============================================================

  void _scheduleVisit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScheduleVisitScreen(
            hostelName: widget.displayName,
          );
        },
      ),
    );
  }

  // ============================================================
  // BOOK NOW
  // ============================================================

  void _bookNow() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BookingScreen(
            hostelName: widget.displayName,
            location: widget.displayLocation,
            price: widget.displayPrice,
            sharing: widget.displaySharing,
            rating: widget.displayRating,
            match: widget.match,
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
    final int safeMatch =
        widget.match.clamp(0, 100).toInt();

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F7FD),

      // ========================================================
      // BOTTOM ACTION BAR
      // ========================================================

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            12,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 12,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _scheduleVisit,
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                    size: 18,
                  ),
                  label: const Text(
                    'Schedule Visit',
                  ),
                  style:
                      OutlinedButton.styleFrom(
                    foregroundColor:
                        const Color(0xFF6252E8),
                    side: const BorderSide(
                      color: Color(0xFF6252E8),
                    ),
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(13),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: _bookNow,
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF6252E8),
                    foregroundColor:
                        Colors.white,
                    elevation: 0,
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor:
            Colors.transparent,

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
          'Hostel Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF19192E),
          ),
        ),

        actions: [
          IconButton(
            onPressed: _toggleSave,
            icon: Icon(
              isSaved
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: isSaved
                  ? const Color(0xFFE25578)
                  : const Color(0xFF19192E),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          30,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // ==================================================
            // HERO
            // ==================================================

            Container(
              width: double.infinity,
              height: 210,
              decoration: BoxDecoration(
                gradient:
                    const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6252E8),
                    Color(0xFF8B7CF6),
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.apartment_rounded,
                      color: Colors.white,
                      size: 90,
                    ),
                  ),

                  Positioned(
                    left: 16,
                    top: 16,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.95),
                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons
                                .auto_awesome_rounded,
                            size: 15,
                            color:
                                Color(0xFF6252E8),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$safeMatch% Match',
                            style:
                                const TextStyle(
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(0xFF6252E8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // NAME
            // ==================================================

            Text(
              widget.displayName,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: Color(0xFF19192E),
              ),
            ),

            const SizedBox(height: 8),

            // ==================================================
            // LOCATION
            // ==================================================

            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Color(0xFF858696),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    widget.displayLocation,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF858696),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==================================================
            // RATING + MATCH + SHARING
            // ==================================================

            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 8,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        const Color(0xFFFFF4D9),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color:
                            Color(0xFFFFB400),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.displayRating,
                        style:
                            const TextStyle(
                          fontSize: 12,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF29293B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 8,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        const Color(0xFFE5F6EC),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$safeMatch% Match',
                    style:
                        const TextStyle(
                      fontSize: 12,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFF2C9A5B),
                    ),
                  ),
                ),

                const Spacer(),

                Text(
                  widget.displaySharing,
                  style:
                      const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        Color(0xFF6252E8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ==================================================
            // PRICE
            // ==================================================

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(17),
              decoration:
                  BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(17),
                border: Border.all(
                  color:
                      const Color(0xFFE6E4F0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration:
                        const BoxDecoration(
                      color:
                          Color(0xFFEAE6FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons
                          .currency_rupee_rounded,
                      color:
                          Color(0xFF6252E8),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Text(
                    'Monthly Rent',
                    style: TextStyle(
                      fontSize: 11,
                      color:
                          Color(0xFF858696),
                    ),
                  ),

                  const Spacer(),

                  Text(
                    widget.displayPrice,
                    style:
                        const TextStyle(
                      fontSize: 21,
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
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // FACILITIES
            // ==================================================

            const Text(
              'Facilities & Amenities',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF19192E),
              ),
            ),

            const SizedBox(height: 13),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.35,
              children: [
                if (widget.hasFood)
                  _facilityCard(
                    Icons.restaurant_rounded,
                    'Food',
                  ),
                if (widget.hasWifi)
                  _facilityCard(
                    Icons.wifi_rounded,
                    'Wi-Fi',
                  ),
                if (widget.hasAc)
                  _facilityCard(
                    Icons.ac_unit_rounded,
                    'AC',
                  ),
                if (widget.hasSecurity)
                  _facilityCard(
                    Icons.security_rounded,
                    'Security',
                  ),
                if (widget.hasParking)
                  _facilityCard(
                    Icons.local_parking_rounded,
                    'Parking',
                  ),
                if (widget.hasLaundry)
                  _facilityCard(
                    Icons
                        .local_laundry_service_rounded,
                    'Laundry',
                  ),
              ],
            ),

            const SizedBox(height: 24),

            // ==================================================
            // WHY MATCHES
            // ==================================================

            const Text(
              'Why this hostel matches you',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF19192E),
              ),
            ),

            const SizedBox(height: 13),

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(16),
              decoration:
                  BoxDecoration(
                color:
                    const Color(0xFFEDEAFF),
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _matchReason(
                    Icons.currency_rupee_rounded,
                    'Fits your selected budget',
                  ),
                  _matchReason(
                    Icons.location_on_outlined,
                    'Matches your preferred location',
                  ),
                  _matchReason(
                    Icons.people_outline_rounded,
                    'Suitable for ${widget.displaySharing}',
                  ),
                  _matchReason(
                    Icons.check_circle_outline_rounded,
                    'Good overall requirement match',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // SAVE INFO
            // ==================================================

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(15),
              decoration:
                  BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
                border: Border.all(
                  color:
                      const Color(0xFFE6E4F0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSaved
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color:
                        const Color(0xFFE25578),
                    size: 24,
                  ),

                  const SizedBox(width: 11),

                  Expanded(
                    child: Text(
                      isSaved
                          ? 'This hostel is saved in your favourites.'
                          : 'Save this hostel to compare it later with other hostels.',
                      style:
                          const TextStyle(
                        fontSize: 11,
                        height: 1.4,
                        color:
                            Color(0xFF666778),
                      ),
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

  // ============================================================
  // FACILITY CARD
  // ============================================================

  Widget _facilityCard(
    IconData icon,
    String title,
  ) {
    return Container(
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color:
              const Color(0xFFE6E4F0),
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color:
                const Color(0xFF6252E8),
            size: 25,
          ),

          const SizedBox(height: 7),

          Text(
            title,
            textAlign: TextAlign.center,
            style:
                const TextStyle(
              fontSize: 10,
              fontWeight:
                  FontWeight.w600,
              color:
                  Color(0xFF29293B),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MATCH REASON
  // ============================================================

  Widget _matchReason(
    IconData icon,
    String text,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        children: [
          Container(
            height: 31,
            width: 31,
            decoration:
                const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 17,
              color:
                  const Color(0xFF6252E8),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style:
                  const TextStyle(
                fontSize: 11,
                fontWeight:
                    FontWeight.w500,
                color:
                    Color(0xFF4F4D62),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


