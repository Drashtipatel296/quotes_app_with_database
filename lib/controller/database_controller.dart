import 'package:get/get.dart';

import '../helper/api_helper.dart';
import '../helper/database_helper.dart';
import '../model/database_model.dart';

class QuotesController extends GetxController {
  var quotes = <Quote>[].obs;
  var filteredQuotes = <Quote>[].obs;
  var isLoading = true.obs;
  var selectedCategories = <String>[].obs;
  var currentIndex = 0.obs; // Add this line

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
  }

  void fetchQuotes() async {
    isLoading(true);

    var localQuotes = await DatabaseHelper.instance.fetchQuotes();
    if (localQuotes.isNotEmpty) {
      quotes.assignAll(localQuotes);
      quotes.shuffle(); // Shuffle the quotes
      filterQuotes();
      isLoading(false);
      return;
    }

    try {
      var apiQuotes = await QuoteApiHelper().fetchQuotes();
      if (apiQuotes.isNotEmpty) {
        for (var quote in apiQuotes) {
          await DatabaseHelper.instance.insertQuote(quote);
        }
        quotes.assignAll(apiQuotes);
        quotes.shuffle(); // Shuffle the quotes
      } else {
        quotes.assignAll([]);
      }
    } catch (e) {
      print('Error fetching quotes: $e');
      quotes.assignAll([]);
    }

    filterQuotes();
    isLoading(false);
  }

  void filterQuotes() {
    if (selectedCategories.isEmpty) {
      filteredQuotes.assignAll(quotes);
    } else {
      filteredQuotes.assignAll(
          quotes.where((quote) => selectedCategories.contains(quote.category)).toList());
    }
    filteredQuotes.shuffle(); // Shuffle the filtered quotes
  }

  void setSelectedCategories(List<String> categories) {
    selectedCategories.assignAll(categories);
    filterQuotes();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
