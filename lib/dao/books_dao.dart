import 'package:sembast/sembast.dart';
import 'package:sembast_demo/db/data_base.dart';
import 'package:sembast_demo/model/books_model.dart';



class BooksDao{
  static const String folderName = "Books";
  final _booksFolder = intMapStoreFactory.store(folderName);


  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future insertBooks(Books books) async{

    await  _booksFolder.add(await _db, books.toJson() );

  }

  Future updateBooks(Books books) async{
    final finder = Finder(filter: Filter.byKey(books.rollNo));
    await _booksFolder.update(await _db, books.toJson(),finder: finder);

  }


  Future delete(Books books) async{
    final finder = Finder(filter: Filter.byKey(books.rollNo));
    await _booksFolder.delete(await _db, finder: finder);
  }

  Future<List<Books>> getAllBooks()async{
    final recordSnapshot = await _booksFolder.find(await _db);
    return recordSnapshot.map((snapshot){
      final books = Books.fromJson(snapshot.value);
      return books;
    }).toList();
  }


}