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

  factory Book.fromJsonApi(Map<String, dynamic> json) {
    return Book(
        name: json['name'],
        sinopse: json['sinopse'],
        imageLinks: json['imageLink'],
        lauch_date: json['launch_date'],
        author: json['author']);
  }
}
