import 'package:book_store/model/book.dart';
import 'package:flutter/material.dart';

class SearchBook extends SearchDelegate {
  List<Book> allBook;
  SearchBook(this.allBook);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Book> searchBook = allBook
        .where((element) =>
            element.bookName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return searchBook.isEmpty
        ? const Center(child: Text('No data found'))
        : SafeArea(
            child: ListView.builder(
              itemCount: searchBook.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(searchBook[index].bookName[0].toUpperCase()),
                    ),
                    title: Text(searchBook[index].bookName),
                    subtitle: Text('\$ ${searchBook[index].price.toString()}'),
                    trailing: Text(searchBook[index].authorName),
                  ),
                );
              },
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Book> searchBook = allBook
        .where((element) =>
            element.bookName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return searchBook.isEmpty
        ? const Center(child: Text('No Suggestion data found'))
        : SafeArea(
            child: ListView.builder(
              itemCount: searchBook.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(searchBook[index].bookName[0].toUpperCase()),
                    ),
                    title: Text(searchBook[index].bookName),
                    subtitle: Text('\$ ${searchBook[index].price.toString()}'),
                    trailing: Text(searchBook[index].authorName),
                  ),
                );
              },
            ),
          );
  }
}
