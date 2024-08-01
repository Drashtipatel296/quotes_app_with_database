import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/database_controller.dart';
import '../../../utils/likeimage_list.dart';
import 'add_quotes.dart';

class LikedQuotesScreen extends StatelessWidget {
  const LikedQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuotesController quotesController = Get.put(QuotesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liked Quotes',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (quotesController.likedQuotes.isEmpty) {
          return Center(
            child: Text(
              'No liked quotes available',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1/0.9,
            ),
            itemCount: likeImgList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(CategoryQuotesScreen(category: likeImgList[index]['name']));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(likeImgList[index]['img']),
                          colorFilter: ColorFilter.mode(
                            Colors.grey.withOpacity(0.8),
                            BlendMode.dstIn,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        likeImgList[index]['name'],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

