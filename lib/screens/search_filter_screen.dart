
import 'package:flutter/material.dart';

import '../data/hostel_data.dart';
import '../services/matching_service.dart';
import 'smart_match_results_screen.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  State<SearchFilterScreen> createState() =>
      _SearchFilterScreenState();
}

class _SearchFilterScreenState
    extends State<SearchFilterScreen> {
  // ============================================================
  // CONTROLLER
  // ============================================================

  final TextEditingController locationController =
      TextEditingController();

  // ============================================================
  // FILTER VALUES
  // ============================================================

  String selectedGender = 'Any';
  String selectedSharing = 'Any';

  double maxBudget = 15000;

  bool food = false;
  bool wifi = false;
  bool ac = false;
  bool security = false;
  bool parking = false;

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  // ============================================================
  // CLEAR FILTERS
  // ============================================================

  void _clearFilters() {
    setState(() {
      locationController.clear();

      selectedGender = 'Any';
      selectedSharing = 'Any';

      maxBudget = 15000;

      food = false;
      wifi = false;
      ac = false;
      security = false;
      parking = false;
    });
  }

  // ============================================================
  // SEARCH
  // ============================================================

  void _searchHostels() {
    final String location =
        locationController.text.trim();

    if (location.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Please enter a location',
            ),
            behavior:
                SnackBarBehavior.floating,
          ),
        );

      return;
    }

    final matches =
        MatchingService.findMatches(
      hostels: HostelData.hostels,

      location: location,

      gender: selectedGender,

      sharing: selectedSharing,

      maxBudget:
          maxBudget.toInt(),

      food: food,

      wifi: wifi,

      ac: ac,

      security: security,

      parking: parking,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SmartMatchResultsScreen(
            matches: matches,
          );
        },
      ),
    );
  }

  // ============================================================
  // SELECTED REQUIREMENTS
  // ============================================================

  List<String> _selectedRequirements() {
    final List<String> requirements =
        [];

    if (locationController.text
        .trim()
        .isNotEmpty) {
      requirements.add(
        locationController.text.trim(),
      );
    }

    if (selectedGender != 'Any') {
      requirements.add(
        selectedGender,
      );
    }

    if (selectedSharing != 'Any') {
      requirements.add(
        selectedSharing,
      );
    }

    requirements.add(
      'Up to ₹${maxBudget.toInt()}',
    );

    if (food) {
      requirements.add('Food');
    }

    if (wifi) {
      requirements.add('Wi-Fi');
    }

    if (ac) {
      requirements.add('AC');
    }

    if (security) {
      requirements.add('Security');
    }

    if (parking) {
      requirements.add('Parking');
    }

    return requirements;
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final List<String> requirements =
        _selectedRequirements();

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F7FD),

      // ========================================================
      // APP BAR
      // ========================================================

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
          'Find Your Stay',
          style: TextStyle(
            fontSize: 18,
            fontWeight:
                FontWeight.bold,
            color:
                Color(0xFF19192E),
          ),
        ),

        actions: [
          TextButton(
            onPressed:
                _clearFilters,

            child: const Text(
              'Clear All',
              style: TextStyle(
                color:
                    Color(0xFF6252E8),
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(
            width: 5,
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: Column(
        children: [
          Expanded(
            child:
                SingleChildScrollView(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                25,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // ==================================================
                  // INTRO
                  // ==================================================

                  Container(
                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets.all(
                      17,
                    ),

                    decoration:
                        BoxDecoration(
                      gradient:
                          const LinearGradient(
                        begin:
                            Alignment.topLeft,
                        end:
                            Alignment.bottomRight,
                        colors: [
                          Color(0xFF6252E8),
                          Color(0xFF8B7CF6),
                        ],
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Row(
                      children: [
                        Container(
                          height: 48,
                          width: 48,

                          decoration:
                              BoxDecoration(
                            color: Colors
                                .white
                                .withOpacity(
                              0.18,
                            ),
                            shape:
                                BoxShape.circle,
                          ),

                          child:
                              const Icon(
                            Icons
                                .auto_awesome_rounded,
                            color:
                                Colors.white,
                            size: 25,
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              Text(
                                'Tell us what you need',
                                style:
                                    TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight
                                          .w700,
                                  color:
                                      Colors.white,
                                ),
                              ),

                              SizedBox(
                                height: 4,
                              ),

                              Text(
                                'We will find hostels that match your requirements.',
                                style:
                                    TextStyle(
                                  fontSize: 10,
                                  height: 1.4,
                                  color:
                                      Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // ==================================================
                  // LOCATION
                  // ==================================================

                  _sectionTitle(
                    'Where do you want to stay?',
                    Icons
                        .location_on_outlined,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  TextField(
                    controller:
                        locationController,

                    textInputAction:
                        TextInputAction.search,

                    decoration:
                        InputDecoration(
                      hintText:
                          'Example: Gachibowli',

                      prefixIcon:
                          const Icon(
                        Icons
                            .location_on_outlined,
                        color:
                            Color(
                          0xFF6252E8,
                        ),
                      ),

                      filled: true,

                      fillColor:
                          Colors.white,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),

                        borderSide:
                            BorderSide.none,
                      ),

                      enabledBorder:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),

                        borderSide:
                            const BorderSide(
                          color:
                              Color(
                            0xFFE5E3EF,
                          ),
                        ),
                      ),

                      focusedBorder:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),

                        borderSide:
                            const BorderSide(
                          color:
                              Color(
                            0xFF6252E8,
                          ),
                          width: 1.5,
                        ),
                      ),

                      contentPadding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 16,
                        horizontal: 14,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // ==================================================
                  // GENDER
                  // ==================================================

                  _sectionTitle(
                    'Who is the stay for?',
                    Icons
                        .person_outline_rounded,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _choiceRow(
                    options: const [
                      'Any',
                      'Female',
                      'Male',
                    ],

                    selected:
                        selectedGender,

                    onSelected:
                        (value) {
                      setState(() {
                        selectedGender =
                            value;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // ==================================================
                  // SHARING
                  // ==================================================

                  _sectionTitle(
                    'Preferred sharing',
                    Icons
                        .people_outline_rounded,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _choiceRow(
                    options: const [
                      'Any',
                      'Single',
                      '2 Sharing',
                      '3 Sharing',
                      '4 Sharing',
                    ],

                    selected:
                        selectedSharing,

                    onSelected:
                        (value) {
                      setState(() {
                        selectedSharing =
                            value;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // ==================================================
                  // BUDGET
                  // ==================================================

                  _sectionTitle(
                    'Maximum monthly budget',
                    Icons
                        .currency_rupee_rounded,
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Container(
                    padding:
                        const EdgeInsets
                            .all(
                      14,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        16,
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
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Budget',
                              style:
                                  TextStyle(
                                fontSize: 11,
                                color:
                                    Color(
                                  0xFF858696,
                                ),
                              ),
                            ),

                            const Spacer(),

                            Text(
                              '₹${maxBudget.toInt()} / month',

                              style:
                                  const TextStyle(
                                fontSize: 15,
                                fontWeight:
                                    FontWeight
                                        .w800,
                                color:
                                    Color(
                                  0xFF6252E8,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Slider(
                          value:
                              maxBudget,

                          min: 4000,

                          max: 20000,

                          divisions:
                              32,

                          activeColor:
                              const Color(
                            0xFF6252E8,
                          ),

                          inactiveColor:
                              const Color(
                            0xFFE2DFFF,
                          ),

                          onChanged:
                              (value) {
                            setState(() {
                              maxBudget =
                                  value;
                            });
                          },
                        ),

                        const Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [
                            Text(
                              '₹4,000',
                              style:
                                  TextStyle(
                                fontSize: 9,
                                color:
                                    Color(
                                  0xFF858696,
                                ),
                              ),
                            ),

                            Text(
                              '₹20,000',
                              style:
                                  TextStyle(
                                fontSize: 9,
                                color:
                                    Color(
                                  0xFF858696,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // ==================================================
                  // FACILITIES
                  // ==================================================

                  _sectionTitle(
                    'Must-have facilities',
                    Icons
                        .home_work_outlined,
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  const Text(
                    'Select facilities that are important to you.',
                    style: TextStyle(
                      fontSize: 10,
                      color:
                          Color(0xFF858696),
                    ),
                  ),

                  const SizedBox(
                    height: 11,
                  ),

                  _facilitySwitch(
                    icon:
                        Icons
                            .restaurant_rounded,

                    title:
                        'Food',

                    subtitle:
                        'Meals included',

                    value:
                        food,

                    onChanged:
                        (value) {
                      setState(() {
                        food = value;
                      });
                    },
                  ),

                  _facilitySwitch(
                    icon:
                        Icons
                            .wifi_rounded,

                    title:
                        'Wi-Fi',

                    subtitle:
                        'Internet available',

                    value:
                        wifi,

                    onChanged:
                        (value) {
                      setState(() {
                        wifi = value;
                      });
                    },
                  ),

                  _facilitySwitch(
                    icon:
                        Icons
                            .ac_unit_rounded,

                    title:
                        'AC',

                    subtitle:
                        'Air conditioning',

                    value:
                        ac,

                    onChanged:
                        (value) {
                      setState(() {
                        ac = value;
                      });
                    },
                  ),

                  _facilitySwitch(
                    icon:
                        Icons
                            .security_rounded,

                    title:
                        'Security',

                    subtitle:
                        'Safe & secure property',

                    value:
                        security,

                    onChanged:
                        (value) {
                      setState(() {
                        security = value;
                      });
                    },
                  ),

                  _facilitySwitch(
                    icon:
                        Icons
                            .local_parking_rounded,

                    title:
                        'Parking',

                    subtitle:
                        'Vehicle parking',

                    value:
                        parking,

                    onChanged:
                        (value) {
                      setState(() {
                        parking = value;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // ==================================================
                  // REQUIREMENT SUMMARY
                  // ==================================================

                  _sectionTitle(
                    'Your requirements',
                    Icons
                        .checklist_rounded,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets
                            .all(
                      14,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFFF0EEFF,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),

                      border:
                          Border.all(
                        color:
                            const Color(
                          0xFFE0DCFF,
                        ),
                      ),
                    ),

                    child:
                        Wrap(
                      spacing: 7,
                      runSpacing: 7,

                      children:
                          requirements
                              .map(
                        (item) {
                          return Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal:
                                  9,
                              vertical:
                                  7,
                            ),

                            decoration:
                                BoxDecoration(
                              color:
                                  Colors.white,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                9,
                              ),
                            ),

                            child:
                                Row(
                              mainAxisSize:
                                  MainAxisSize
                                      .min,

                              children: [
                                const Icon(
                                  Icons
                                      .check_circle_rounded,
                                  size: 13,
                                  color:
                                      Color(
                                    0xFF6252E8,
                                  ),
                                ),

                                const SizedBox(
                                  width: 4,
                                ),

                                Text(
                                  item,

                                  style:
                                      const TextStyle(
                                    fontSize:
                                        9,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                    color:
                                        Color(
                                      0xFF4F4D62,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  const Text(
                    'Our matching engine will compare these requirements with available hostels.',
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.4,
                      color:
                          Color(0xFF858696),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ========================================================
          // BOTTOM BUTTON
          // ========================================================

          SafeArea(
            child: Container(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                11,
                16,
                11,
              ),

              decoration:
                  const BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    color:
                        Color(0x12000000),
                    blurRadius: 12,
                    offset:
                        Offset(0, -3),
                  ),
                ],
              ),

              child:
                  SizedBox(
                width:
                    double.infinity,

                child:
                    ElevatedButton.icon(
                  onPressed:
                      _searchHostels,

                  icon:
                      const Icon(
                    Icons
                        .auto_awesome_rounded,
                    size: 19,
                  ),

                  label:
                      const Text(
                    'Find Matching Hostels',
                    style:
                        TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  style:
                      ElevatedButton
                          .styleFrom(
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
                      52,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color:
              const Color(0xFF6252E8),
        ),

        const SizedBox(
          width: 7,
        ),

        Text(
          title,

          style:
              const TextStyle(
            fontSize: 15,
            fontWeight:
                FontWeight.w700,
            color:
                Color(0xFF19192E),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CHOICE ROW
  // ============================================================

  Widget _choiceRow({
    required List<String> options,
    required String selected,
    required ValueChanged<String>
        onSelected,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,

      children:
          options.map(
        (option) {
          final bool isSelected =
              option == selected;

          return GestureDetector(
            onTap: () {
              onSelected(option);
            },

            child: AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 180,
              ),

              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 14,
                vertical: 10,
              ),

              decoration:
                  BoxDecoration(
                color: isSelected
                    ? const Color(
                        0xFF6252E8,
                      )
                    : Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  11,
                ),

                border:
                    Border.all(
                  color: isSelected
                      ? const Color(
                          0xFF6252E8,
                        )
                      : const Color(
                          0xFFE5E3EF,
                        ),
                ),
              ),

              child:
                  Text(
                option,

                style:
                    TextStyle(
                  fontSize: 10,

                  fontWeight:
                      FontWeight.w600,

                  color: isSelected
                      ? Colors.white
                      : const Color(
                          0xFF5F5D6D,
                        ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  // ============================================================
  // FACILITY SWITCH
  // ============================================================

  Widget _facilitySwitch({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>
        onChanged,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 9,
      ),

      padding:
          const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),

      decoration:
          BoxDecoration(
        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          14,
        ),

        border:
            Border.all(
          color:
              const Color(0xFFE5E3EF),
        ),
      ),

      child:
          Row(
        children: [
          Container(
            height: 38,
            width: 38,

            decoration:
                const BoxDecoration(
              color:
                  Color(0xFFEAE6FF),
              shape:
                  BoxShape.circle,
            ),

            child:
                Icon(
              icon,
              size: 19,
              color:
                  const Color(
                0xFF6252E8,
              ),
            ),
          ),

          const SizedBox(
            width: 11,
          ),

          Expanded(
            child:
                Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style:
                      const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        Color(
                      0xFF29293B,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

                Text(
                  subtitle,

                  style:
                      const TextStyle(
                    fontSize: 9,
                    color:
                        Color(
                      0xFF858696,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,

            activeColor:
                const Color(
              0xFF6252E8,
            ),

            onChanged:
                onChanged,
          ),
        ],
      ),
    );
  }
}

