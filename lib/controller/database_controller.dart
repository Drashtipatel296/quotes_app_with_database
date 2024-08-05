import 'dart:math';
import 'package:get/get.dart';
import 'package:quotes_app_with_database/helper/database_helper.dart';
import '../helper/api_helper.dart';
import '../model/database_model.dart';

class HomeController extends GetxController {
  var quotesList = <QuoteModel>[].obs;
  var likedQuotesList = <QuoteModel>[].obs;
  var categoryQuotesList = <QuoteModel>[].obs;
  var isLoading = true.obs;
  var selectedImage = ''.obs;
  var currentCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getQuotes();
    fetchLikedQuotes();
  }

  void selectImage(String imagePath) {
    selectedImage.value = imagePath;
  }

  void updateCurrentCategory(String category) {
    currentCategory.value = category;
  }

  Future<void> getQuotes() async {
    isLoading(true);
    try {
      List<dynamic>? jsonData = await ApiServices().apiCalling();
      if (jsonData != null) {
        var fetchedQuotes = jsonData.map((data) => QuoteModel.fromMap(data)).toList();
        fetchedQuotes.shuffle(Random());
        quotesList.value = fetchedQuotes;
        if (quotesList.isNotEmpty) {
          currentCategory.value = quotesList.first.category;
        }
        print('--- Fetched Data ---');
      } else {
        print('--- Null Data ---');
      }
    } catch (e) {
      print('Error fetching quotes: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> favQuote(int index) async {
    var quote = quotesList[index];
    bool isLike  = quote.liked;
    quote.liked = !isLike;
    quotesList[index] = quote;

    if (quote.liked) {
      if (!likedQuotesList.contains(quote)) {
        likedQuotesList.add(quote);
        print("{likedQuotesList.length}");
      }
      await DatabaseHelper().insertQuote(quote);
    } else {
      if (likedQuotesList.contains(quote)) {
        likedQuotesList.remove(quote);
        print("${likedQuotesList.length}");
      }
      await DatabaseHelper().deleteLikedQuote(quote);
    }
  }

  Future<void> fetchLikedQuotes() async {
    try {
      likedQuotesList.value = await DatabaseHelper().getLikedQuotes();
      print('Liked Quotes: ${likedQuotesList}');
    } catch (e) {
      print('Error fetching liked quotes: $e');
    }
  }
}
