
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  bool bookingUpdates = true;
  bool visitReminders = true;
  bool hostelRecommendations = true;
  bool offersPromotions = false;
  bool appUpdates = true;

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF6252E8);
    const backgroundColor = Color(0xFFF8F7FD);
    const darkText = Color(0xFF19192E);

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: darkText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Notifications',
          style: TextStyle(
            color: darkText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Notification Preferences',
            style: TextStyle(
              color: darkText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          _notificationSwitch(
            title: 'Booking Updates',
            subtitle:
                'Get updates about your hostel bookings',
            icon: Icons.event_available_outlined,
            value: bookingUpdates,
            onChanged: (value) {
              setState(() {
                bookingUpdates = value;
              });
            },
          ),

          _notificationSwitch(
            title: 'Visit Reminders',
            subtitle:
                'Receive reminders before scheduled visits',
            icon: Icons.calendar_month_outlined,
            value: visitReminders,
            onChanged: (value) {
              setState(() {
                visitReminders = value;
              });
            },
          ),

          _notificationSwitch(
            title: 'Hostel Recommendations',
            subtitle:
                'Get personalized hostel suggestions',
            icon: Icons.home_work_outlined,
            value: hostelRecommendations,
            onChanged: (value) {
              setState(() {
                hostelRecommendations = value;
              });
            },
          ),

          _notificationSwitch(
            title: 'Offers & Promotions',
            subtitle:
                'Receive special offers and promotions',
            icon: Icons.local_offer_outlined,
            value: offersPromotions,
            onChanged: (value) {
              setState(() {
                offersPromotions = value;
              });
            },
          ),

          _notificationSwitch(
            title: 'App Updates',
            subtitle:
                'Get important updates about Stayora',
            icon: Icons.system_update_outlined,
            value: appUpdates,
            onChanged: (value) {
              setState(() {
                appUpdates = value;
              });
            },
          ),

          const SizedBox(height: 28),

          const Text(
            'Recent Notifications',
            style: TextStyle(
              color: darkText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          _recentNotification(
            icon: Icons.check_circle_outline,
            title: 'Booking Confirmed',
            message:
                'Your booking at Urban Nest Premium Hostel has been confirmed.',
            time: '2 hours ago',
          ),

          _recentNotification(
            icon: Icons.calendar_today_outlined,
            title: 'Visit Reminder',
            message:
                'Your hostel visit is scheduled for 10 October at 04:00 PM.',
            time: 'Yesterday',
          ),

          _recentNotification(
            icon: Icons.home_work_outlined,
            title: 'New Hostel Match',
            message:
                'A new hostel matching your requirements is available.',
            time: '2 days ago',
          ),

          _recentNotification(
            icon: Icons.favorite_border,
            title: 'Saved Hostel Update',
            message:
                'One of your saved hostels has updated its availability.',
            time: '3 days ago',
          ),
        ],
      ),
    );
  }

  Widget _notificationSwitch({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8E5F2),
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,

            decoration: BoxDecoration(
              color: const Color(0xFFEAE6FF),
              borderRadius: BorderRadius.circular(13),
            ),

            child: const Icon(
              Icons.notifications_none,
              color: Color(0xFF6252E8),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF19192E),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF77748A),
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            activeColor: const Color(0xFF6252E8),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _recentNotification({
    required IconData icon,
    required String title,
    required String message,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8E5F2),
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: const Color(0xFFEAE6FF),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: const Color(0xFF6252E8),
              size: 21,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF19192E),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF77748A),
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF9B98AA),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

