import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final String hostelName;
  final String location;
  final String price;
  final String sharing;
  final String rating;
  final int match;

  const BookingScreen({
    super.key,
    required this.hostelName,
    required this.location,
    required this.price,
    required this.sharing,
    required this.rating,
    required this.match,
  });

  @override
  State<BookingScreen> createState() =>
      _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? moveInDate;
  String selectedPayment = 'UPI';

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  Future<void> selectMoveInDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.now().add(const Duration(days: 1)),
      firstDate:
          DateTime.now().add(const Duration(days: 1)),
      lastDate:
          DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6252E8),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF19192E),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        moveInDate = picked;
      });
    }
  }

  String get formattedMoveInDate {
    if (moveInDate == null) {
      return 'Select move-in date';
    }

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${moveInDate!.day} '
        '${months[moveInDate!.month - 1]} '
        '${moveInDate!.year}';
  }

  int get monthlyRent {
    final cleaned = widget.price
        .replaceAll('₹', '')
        .replaceAll(',', '')
        .trim();

    return int.tryParse(cleaned) ?? 0;
  }

  int get bookingAmount {
    if (monthlyRent == 0) {
      return 0;
    }

    return (monthlyRent * 10) ~/ 100;
  }

  int get totalAmount {
    return monthlyRent + bookingAmount;
  }

  String formatCurrency(int amount) {
    return '₹${amount.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        )}';
  }

  bool validateDetails() {
    if (nameController.text.trim().isEmpty) {
      showMessage('Please enter your name');
      return false;
    }

    if (phoneController.text.trim().length != 10) {
      showMessage('Please enter a valid 10-digit mobile number');
      return false;
    }

    if (moveInDate == null) {
      showMessage('Please select your move-in date');
      return false;
    }

    return true;
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFFE25578),
      ),
    );
  }

  void confirmBooking() {
    if (!validateDetails()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Confirm Booking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF19192E),
            ),
          ),
          content: Text(
            'You are booking ${widget.hostelName} '
            'for ${widget.sharing}.',
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF5F6072),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF858696),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showBookingSuccess();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF6252E8),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text(
                'Confirm',
              ),
            ),
          ],
        );
      },
    );
  }

  void showBookingSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          contentPadding:
              const EdgeInsets.fromLTRB(
            24,
            26,
            24,
            20,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F6EC),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 42,
                  color: Color(0xFF2C9A5B),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF19192E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your booking request for '
                '${widget.hostelName} has been submitted successfully.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF858696),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F2F9),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: const Text(
                  'Booking ID: STY-2026-00125',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6252E8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF6252E8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: Color(0xFF19192E),
      ),
    );
  }

  Widget inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE3E1EC),
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF6252E8),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF9999A8),
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool selected =
        selectedPayment == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = title;
        });
      },
      child: Container(
        margin:
            const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFF0EEFF)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xFF6252E8)
                : const Color(0xFFE3E1EC),
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFE2DEFF)
                    : const Color(0xFFF3F2F9),
                borderRadius:
                    BorderRadius.circular(11),
              ),
              child: Icon(
                icon,
                color:
                    const Color(0xFF6252E8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFF29293B),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color:
                          Color(0xFF858696),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? const Color(0xFF6252E8)
                  : const Color(0xFFB2B1BC),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: const Color(0xFF858696),
                fontWeight: bold
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFF29293B),
              fontWeight: bold
                  ? FontWeight.bold
                  : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F7FD),

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
          'Book Hostel',
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
          110,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            // Hostel summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6252E8),
                    Color(0xFF8B7CF6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.18),
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.apartment_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.hostelName,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white70,
                              size: 15,
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                widget.location,
                                overflow:
                                    TextOverflow.ellipsis,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white70,
                                  fontSize: 11,
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
            ),

            const SizedBox(height: 25),

            sectionTitle('Your Details'),

            const SizedBox(height: 12),

            inputField(
              controller: nameController,
              hint: 'Enter your full name',
              icon: Icons.person_outline_rounded,
            ),

            const SizedBox(height: 11),

            inputField(
              controller: phoneController,
              hint: 'Enter mobile number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 25),

            sectionTitle('Move-in Date'),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: selectMoveInDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(14),
                  border: Border.all(
                    color: moveInDate != null
                        ? const Color(0xFF6252E8)
                        : const Color(0xFFE3E1EC),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 43,
                      width: 43,
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFFEAE6FF),
                        borderRadius:
                            BorderRadius.circular(11),
                      ),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        color:
                            Color(0xFF6252E8),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Move-in date',
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  Color(0xFF858696),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formattedMoveInDate,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w600,
                              color: moveInDate !=
                                      null
                                  ? const Color(
                                      0xFF19192E)
                                  : const Color(
                                      0xFF858696),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Color(0xFF858696),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            sectionTitle('Payment Method'),

            const SizedBox(height: 12),

            paymentOption(
              title: 'UPI',
              subtitle:
                  'Pay securely using UPI',
              icon: Icons.account_balance_wallet_outlined,
            ),

            paymentOption(
              title: 'Card',
              subtitle:
                  'Credit / Debit card',
              icon: Icons.credit_card_outlined,
            ),

            paymentOption(
              title: 'Pay at Hostel',
              subtitle:
                  'Pay after visiting the hostel',
              icon: Icons.payments_outlined,
            ),

            const SizedBox(height: 25),

            sectionTitle('Booking Summary'),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE3E1EC),
                ),
              ),
              child: Column(
                children: [
                  summaryRow(
                    'Monthly Rent',
                    formatCurrency(monthlyRent),
                  ),
                  summaryRow(
                    'Room Type',
                    widget.sharing,
                  ),
                  summaryRow(
                    'Match Score',
                    '${widget.match}%',
                  ),
                  summaryRow(
                    'Booking Fee',
                    formatCurrency(bookingAmount),
                  ),
                  const Divider(
                    height: 18,
                    color: Color(0xFFE8E6EF),
                  ),
                  summaryRow(
                    'Total Payable',
                    formatCurrency(totalAmount),
                    bold: true,
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
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.security_rounded,
                    size: 20,
                    color: Color(0xFF6252E8),
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Your personal information is kept secure. '
                      'Please verify the hostel before making any payment.',
                      style: TextStyle(
                        fontSize: 11,
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

      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(
          16,
          12,
          16,
          18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            Color(0xFF858696),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formatCurrency(totalAmount),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(0xFF19192E),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: confirmBooking,
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
                            BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Confirm Booking',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            FontWeight.bold,
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