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
    isLoading(false);
  }

  void favQuote(int index) {
    var quote = quotesList[index];
    quote.like = !quote.like;
    quotesList[index] = quote;

    if (quote.like) {
      likedQuotesList.add(quote);
    } else {
      likedQuotesList.remove(quote);
    }
  }

  Future<void> fetchLikedQuotes() async {
    likedQuotesList.value = await DatabaseHelper().getLikedQuotes();
    for (var quote in likedQuotesList) {
      if (quote.id == null) {
        print('Error: Fetched quote with null ID');
      }
    }
  }
}

