import 'package:fluttertest/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'User.db';
  final String tableDatabase = 'customer';
  int version = 1;
  final String userid = 'User_id';
  final String name = 'Name';
  final String lastname = 'Lastname';
  final String phone = 'Phone';
  final String username = 'Username';
  final String password = 'Password';
  final String file = 'File';

  SQLiteHelper() {
    initDatabase();
  }
  Future<Null> initDatabase() async {
    await openDatabase(
        join(
          await getDatabasesPath(),
          nameDatabase,
        ),
        onCreate: (db, version) => db.execute(
              'CREATE TABLE $tableDatabase ($userid INTEGER PRIMARY KEY, $name TEXT, $lastname TEXT, $phone TEXT, $username TEXT, $password TEXT, $file BLOB)',
            ),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<bool?> insertDataToSQLite(UserModel userModels) async {
    Database database = await connectedDatabase();
    try {
      database.insert(
        tableDatabase,
        userModels.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('เพิ่มข้อมูล \n ${userModels.name.toString()}');
      print('ชื่อรูปภาพ \n ${userModels.file.toString()}');
      return true;
    } catch (e) {
      print('$e insertData ==> ${e.toString()}');
    }
  }

  // Future<bool?> insertToSQLite(String name1, String lastname1, String phone1,
  //     String username1, String password1, String image) async {
  //   Database database = await connectedDatabase();
  //   try {
  //  //   database.rawInsert(
  //   //      'INSERT INTO $tableDatabase($name, $lastname, $phone, $username, $password) VALUES("$name1", "$lastname1", "$phone1", "$username1", "$password1", "$file1")');

  //     database.rawInsert(
  //         'INSERT INTO $tableDatabase (Name, Lastname, Phone, Username, Password, File) VALUES (?, ?, ?, ?, ?, ?)',
  //         ['$name1', '$lastname1', '$phone1', '$username1', '$password1', '$image']);
  //     print('insertData ==> ${image.toString()}');
  //     return true;
  //   } catch (e) {
  //     print('$e Error ==> ${e.toString()}');
  //   }
  // }

  // Future<Null> apdateAmountToSQLite(
  //   int userId,
  //   String name,
  //   String lastname,
  //   String phone,
  //   String password,
  // ) async {
  //   Database database = await connectedDatabase();
  //   try {
  //     database.rawUpdate(
  //         'UPDATE $tableDatabase SET User_id = ?, Name = ?, Lastname = ?, Phone = ?, Password = ? WHERE User_id = ?',
  //         ['$name', '$lastname', '$phone', '$password', '$userId']);
  //   } catch (e) {
  //     print('UPDATE Data ==> ${e.toString()}');
  //   }
  // }

  // Future<int?> getCount(int userId) async {
  //   //database connection
  //   Database database = await connectedDatabase();
  //   var x = await database.rawQuery(
  //       'SELECT COUNT(User_id) from $tableDatabase WHERE User_id = ? ',
  //       ['$userId']);
  //   int? count = Sqflite.firstIntValue(x);
  //   print('Ni count na $count');
  //   return count;
  // }

  Future<bool?> checkusername(String user) async {
    //database connection
    Database database = await connectedDatabase();
    var x = await database.rawQuery(
        'SELECT * from $tableDatabase WHERE $username = ? ', ['$user']);
    int? count = Sqflite.firstIntValue(x);
    // print('Ni count $count');
    if (count == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> checkusernameAndpassword(
      String username, String password) async {
    //database connection
    Database database = await connectedDatabase();
    var x = await database.rawQuery(
        'SELECT * from $tableDatabase WHERE Username = ? and Password = ? ',
        ['$username', '$password']);
    int? count = Sqflite.firstIntValue(x);
    // print('count ทั้งหมด = $count');
    if (count == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<UserModel>> readFromSQLite(
      String username, String password) async {
    Database database = await connectedDatabase();
    List<UserModel> userModels = [];
    var x = await database.rawQuery(
        'SELECT * from $tableDatabase WHERE Username = ? and Password = ? ',
        ['$username', '$password']);
    for (var map in x) {
      UserModel userModel = UserModel.fromJson(map);
      userModels.add(userModel);
    }
    return userModels;
  }

  // Future<List<UserModel>> readDataFromSQLite() async {
  //   Database database = await connectedDatabase();
  //   List<UserModel> userModels = [];

  //   List<Map<String, dynamic>> maps = await database.query(tableDatabase);

  //   for (var map in maps) {
  //     UserModel userModel = UserModel.fromJson(map);
  //     userModels.add(userModel);
  //   }

  //   return userModels;
  // }

  Future<Null> deleteData(int userid) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase, where: '$userid = $userid');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAllData() async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase);
       print('e deleteAllData ==>');
    } catch (e) {
      print('e deleteAllData ==> ${e.toString()}');
    }
  }
}
