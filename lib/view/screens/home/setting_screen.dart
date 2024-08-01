import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/theme_controller.dart';
import '../favourite/favourite_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff3B4AB1),
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 18),
                Text('General', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 20)),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Setup Questions', style: GoogleFonts.poppins(fontSize: 20)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Color(0xff3B4AB1), size: 19),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Notifications', style: GoogleFonts.poppins(fontSize: 20)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Color(0xff3B4AB1), size: 19),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                Text('Your Affirmation', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 18)),
                SizedBox(height: 5),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('My Collection', style: GoogleFonts.poppins(fontSize: 20)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Color(0xff3B4AB1), size: 19),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.to(const LikedQuotesScreen());
                  },
                  child: Row(
                    children: [
                      Text('My Favorites', style: GoogleFonts.poppins(fontSize: 20)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff3B4AB1), size: 19),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    themeController.toggleTheme();
                  },
                  child: Row(
                    children: [
                      Text('Change Theme', style: GoogleFonts.poppins(fontSize: 20)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff3B4AB1), size: 19),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Past Quotes & Affirmation', style: GoogleFonts.poppins(fontSize: 20)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Color(0xff3B4AB1), size: 19),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey),
              ],
            ),
            SizedBox(height: 40),
            Text('Clear lesson data to redo lessons', style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xff3B4AB1), fontWeight: FontWeight.w500)),
            SizedBox(height: 15),
            Text('Contact Support', style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xff3B4AB1), fontWeight: FontWeight.w500)),
            SizedBox(height: 15),
            Text('Submit Logs to Support', style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xff3B4AB1), fontWeight: FontWeight.w500)),
            SizedBox(height: 15),
            Text('v1.0.17', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
