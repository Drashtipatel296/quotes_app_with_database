  class QuoteModel {
    final int? id;
    final String quote;
    final String author;
    final String category;
    bool like;

    QuoteModel({
      this.id,
      required this.quote,
      required this.author,
      required this.category,
      required this.like,
    });

    factory QuoteModel.fromMap(Map<String, dynamic> json) {
      return QuoteModel(
        id: json['id'] as int?,
        quote: json['quote'] ?? '',
        author: json['author'] ?? '',
        category: json['category'] ?? '',
        like: json['liked'] ?? false,
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'quote': quote,
        'author': author,
        'category': category,
        'liked': like ? 1 : 0,
      };
    }
  }