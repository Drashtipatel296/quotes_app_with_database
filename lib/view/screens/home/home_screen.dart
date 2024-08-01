import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app_with_database/view/screens/home/setting_screen.dart';
import 'package:quotes_app_with_database/view/screens/home/wallpaper_screen.dart';
import 'package:share_extend/share_extend.dart';
import '../../../controller/database_controller.dart';
import 'category_screen.dart';
class HomeScreen extends StatelessWidget {
  final List<String> selectedCategories;

  const HomeScreen({super.key, required this.selectedCategories});

  @override
  Widget build(BuildContext context) {
    final QuotesController quotesController = Get.put(QuotesController());

    return Scaffold(
      body: Obx(() {
        if (quotesController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (quotesController.quotes.isEmpty) {
          return Center(
            child: Text(
              'No quotes available',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return Stack(
          children: [
            Obx(() => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(quotesController.selectedWallpaper.value.isEmpty
                      ? 'assets/bg-img/img26.jpg'
                      : quotesController.selectedWallpaper.value),
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
                              quotesController.filteredQuotes[quotesController.currentIndex.value].category,
                              style: TextStyle(
                                fontSize: 21,
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
                            Get.to(const WallpaperScreen(), transition: Transition.fadeIn);
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
                    itemCount: quotesController.filteredQuotes.length,
                    onPageChanged: (index) {
                      quotesController.setCurrentIndex(index);
                    },
                    itemBuilder: (context, index) {
                      var quote = quotesController.filteredQuotes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            quote.quote,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 35.0,
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
                                var currentQuote = quotesController.filteredQuotes[quotesController.currentIndex.value].quote;
                                ShareExtend.share(currentQuote, "text");
                              },
                              color: Colors.white,
                            ),
                            Text(
                              'Share',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
                            IconButton(
                              icon: Obx(() => Icon(
                                quotesController.likedQuotes.any((q) => q.id == quotesController.filteredQuotes[quotesController.currentIndex.value].id)
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_alt_outlined,
                                color: Colors.white,
                              )),
                              onPressed: () {
                                var quoteId = quotesController.filteredQuotes[quotesController.currentIndex.value].id;
                                if (quotesController.likedQuotes.any((q) => q.id == quoteId)) {
                                  quotesController.unlikeQuote(quoteId!);
                                } else {
                                  quotesController.likeQuote(quoteId!);
                                }
                              },
                              color: Colors.white,
                            ),
                            Text(
                              'Like',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
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
                              onPressed: () {},
                              color: Colors.white,
                            ),
                            Text(
                              'Dislike',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
