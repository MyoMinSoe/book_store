import 'package:book_store/database_helper/database_helper.dart';
import 'package:book_store/model/book.dart';
import 'package:flutter/material.dart';

class AddBook extends StatelessWidget {
  AddBook({super.key});
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> addBook() async {
    Book book = Book(
      bookNameController.text,
      authorNameController.text,
      int.parse(priceController.text),
    );
    int result = await databaseHelper.insertBook(book);
    if (result > 0) {
      print('SUCCESS ADDING BOOK');
    } else {
      print('FAIL ADDING BOOK');
    }
  } //****************** Adding Book **************************/

  Future<void> editBook(int id) async {
    Book book = Book.withID(
      id,
      bookNameController.text,
      authorNameController.text,
      int.parse(priceController.text),
    );
    int result = await databaseHelper.updateBook(book, id);
    if (result > 0) {
      print('SUCCESS UPDATE BOOK');
    } else {
      print('FAIL UPDATE BOOK');
    }
  } //******************** Update Book *************************/

  getBookInfo(int id) async {
    List<Book> book = [];
    book.addAll(await databaseHelper.getBook(id));
    bookNameController.text = book.first.bookName;
    authorNameController.text = book.first.authorName;
    priceController.text = book.first.price.toString();
  } // *************** fill data to textfield *******************/

  @override
  Widget build(BuildContext context) {
    String? bookIdRoute = ModalRoute.of(context)?.settings.arguments as String?;
    int? bookID = bookIdRoute == null ? null : int.parse(bookIdRoute);
    if (bookID != null) {
      getBookInfo(bookID);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Add New Book'),
      ),
      body: Container(
        color: Colors.pink.withOpacity(0.25),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Column(
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      decoration: const InputDecoration(
                        label: Text('Book Name'),
                      ),
                      controller: bookNameController,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      decoration: const InputDecoration(
                        label: Text('Author Name'),
                        prefixText: 'Mr./Ms.',
                      ),
                      controller: authorNameController,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      decoration: const InputDecoration(
                        label: Text('Price'),
                        prefixText: '\$ ',
                      ),
                      controller: priceController,
                      keyboardType: TextInputType.number,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  bookID == null ? await addBook() : await editBook(bookID);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: const BeveledRectangleBorder(),
                ),
                child: Text(
                  bookID == null ? 'Save' : 'Update',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
