class Quote {
  final int? id;
  final String quote;
  final String author;
  final String category;
  bool like;

  Quote({
    this.id,
    required this.quote,
    required this.author,
    required this.category,
    required this.like,
  });

  factory Quote.fromMap(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
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