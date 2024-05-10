import 'package:book_store/database_helper/database_helper.dart';
import 'package:book_store/model/book.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  final Book? book;
  const AddBook(this.book, {super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final dbhelper = DatabaseHelper();

  final bookNameController = TextEditingController();
  final authorNameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      bookNameController.text = widget.book!.bookName;
      authorNameController.text = widget.book!.authorName;
      priceController.text = widget.book!.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.book == null
            ? const Text('Add Book')
            : const Text('Update Book'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: bookNameController,
                decoration: const InputDecoration(
                  label: Text('Book Name : '),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: authorNameController,
                decoration: const InputDecoration(
                  label: Text('Author Name : '),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  label: Text('Price : '),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.book == null) {
                  Book book = Book(
                      bookNameController.text,
                      authorNameController.text,
                      int.parse(priceController.text));
                  await dbhelper.insertBook(book);
                } else {
                  Book book = Book.withID(
                      widget.book!.id,
                      bookNameController.text,
                      authorNameController.text,
                      int.parse(priceController.text));
                  await dbhelper.updateBook(book, widget.book!.id);
                }
                setState(() {});
                Navigator.pop(context);
              },
              child: widget.book == null
                  ? const Text('Add')
                  : const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
