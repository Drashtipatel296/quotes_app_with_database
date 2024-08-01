import 'package:get/get.dart';
import '../helper/api_helper.dart';
import '../helper/database_helper.dart';
import '../model/database_model.dart';

class QuotesController extends GetxController {
  var quotes = <Quote>[].obs;
  var filteredQuotes = <Quote>[].obs;
  var likedQuotes = <Quote>[].obs;
  var likedQuotesByCategory = <String, List<Quote>>{}.obs;
  var isLoading = true.obs;
  var selectedCategories = <String>[].obs;
  var currentIndex = 0.obs;
  var selectedWallpaper = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
    fetchLikedQuotes();
  }

  void setSelectedWallpaper(String wallpaper) {
    selectedWallpaper.value = wallpaper;
  }

  void fetchQuotes() async {
    isLoading(true);
    var localQuotes = await DatabaseHelper.instance.fetchQuotes();
    if (localQuotes.isNotEmpty) {
      quotes.assignAll(localQuotes);
      quotes.shuffle();
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
        quotes.shuffle();
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
      filteredQuotes.assignAll(quotes.where((quote) => selectedCategories.contains(quote.category)).toList());
    }
    filteredQuotes.shuffle();
  }

  void setSelectedCategories(List<String> categories) {
    selectedCategories.assignAll(categories);
    filterQuotes();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void likeQuote(int quoteId) async {
    await DatabaseHelper.instance.likeQuote(quoteId);
    fetchLikedQuotes();
  }

  void unlikeQuote(int quoteId) async {
    await DatabaseHelper.instance.unlikeQuote(quoteId);
    fetchLikedQuotes();
  }

  void fetchLikedQuotes() async {
    var liked = await DatabaseHelper.instance.fetchLikedQuotes();
    likedQuotes.assignAll(liked);
    groupLikedQuotesByCategory();
  }

  void groupLikedQuotesByCategory() {
    Map<String, List<Quote>> groupedQuotes = {};
    for (var quote in likedQuotes) {
      if (groupedQuotes.containsKey(quote.category)) {
        groupedQuotes[quote.category]!.add(quote);
      } else {
        groupedQuotes[quote.category] = [quote];
      }
    }
    likedQuotesByCategory.assignAll(groupedQuotes);
  }
}
