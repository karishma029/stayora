
import '../models/hostel_model.dart';

class MatchingService {
  static List<Map<String, dynamic>> findMatches({
    required List<HostelModel> hostels,
    required String location,
    required String gender,
    required String sharing,
    required int maxBudget,
    required bool food,
    required bool wifi,
    required bool ac,
    required bool security,
    required bool parking,
    bool laundry = false,
  }) {
    final List<Map<String, dynamic>> results = [];

    final String searchedLocation =
        location.trim().toLowerCase();

    for (final hostel in hostels) {
      int totalScore = 0;

      // Location - 20 points
      final bool locationMatches =
          searchedLocation.isEmpty ||
          hostel.location.toLowerCase().contains(
                searchedLocation,
              ) ||
          hostel.city.toLowerCase().contains(
                searchedLocation,
              );

      if (locationMatches) {
        totalScore += 20;
      }

      // Gender - 10 points
      final bool genderMatches =
          gender == 'Any' ||
          hostel.gender == gender ||
          hostel.gender == 'Any';

      if (genderMatches) {
        totalScore += 10;
      }

      // Sharing - 15 points
      final bool sharingMatches =
          sharing == 'Any' ||
          hostel.sharing == sharing;

      if (sharingMatches) {
        totalScore += 15;
      }

      // Budget - 20 points
      if (hostel.price <= maxBudget) {
        totalScore += 20;
      } else if (hostel.price <= maxBudget + 1000) {
        totalScore += 10;
      }

      // Food - 5 points
      if (!food || hostel.food) {
        totalScore += 5;
      }

      // Wi-Fi - 5 points
      if (!wifi || hostel.wifi) {
        totalScore += 5;
      }

      // AC - 5 points
      if (!ac || hostel.ac) {
        totalScore += 5;
      }

      // Security - 5 points
      if (!security || hostel.security) {
        totalScore += 5;
      }

      // Parking - 5 points
      if (!parking || hostel.parking) {
        totalScore += 5;
      }

      // Laundry - 5 points
      if (!laundry || hostel.laundry) {
        totalScore += 5;
      }

      // Maximum score
      int totalPossibleScore = 100;

      if (!laundry) {
        totalPossibleScore -= 5;
      }

      // Convert score to percentage
      final int matchPercentage =
          ((totalScore / totalPossibleScore) * 100).round();

      // Only show hostels from selected location
      if (locationMatches) {
        results.add({
          'hostel': hostel,
          'match': matchPercentage,
        });
      }
    }

    // Highest match first
    results.sort(
      (a, b) {
        final int matchA =
            (a['match'] as num).toInt();

        final int matchB =
            (b['match'] as num).toInt();

        if (matchA != matchB) {
          return matchB.compareTo(matchA);
        }

        final HostelModel hostelA =
            a['hostel'] as HostelModel;

        final HostelModel hostelB =
            b['hostel'] as HostelModel;

        return hostelB.rating.compareTo(
          hostelA.rating,
        );
      },
    );

    return results;
  }
}

