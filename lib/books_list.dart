import 'package:flutter/material.dart';
import 'package:sembast_demo/dao/books_dao.dart';
import 'package:sembast_demo/model/books_model.dart';


class BooksList extends StatefulWidget {
  @override
  _BooksListState createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  BooksDao dau = BooksDao();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books List"),
      ),
      body: Container(

        child: FutureBuilder<List<Books>>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              print("asdff ${snapshot.data}");
              return Container(color: Colors.red);
            }
            return
              ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Books student = snapshot.data[index];
                  return  snapshot.data.length == null ?CircularProgressIndicator():
                  ListTile(
                    title: Text(student.name),
                    trailing: Text(student.rollNo.toString()),
                    onTap: (){
                     setState(() {
                       dau.delete(Books(rollNo: student.rollNo));
//                       snapshot.data.removeAt(index);

                     });
                    },

                  );
                });
          },
          future: dau.getAllBooks(),
        ),
      ),
    );
  }
}
