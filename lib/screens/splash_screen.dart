import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5865E8),
              Color(0xFF3423B8),
              Color(0xFF24158F),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -80,
                right: -60,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: -35,
                right: -15,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.10),
                      width: 1,
                    ),
                  ),
                ),
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 105,
                      height: 105,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.home_rounded,
                            size: 76,
                            color: Colors.white,
                          ),

                          Positioned(
                            bottom: 22,
                            child: Icon(
                              Icons.favorite_rounded,
                              size: 23,
                              color: const Color(0xFFFF8BEA),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'StaySure',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Tell us what you need.\n'
                      "We'll find your match.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 38,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 125,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            left: 15,
                            bottom: 0,
                            child: Icon(
                              Icons.home_work_rounded,
                              size: 95,
                              color: Colors.white.withOpacity(0.07),
                            ),
                          ),

                          Positioned(
                            left: 80,
                            bottom: -5,
                            child: Icon(
                              Icons.apartment_rounded,
                              size: 125,
                              color: Colors.white.withOpacity(0.06),
                            ),
                          ),

                          Positioned(
                            right: 30,
                            bottom: -5,
                            child: Icon(
                              Icons.home_work_rounded,
                              size: 120,
                              color: Colors.white.withOpacity(0.07),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _bottomFeature(
                            Icons.verified_rounded,
                            'Verified',
                          ),
                          _bottomFeature(
                            Icons.auto_awesome_rounded,
                            'Personalized',
                          ),
                          _bottomFeature(
                            Icons.check_circle_rounded,
                            'Transparent',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    Container(
                      width: 110,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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

  Widget _bottomFeature(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13,
          color: Colors.white.withOpacity(0.85),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}