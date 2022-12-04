class Book {
  final String name;
  final sinopse;
  final imageLinks;
  final lauch_date;
  final author;

  const Book(
      {required this.name,
      required this.sinopse,
      required this.imageLinks,
      required this.lauch_date,
      required this.author});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        name: json['title'],
        sinopse: json['description'],
        imageLinks: json['imageLinks'],
        lauch_date: json['publishedDate'],
        author: json['authors']);
  }

  String get _getDescription {
    String msg = "Não há descrição";
    if (sinopse != null) {
      msg = sinopse;
    }
    return msg;
  }

  String _getAuthor() {
    String msg = '';
    if (author != null) {
      msg = author[0];
    }
    return msg;
  }
}
