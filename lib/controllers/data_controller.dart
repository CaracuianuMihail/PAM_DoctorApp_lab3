import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var isLoading = true.obs;

  var user = {}.obs;
  var actions = [].obs;
  var specialities = [].obs;
  var specialists = [].obs;
  var doctorDetails = {}.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final String response = await rootBundle.loadString('assets/v5.json');
      final data = json.decode(response);

      print("✅ JSON încărcat: ${data.keys}");

      // Verificăm dacă există "medicineFeed"
      if (data.containsKey('medicineFeed')) {
        final feed = data['medicineFeed'];
        user.value = feed['user'] ?? {};
        actions.value = (feed['actions'] ?? []).cast<Map<String, dynamic>>();
        specialities.value = (feed['specialities'] ?? []).cast<Map<String, dynamic>>();
        specialists.value = (feed['specialists'] ?? []).cast<Map<String, dynamic>>();
      } else {
        // fallback dacă structura e diferită
        user.value = data['user'] ?? {};
        actions.value = (data['actions'] ?? []).cast<Map<String, dynamic>>();
        specialities.value = (data['specialities'] ?? []).cast<Map<String, dynamic>>();
        specialists.value = (data['specialists'] ?? []).cast<Map<String, dynamic>>();
      }

      doctorDetails.value = data['doctorDetails'] ?? {};

      print("✅ Date încărcate cu succes!");
    } catch (e, stacktrace) {
      print('❌ Eroare la încărcarea datelor: $e');
      print(stacktrace);
    } finally {
      isLoading.value = false;
      print("✅ Finalizat loadData()");
    }
  }
}
