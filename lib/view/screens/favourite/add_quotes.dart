import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/database_controller.dart';
import '../../../model/database_model.dart';
import '../../../helper/database_helper.dart';

class ShowQuotesScreen extends StatelessWidget {
  final String category;
  final List<QuoteModel> quotes;

  const ShowQuotesScreen({
    required this.category,
    required this.quotes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController quotesController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: quotes.map((quote) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(
                quote.quote,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              subtitle: Text(
                '- ${quote.author}',
                style: GoogleFonts.poppins(fontStyle: FontStyle.italic),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  DatabaseHelper().deleteLikedQuote(quote);
                  quotesController.likedQuotesList.remove(quote);
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

}
