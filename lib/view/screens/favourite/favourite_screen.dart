import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/database_controller.dart';
import '../../../model/database_model.dart';
import '../../../utils/likeimage_list.dart';
import 'add_quotes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorites',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18),),
      ),
      body: Obx(() {
        if (homeController.likedQuotesList.isEmpty) {
          return Center(
            child: Text('No favorite quotes found.',style: GoogleFonts.poppins(),),
          );
        }

        Map<String, List<QuoteModel>> categorizedQuotes = {};
        for (var quote in homeController.likedQuotesList) {
          if (!categorizedQuotes.containsKey(quote.category)) {
            categorizedQuotes[quote.category] = [];
          }
          categorizedQuotes[quote.category]!.add(quote);
        }

        Map<String, String> categoryImages = {
          for (var item in likeImgList) item['name']!: item['img']!,
        };

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1/0.8,
          ),
          itemCount: categorizedQuotes.keys.length,
          itemBuilder: (context, index) {
            String category = categorizedQuotes.keys.elementAt(index);
            List<QuoteModel> quotes = categorizedQuotes[category]!;
            String imagePath = categoryImages[category] ?? 'assets/default_image.png';

            return GestureDetector(
              onTap: () {
                Get.to(ShowQuotesScreen(category: category, quotes: quotes));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstIn),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(category,style: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            );
          },
        );
      }),
    );
  }
}
