import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DoctorDetailsController extends GetxController {
  /// Date reactive observabile
  final RxMap<String, dynamic> doctor = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> appointment = <String, dynamic>{}.obs;
  final RxList<Map<String, dynamic>> timing = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> locations = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDoctorDetails();
  }

  /// Încarcă datele din fișierul JSON local
  Future<void> loadDoctorDetails() async {
    try {
      final String response = await rootBundle.loadString('assets/images/v5.json');
      final data = json.decode(response);

      // Extragem doar doctorul cardiolog (poți adapta dacă ai mai mulți)
      final Map<String, dynamic> cardiologist = data['specialists']
          .firstWhere((d) => d['speciality'].toString().toLowerCase().contains('cardio'));

      // Setăm doctorul
      doctor.assignAll(cardiologist);

      // Setăm informațiile pentru appointment
      appointment.assignAll({
        "hospital": cardiologist['appointment']['hospital'] ?? "Not specified",
        "address": cardiologist['appointment']['address'] ?? "N/A",
        "wait_time": cardiologist['appointment']['wait_time'] ?? "N/A",
        "slots": (cardiologist['appointment']['slots'] as List<dynamic>?)
            ?.map((s) => {"time": s, "selected": false})
            .toList() ??
            [],
      });

      // Setăm programul
      timing.assignAll(
        (cardiologist['timing'] as List<dynamic>?)
            ?.map((t) => {
          "day": t['day'],
          "time": t['time'],
        })
            .toList() ??
            [],
      );

      // Setăm locațiile (cu full_address)
      locations.assignAll(
        (cardiologist['locations'] as List<dynamic>?)
            ?.map((l) => {
          "area": l['area'],
          "hospital": l['hospital'],
          "full_address": l['full_address'],
        })
            .toList() ??
            [],
      );
    } catch (e) {
      Get.snackbar(
        "Error loading data",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFE0E0),
        colorText: const Color(0xFFB00020),
      );
    }
  }
}
