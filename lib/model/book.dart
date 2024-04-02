class Book {
  int? id;
  String bookName;
  String authorName;
  int price;
  Book(this.bookName, this.authorName, this.price);
  Book.withID(this.id, this.bookName, this.authorName, this.price);

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book.withID(
      map['id'],
      map['bookName'],
      map['authorName'],
      map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookName': bookName,
      'authorName': authorName,
      'price': price,
    };
  }
}
