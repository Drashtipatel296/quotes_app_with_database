import 'dart:math';
import 'package:get/get.dart';
import 'package:quotes_app_with_database/helper/database_helper.dart';
import '../helper/api_helper.dart';
import '../model/database_model.dart';

class HomeController extends GetxController {
  var quotesList = <Quote>[].obs;
  var likedQuotesList = <Quote>[].obs;
  var categoryQuotesList = <Quote>[].obs;
  var isLoading = true.obs;
  var selectedImage = ''.obs;
  var currentCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
    fetchLikedQuotes();
  }

  void selectImage(String imagePath) {
    selectedImage.value = imagePath;
  }

  void updateCurrentCategory(String category) {
    currentCategory.value = category;
  }

  Future<void> fetchQuotes() async {
    isLoading(true);
    List<dynamic>? jsonData = await ApiServices().apiCalling();
    if (jsonData != null) {
      var fetchedQuotes = jsonData.map((data) => Quote.fromMap(data)).toList();
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

  void likeQuote(int index) {
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
    likedQuotesList.value = await DBHelper().getLikedQuotes();
  }

}
