import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app_with_database/controller/database_controller.dart';
import 'package:quotes_app_with_database/utils/wallpaper_list.dart';

class WallpaperScreen extends StatelessWidget {
  const WallpaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuotesController wallpaperController = Get.put(QuotesController());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Themes',
              style: GoogleFonts.poppins(
                color: const Color(0xff3B4AB1),
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1 / 1.5,
                ),
                itemCount: imgList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      wallpaperController.setSelectedWallpaper(imgList[index]);
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(imgList[index]),
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
    );
  }
}
