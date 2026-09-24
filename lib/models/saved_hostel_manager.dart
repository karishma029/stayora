
import 'package:flutter/foundation.dart';

class SavedHostelManager {
  // ==============================================================
  // STORES ALL SAVED HOSTELS
  // ==============================================================

  static final ValueNotifier<List<Map<String, dynamic>>> savedHostels =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // ==============================================================
  // ADD HOSTEL
  // ==============================================================

  static void addHostel(
    Map<String, dynamic> hostel,
  ) {
    final alreadySaved = savedHostels.value.any(
      (item) =>
          item['name'].toString() ==
          hostel['name'].toString(),
    );

    // Avoid duplicate hostels
    if (!alreadySaved) {
      savedHostels.value = [
        ...savedHostels.value,
        Map<String, dynamic>.from(hostel),
      ];
    }
  }

  // ==============================================================
  // REMOVE HOSTEL
  // ==============================================================

  static void removeHostel(
    String hostelName,
  ) {
    savedHostels.value = savedHostels.value
        .where(
          (item) =>
              item['name'].toString() !=
              hostelName,
        )
        .toList();
  }

  // ==============================================================
  // CHECK IF HOSTEL IS SAVED
  // ==============================================================

  static bool isSaved(
    String hostelName,
  ) {
    return savedHostels.value.any(
      (item) =>
          item['name'].toString() ==
          hostelName,
    );
  }

  // ==============================================================
  // ADD / REMOVE HOSTEL
  // ==============================================================

  static void toggleHostel(
    Map<String, dynamic> hostel,
  ) {
    final hostelName =
        hostel['name'].toString();

    if (isSaved(hostelName)) {
      removeHostel(hostelName);
    } else {
      addHostel(hostel);
    }
  }

  // ==============================================================
  // CLEAR ALL
  // ==============================================================

  static void clearAll() {
    savedHostels.value = [];
  }
}

