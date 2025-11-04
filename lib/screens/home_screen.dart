import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/data_controller.dart';

class HomeScreen extends StatelessWidget {
  final DataController controller = Get.put(DataController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final user = controller.user;
          final actions = controller.actions;
          final specialities = controller.specialities;
          final specialists = controller.specialists;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(user['profile_image'] ?? ''),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'] ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              user['location'] ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.notifications_none, size: 26),
                  ],
                ),

                const SizedBox(height: 20),

                /// Search bar
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Icon(Icons.tune, color: Colors.grey),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// Specialities list
                Text(
                  "Specialities most relevant to you",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),

                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: specialities.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final s = specialities[index];
                      final name = s['name'].toString().toLowerCase();

                      return GestureDetector(
                        onTap: () {
                          debugPrint("👆 tapped on $name");
                          if (name.contains("cardio")) {
                            // Navigare sigură cu try-catch
                            try {
                              Get.toNamed('/doctor');
                            } catch (e) {
                              debugPrint("⚠️ Navigation error: $e");
                            }
                          } else {
                            if (!Get.isSnackbarOpen) {
                              Get.snackbar(
                                "Coming soon",
                                "Details for ${s['name']} will be added soon!",
                                backgroundColor: Colors.teal.shade50,
                                colorText: Colors.teal.shade900,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          }
                        },
                        child: Container(
                          width: 75,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(s['icon'], height: 32),
                              const SizedBox(height: 6),
                              Text(
                                s['name'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontSize: 8),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
