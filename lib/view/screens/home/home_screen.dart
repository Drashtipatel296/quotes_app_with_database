import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app_with_database/view/screens/home/setting_screen.dart';
import 'package:quotes_app_with_database/view/screens/home/wallpaper_screen.dart';
import 'package:share_extend/share_extend.dart';
import '../../../controller/database_controller.dart';
import '../../../helper/database_helper.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> selectedCategories;

  const HomeScreen({super.key, required this.selectedCategories});

  @override
  Widget build(BuildContext context) {
    final HomeController quotesController = Get.put(HomeController());

    return Scaffold(
      body: Obx(() {
        if (quotesController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Stack(
          children: [
            Obx(() => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          quotesController.selectedImage.value.isNotEmpty
                              ? quotesController.selectedImage.value
                              : 'assets/bg-img/img26.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 55.0, left: 16.0),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Get.to(() => CategorySelectionScreen());
                              },
                            ),
                            SizedBox(width: 8.0),
                            Obx(() => Text(
                                  quotesController.currentCategory.value,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.to(WallpaperScreen());
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.to(SettingScreen());
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: quotesController.quotesList.length,
                    onPageChanged: (index) {
                      var quote = quotesController.quotesList[index];
                      quotesController.updateCurrentCategory(quote.category);
                    },
                    itemBuilder: (context, index) {
                      var quote = quotesController.quotesList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            "\"${quote.quote}\"",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                  offset: Offset(1.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                final currentIndex =
                                    quotesController.quotesList.indexWhere(
                                  (quote) =>
                                      quote.category ==
                                      quotesController.currentCategory.value,
                                );
                                if (currentIndex != -1) {
                                  final currentQuote =
                                      quotesController.quotesList[currentIndex];
                                  final imagePath =
                                      quotesController.selectedImage.value;
                                  final content =
                                      "\"${currentQuote.quote}\"\n\nImage: $imagePath";
                                  ShareExtend.share(
                                    content,
                                    "text",
                                  );
                                }
                              },
                              color: Colors.white,
                            ),
                            Text(
                              'Share',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final currentIndex =
                                  quotesController.quotesList.indexWhere(
                                (quote) =>
                                    quote.category ==
                                    quotesController.currentCategory.value,
                              );
                              final quote =
                                  quotesController.quotesList[currentIndex];
                              final isLiked = quote.like;
                              return IconButton(
                                icon: Icon(
                                  isLiked
                                      ? Icons.thumb_up_alt
                                      : Icons.thumb_up_alt_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  quotesController.likeQuote(currentIndex);
                                  final updatedQuote =
                                      quotesController.quotesList[currentIndex];
                                  DBHelper().insertQuote(
                                      updatedQuote); // Or use an update method
                                },
                              );
                            }),
                            Text(
                              'Like',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_down_alt_outlined),
                              onPressed: () {
                                // Implement dislike functionality
                              },
                              color: Colors.white,
                            ),
                            Text(
                              'Dislike',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
