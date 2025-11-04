import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/doctor_details_controller.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  final DoctorDetailsController controller = Get.put(DoctorDetailsController());

  @override
  void dispose() {
    // 🔥 Curățăm controllerul complet când ieșim
    if (Get.isRegistered<DoctorDetailsController>()) {
      Get.delete<DoctorDetailsController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cardiologist"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.doctor.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final doctor = controller.doctor;
        final appointment = controller.appointment;
        final timing = controller.timing;
        final locations = controller.locations;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Doctor Header ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      doctor['profile_image'] ?? 'https://via.placeholder.com/150',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor['name'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          doctor['speciality'] ?? '',
                          style: GoogleFonts.poppins(
                            color: Colors.teal,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange.shade400, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              "${doctor['rating'] ?? 0.0} (${doctor['reviews']} reviews)",
                              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// --- Appointment Section ---
              Text(
                "In-Clinic Appointment",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['hospital'] ?? '',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment['address'] ?? '',
                      style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Wait time: ${appointment['wait_time'] ?? 'N/A'}",
                      style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Divider(color: Colors.grey.shade300),
                    const SizedBox(height: 8),

                    /// Slots
                    Text(
                      "Available Slots",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        appointment['slots']?.length ?? 0,
                            (index) {
                          final slot = appointment['slots'][index];
                          final isSelected = slot['selected'] ?? false;

                          return GestureDetector(
                            onTap: () {
                              for (var s in appointment['slots']) {
                                s['selected'] = false;
                              }
                              slot['selected'] = true;
                              controller.appointment.refresh();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.teal : Colors.white,
                                border: Border.all(
                                  color: isSelected ? Colors.teal : Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                slot['time'],
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: isSelected ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// --- Timing Section ---
              Text(
                "Timing",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: timing.map((t) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t['day'] ?? '',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          t['time'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),

              /// --- Location Section ---
              Text(
                "Location",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: locations.map((loc) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc['area'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          loc['hospital'] ?? '',
                          style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                        ),
                        Text(
                          loc['full_address'] ?? '',
                          style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),

              /// --- Book Appointment Button ---
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      if (!Get.isSnackbarOpen) {
                        Get.snackbar(
                          "Appointment Confirmed ✅",
                          "You successfully booked with ${doctor['name']}",
                          backgroundColor: Colors.teal,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );
                      }

                      // Delay mic pentru feedback
                      await Future.delayed(const Duration(seconds: 2));

                      if (Get.isSnackbarOpen) Get.closeAllSnackbars();
                      if (Get.currentRoute == '/doctor') Get.back();
                    } catch (e) {
                      debugPrint("⚠️ Navigation error: $e");
                    }
                  },
                  child: Text(
                    "Book Appointment",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
