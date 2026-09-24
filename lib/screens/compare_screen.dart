
import 'package:flutter/material.dart';

import 'hostel_details_screen.dart';

class CompareScreen extends StatelessWidget {
  final List<Map<String, dynamic>> hostels;

  CompareScreen({
    super.key,
    List<Map<String, dynamic>>? hostels,
  }) : hostels = hostels ?? _defaultHostels;

  static final List<Map<String, dynamic>> _defaultHostels = [
    {
      'name': 'Urban Nest Premium Hostel',
      'location': 'Gachibowli, Hyderabad',
      'price': '₹8,500',
      'sharing': '2 Sharing',
      'rating': '4.7',
      'match': '94%',
      'matchValue': 94,
      'food': true,
      'wifi': true,
      'ac': true,
      'laundry': false,
      'parking': true,
      'security': true,
    },
    {
      'name': 'Green Leaf Living',
      'location': 'Kondapur, Hyderabad',
      'price': '₹7,800',
      'sharing': '2 Sharing',
      'rating': '4.5',
      'match': '88%',
      'matchValue': 88,
      'food': true,
      'wifi': true,
      'ac': false,
      'laundry': true,
      'parking': false,
      'security': true,
    },
    {
      'name': 'Comfort Stay Homes',
      'location': 'Hitech City, Hyderabad',
      'price': '₹9,000',
      'sharing': '2 Sharing',
      'rating': '4.4',
      'match': '82%',
      'matchValue': 82,
      'food': true,
      'wifi': true,
      'ac': true,
      'laundry': false,
      'parking': false,
      'security': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> compareHostels =
        hostels.length > 3 ? hostels.take(3).toList() : hostels;

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
            Icons.arrow_back_ios_new_rounded,
            size: 19,
            color: Color(0xFF29293B),
          ),
        ),
        title: const Text(
          'Compare Hostels',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF19192E),
          ),
        ),
      ),

      body: compareHostels.length < 2
          ? _buildNotEnoughHostels(context)
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 25),

                  const Text(
                    'Your shortlisted options',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF19192E),
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    '${compareHostels.length} hostels selected for comparison.',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF858696),
                    ),
                  ),

                  const SizedBox(height: 18),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 125,
                          margin: const EdgeInsets.only(top: 142),
                          child: Column(
                            children: [
                              _featureLabel(
                                Icons.currency_rupee_rounded,
                                'Monthly Rent',
                              ),
                              _featureLabel(
                                Icons.bed_rounded,
                                'Sharing',
                              ),
                              _featureLabel(
                                Icons.star_rounded,
                                'Rating',
                              ),
                              _featureLabel(
                                Icons.auto_awesome_rounded,
                                'Match',
                              ),
                              _featureLabel(
                                Icons.restaurant_rounded,
                                'Food',
                              ),
                              _featureLabel(
                                Icons.wifi_rounded,
                                'Wi-Fi',
                              ),
                              _featureLabel(
                                Icons.ac_unit_rounded,
                                'AC',
                              ),
                              _featureLabel(
                                Icons.local_laundry_service_rounded,
                                'Laundry',
                              ),
                              _featureLabel(
                                Icons.local_parking_rounded,
                                'Parking',
                              ),
                              _featureLabel(
                                Icons.security_rounded,
                                'Security',
                              ),
                            ],
                          ),
                        ),

                        ...compareHostels.map(
                          (hostel) {
                            return _HostelCompareCard(
                              hostel: hostel,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEAFF),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          size: 19,
                          color: Color(0xFF6252E8),
                        ),
                        SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            'Match percentage is based on your selected '
                            'budget, location, sharing preference and '
                            'required facilities.',
                            style: TextStyle(
                              fontSize: 10,
                              height: 1.5,
                              color: Color(0xFF57536F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF6252E8),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Back to Matches',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6252E8),
            Color(0xFF5140C9),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.compare_arrows_rounded,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Compare before you choose',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'See prices, facilities and match scores together.',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFFEAE6FF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotEnoughHostels(
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFEAE6FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.compare_arrows_rounded,
                size: 40,
                color: Color(0xFF6252E8),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Select at least 2 hostels',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF19192E),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Choose two or more saved hostels to compare them side by side.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF858696),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF6252E8),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureLabel(
    IconData icon,
    String title,
  ) {
    return Container(
      height: 58,
      padding: const EdgeInsets.only(right: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE4E1ED),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 15,
            color: const Color(0xFF6252E8),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Color(0xFF555568),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HostelCompareCard extends StatelessWidget {
  final Map<String, dynamic> hostel;

  const _HostelCompareCard({
    required this.hostel,
  });

  String _text(String key) {
    final value = hostel[key];

    if (value == null) {
      return '-';
    }

    return value.toString();
  }

  bool _bool(String key) {
    return hostel[key] == true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE4E1ED),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 142,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFEAE6FF),
                  Color(0xFFD9D3FF),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.apartment_rounded,
                    size: 55,
                    color: Color(0xFF6252E8),
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C9A5B),
                      borderRadius:
                          BorderRadius.circular(7),
                    ),
                    child: Text(
                      _text('match'),
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 86,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    _text('name'),
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF29293B),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: Color(0xFF858696),
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          _text('location'),
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF858696),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          _valueRow(
            _text('price'),
            isHighlighted: true,
          ),

          _valueRow(
            _text('sharing'),
          ),

          _valueRow(
            _text('rating'),
            icon: Icons.star_rounded,
          ),

          _valueRow(
            _text('match'),
            isHighlighted: true,
          ),

          _booleanRow(_bool('food')),
          _booleanRow(_bool('wifi')),
          _booleanRow(_bool('ac')),
          _booleanRow(_bool('laundry')),
          _booleanRow(_bool('parking')),
          _booleanRow(_bool('security')),

          Padding(
            padding: const EdgeInsets.all(9),
            child: SizedBox(
              width: double.infinity,
              height: 38,
              child: ElevatedButton(
                onPressed: () {
                  final String matchText =
                      _text('match')
                          .replaceAll('%', '');

                  final int matchValue =
                      int.tryParse(
                        _text('matchValue'),
                      ) ??
                      int.tryParse(matchText) ??
                      0;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HostelDetailsScreen(
                          hostelName: _text('name'),
                          location: _text('location'),
                          price: _text('price'),
                          sharing: _text('sharing'),
                          rating: _text('rating'),
                          match: matchValue,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF6252E8),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(9),
                  ),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _valueRow(
    String value, {
    bool isHighlighted = false,
    IconData? icon,
  }) {
    return Container(
      height: 58,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE4E1ED),
          ),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: const Color(0xFFE5A400),
              ),
              const SizedBox(width: 3),
            ],
            Flexible(
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isHighlighted
                      ? FontWeight.w800
                      : FontWeight.w600,
                  color: isHighlighted
                      ? const Color(0xFF6252E8)
                      : const Color(0xFF555568),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _booleanRow(bool available) {
    return Container(
      height: 58,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE4E1ED),
          ),
        ),
      ),
      child: Center(
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: available
                ? const Color(0xFFEAF8F0)
                : const Color(0xFFF4F3F6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            available
                ? Icons.check_rounded
                : Icons.close_rounded,
            size: 15,
            color: available
                ? const Color(0xFF2C9A5B)
                : const Color(0xFF9A99A4),
          ),
        ),
      ),
    );
  }
}

