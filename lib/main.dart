import 'package:book_store/database_helper/database_helper.dart';
import 'package:book_store/model/book.dart';
import 'package:book_store/screen/add_book.dart';
import 'package:book_store/utility/search_book.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Book Store'),
        actions: [
          IconButton(
            onPressed: () async {
              List<Book> allBook = await helper.getAllBook();
              showSearch(context: context, delegate: SearchBook(allBook));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddBook(null),
            ),
          );
          setState(() {});
        },
        icon: Icon(
          Icons.add_circle,
          size: 60,
          color: Colors.orange.shade800,
        ),
      ),
      body: Container(
        color: Colors.pink.withOpacity(0.25),
        child: Center(
          child: FutureBuilder(
            future: helper.getAllBook(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.amber[50],
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.amber,
                              child: Text(
                                snapshot.data![index].bookName[0].toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w900),
                              ),
                            ),
                            title: Text(
                              snapshot.data![index].bookName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                                '\$ ${snapshot.data![index].price.toString()}'),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon:
                                        const Icon(Icons.edit_square, size: 30),
                                    onPressed: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddBook(snapshot.data![index]),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await helper
                                          .deleteBook(snapshot.data![index].id);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete, size: 30),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
