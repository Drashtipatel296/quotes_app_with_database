// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controller/database_controller.dart';
// import '../../../model/database_model.dart';
// import 'add_quotes.dart';
//
// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController homeController = Get.put(HomeController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Favorites'),
//       ),
//       body: Obx(() {
//         if (homeController.likedQuotesList.isEmpty) {
//           return Center(
//             child: Text('No favorite quotes found.'),
//           );
//         }
//
//         Map<String, List<Quote>> categorizedQuotes = {};
//         for (var quote in homeController.likedQuotesList) {
//           if (!categorizedQuotes.containsKey(quote.category)) {
//             categorizedQuotes[quote.category] = [];
//           }
//           categorizedQuotes[quote.category]!.add(quote);
//         }
//
//         return GridView.builder(
//           padding: EdgeInsets.all(10),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             childAspectRatio: 1.5,
//           ),
//           itemCount: categorizedQuotes.keys.length,
//           itemBuilder: (context, index) {
//             String category = categorizedQuotes.keys.elementAt(index);
//             List<Quote> quotes = categorizedQuotes[category]!;
//             return GestureDetector(
//               onTap: () {
//                 Get.to(CategoryDetailScreen(category: category, quotes: quotes));
//               },
//               child: Card(
//                 color: Colors.green.shade100,
//                 elevation: 4,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         category,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

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
        title: Text('Your Favorites'),
      ),
      body: Obx(() {
        if (homeController.likedQuotesList.isEmpty) {
          return Center(
            child: Text('No favorite quotes found.'),
          );
        }

        // Create a map to categorize quotes
        Map<String, List<Quote>> categorizedQuotes = {};
        for (var quote in homeController.likedQuotesList) {
          if (!categorizedQuotes.containsKey(quote.category)) {
            categorizedQuotes[quote.category] = [];
          }
          categorizedQuotes[quote.category]!.add(quote);
        }

        // Create a map to quickly lookup image for each category
        Map<String, String> categoryImages = {
          for (var item in likeImgList) item['name']!: item['img']!,
        };

        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1/0.8,
          ),
          itemCount: categorizedQuotes.keys.length,
          itemBuilder: (context, index) {
            String category = categorizedQuotes.keys.elementAt(index);
            List<Quote> quotes = categorizedQuotes[category]!;
            String imagePath = categoryImages[category] ?? 'assets/default_image.png';

            return GestureDetector(
              onTap: () {
                Get.to(ShowQuotesScreen(category: category, quotes: quotes));
              },
              child: Container(
                decoration: BoxDecoration(
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
