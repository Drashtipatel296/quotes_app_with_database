import 'package:flutter/material.dart';
import '../../../model/database_model.dart';

class ShowQuotesScreen extends StatelessWidget {
  final String category;
  final List<Quote> quotes;

  const ShowQuotesScreen({
    required this.category,
    required this.quotes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: quotes.map((quote) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(quote.quote),
              subtitle: Text('- ${quote.author}'),
            ),
          );
        }).toList(),
      ),
    );
  }
}