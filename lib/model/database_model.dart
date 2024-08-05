  class QuoteModel {
    String quote;
    String author;
    String category;
    bool liked;

    QuoteModel({
      required this.quote,
      required this.author,
      required this.category,
      required this.liked,
    });

    factory QuoteModel.fromMap(Map<String, dynamic> json) {
      return QuoteModel(
        quote: json['quote'] ?? '',
        author: json['author'] ?? '',
        category: json['category'] ?? '',
        liked: json['like'] ?? false,
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'quote': quote,
        'author': author,
        'category': category,
        'liked': liked ? 1 : 0,
      };
    }
  }