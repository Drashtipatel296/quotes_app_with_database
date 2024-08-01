import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/database_controller.dart';

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
              return Stack(
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
              );
            },
          ),
        );
      }),
    );
  }
}

List likeImgList = [
  {
    'img': 'assets/like-img/love.jpg',
    'name': 'Love',
  },
  {
    'img': 'assets/bg-img/img1.jpg',
    'name': 'Affirmation',
  },
  {
    'img': 'assets/bg-img/img8.jpg',
    'name': 'Motivation',
  },
  {
    'img': 'assets/like-img/positive.jpg',
    'name': 'Positivity',
  },
  {
    'img': 'assets/like-img/health.jpg',
    'name': 'Mental Health',
  },
  {
    'img': 'assets/like-img/dis.webp',
    'name': 'Discipline',
  },
  {
    'img': 'assets/like-img/broken.webp',
    'name': 'Broken',
  },
  {
    'img': 'assets/like-img/self.webp',
    'name': 'Self Esteem',
  },
  {
    'img': 'assets/like-img/success.webp',
    'name': 'Success',
  },
  {
    'img': 'assets/like-img/frd.jpeg',
    'name': 'Friendship',
  },
  {
    'img': 'assets/like-img/loyalty.jpg',
    'name': 'Loyalty',
  },
  {
    'img': 'assets/like-img/kind.jpeg',
    'name': 'Kindness',
  },
  {
    'img': 'assets/like-img/funny.jpg',
    'name': 'Funny',
  },
  {
    'img': 'assets/like-img/hp.jpg',
    'name': 'Happiness',
  },
  {
    'img': 'assets/like-img/sad.jpg',
    'name': 'Sad',
  },
  {
    'img': 'assets/like-img/ego.jpg',
    'name': 'Ego',
  },
];
