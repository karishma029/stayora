
import 'package:flutter/material.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
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
          'My Bookings',
          style: TextStyle(
            color: Color(0xFF19192E),
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          18,
          16,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6252E8),
                    Color(0xFF8B7CF6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Bookings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Manage your hostel bookings',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Upcoming',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF19192E),
              ),
            ),

            const SizedBox(height: 12),

            _bookingCard(
              context: context,
              hostelName: 'Urban Nest Premium Hostel',
              location: 'Gachibowli, Hyderabad',
              price: '₹8,500/month',
              sharing: '2 Sharing',
              date: '15 October 2026',
              bookingId: 'STY-2026-00125',
              status: 'Confirmed',
            ),

            const SizedBox(height: 25),

            const Text(
              'Booking Information',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF19192E),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE3E1EC),
                ),
              ),
              child: Column(
                children: [
                  _infoRow(
                    Icons.calendar_month_rounded,
                    'Move-in Date',
                    '15 October 2026',
                  ),
                  _infoRow(
                    Icons.people_alt_outlined,
                    'Room Type',
                    '2 Sharing',
                  ),
                  _infoRow(
                    Icons.currency_rupee_rounded,
                    'Monthly Rent',
                    '₹8,500',
                  ),
                  _infoRow(
                    Icons.verified_rounded,
                    'Booking Status',
                    'Confirmed',
                  ),
                  _infoRow(
                    Icons.confirmation_number_outlined,
                    'Booking ID',
                    'STY-2026-00125',
                    last: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF0EEFF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF6252E8),
                    size: 21,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Please carry a valid ID and your booking details when visiting the hostel.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: Color(0xFF6252E8),
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

  Widget _bookingCard({
    required BuildContext context,
    required String hostelName,
    required String location,
    required String price,
    required String sharing,
    required String date,
    required String bookingId,
    required String status,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE3E1EC),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAE6FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.apartment_rounded,
                  color: Color(0xFF6252E8),
                  size: 30,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hostelName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF19192E),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Color(0xFF858696),
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            location,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF858696),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F6FB),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _smallDetail(
                    Icons.calendar_today_rounded,
                    'Move-in',
                    date,
                  ),
                ),
                Container(
                  height: 35,
                  width: 1,
                  color: const Color(0xFFE1DFEA),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _smallDetail(
                    Icons.currency_rupee_rounded,
                    'Rent',
                    price,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F6EC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 15,
                      color: Color(0xFF2C9A5B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C9A5B),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                sharing,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6252E8),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Divider(
            height: 1,
            color: Color(0xFFE8E6EF),
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Booking ID: $bookingId',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF858696),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _showBookingDetails(
                    context,
                    hostelName,
                    location,
                    price,
                    sharing,
                    date,
                    bookingId,
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF6252E8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallDetail(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF6252E8),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF858696),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF29293B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value, {
    bool last = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: last ? 0 : 14,
      ),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEAE6FF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 18,
              color: const Color(0xFF6252E8),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF858696),
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF29293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingDetails(
    BuildContext context,
    String hostelName,
    String location,
    String price,
    String sharing,
    String date,
    String bookingId,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            25,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD8D6E1),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Booking Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF19192E),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  hostelName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF29293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF858696),
                  ),
                ),
                const SizedBox(height: 18),
                _bottomRow('Booking ID', bookingId),
                _bottomRow('Room Type', sharing),
                _bottomRow('Move-in Date', date),
                _bottomRow('Monthly Rent', price),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F6EC),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF2C9A5B),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Booking Confirmed',
                        style: TextStyle(
                          color: Color(0xFF2C9A5B),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bottomRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF858696),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF29293B),
            ),
          ),
        ],
      ),
    );
  }
}

