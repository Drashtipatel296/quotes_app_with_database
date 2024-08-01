import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/database_controller.dart';

class CategoryQuotesScreen extends StatelessWidget {
  final String category;

  const CategoryQuotesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final QuotesController quotesController = Get.put(QuotesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$category Quotes',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        var categoryQuotes = quotesController.likedQuotes.where((quote) => quote.category == category).toList();

        if (categoryQuotes.isEmpty) {
          return Center(
            child: Text(
              'No quotes available for $category',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: categoryQuotes.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryQuotes[index].quote,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '- ${categoryQuotes[index].author}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}