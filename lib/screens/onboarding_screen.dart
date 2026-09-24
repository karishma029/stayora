import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<OnboardingData> pages = const [
    OnboardingData(
      title: 'Find a hostel\nthat fits YOU',
      description:
          "Tell us your requirements\nand we'll find suitable hostels.",
      type: IllustrationType.hostel,
    ),
    OnboardingData(
      title: 'Smart Matching',
      description:
          'Get hostels based on your\nbudget, location & preferences.',
      type: IllustrationType.matching,
    ),
    OnboardingData(
      title: 'Verified Stays',
      description:
          'Compare verified hostels\nbefore you decide.',
      type: IllustrationType.verified,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goNext() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin();
    }
  }

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FF),
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- SKIP ----------------
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 6,
                ),
                child: TextButton(
                  onPressed: goToLogin,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xFF777777),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // ---------------- PAGES ----------------
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _OnboardingPage(
                    data: pages[index],
                  );
                },
              ),
            ),

            // ---------------- DOTS ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) {
                  final bool selected = currentPage == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: selected ? 22 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF6252E8)
                          : const Color(0xFFD7D5E5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            // ---------------- BUTTON ----------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: goNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6252E8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    currentPage == pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// ONBOARDING PAGE
// =====================================================

class _OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const _OnboardingPage({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Column(
        children: [
          // Illustration
          Expanded(
            flex: 6,
            child: Center(
              child: OnboardingIllustration(
                type: data.type,
              ),
            ),
          ),

          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 27,
              height: 1.15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF15172E),
            ),
          ),

          const SizedBox(height: 14),

          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.55,
              color: Color(0xFF60627A),
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

// =====================================================
// ILLUSTRATION
// =====================================================

class OnboardingIllustration extends StatelessWidget {
  final IllustrationType type;

  const OnboardingIllustration({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 285,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background blob
          Container(
            width: 230,
            height: 210,
            decoration: BoxDecoration(
              color: _backgroundColor(),
              borderRadius: BorderRadius.circular(110),
            ),
          ),

          // Small decorative circle
          Positioned(
            top: 30,
            right: 35,
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFFFDDF1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Small decorative circle
          Positioned(
            bottom: 28,
            left: 32,
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                color: Color(0xFFDCD8FF),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Illustration card
          Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: _buildMainIllustration(),
          ),

          // Extra decoration
          _buildDecoration(),
        ],
      ),
    );
  }

  Color _backgroundColor() {
    switch (type) {
      case IllustrationType.hostel:
        return const Color(0xFFFFEBDD);

      case IllustrationType.matching:
        return const Color(0xFFE8E4FF);

      case IllustrationType.verified:
        return const Color(0xFFE0F4EF);
    }
  }

  Widget _buildMainIllustration() {
    switch (type) {
      case IllustrationType.hostel:
        return const Icon(
          Icons.home_work_rounded,
          size: 105,
          color: Color(0xFF8A63E8),
        );

      case IllustrationType.matching:
        return const Icon(
          Icons.track_changes_rounded,
          size: 105,
          color: Color(0xFF6755D9),
        );

      case IllustrationType.verified:
        return const Icon(
          Icons.verified_user_rounded,
          size: 105,
          color: Color(0xFF21A895),
        );
    }
  }

  Widget _buildDecoration() {
    switch (type) {
      case IllustrationType.hostel:
        return Positioned(
          right: 22,
          bottom: 45,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFFC18BF2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.home_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        );

      case IllustrationType.matching:
        return Positioned(
          right: 18,
          bottom: 43,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFF9A8CEB),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.assignment_turned_in_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
        );

      case IllustrationType.verified:
        return Positioned(
          right: 15,
          bottom: 42,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: const Color(0xFF36B6A4),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.shield_rounded,
              color: Colors.white,
              size: 38,
            ),
          ),
        );
    }
  }
}

// =====================================================
// DATA
// =====================================================

class OnboardingData {
  final String title;
  final String description;
  final IllustrationType type;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.type,
  });
}

enum IllustrationType {
  hostel,
  matching,
  verified,
}