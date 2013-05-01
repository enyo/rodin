import 'package:unittest/unittest.dart';

import 'package:unittest/mock.dart';

import 'package:mongo_dart/mongo_dart.dart';

import "../rodin.dart";


class UserModel extends Model {

  String username;

  String firstName;

  String lastName;

  num age;

  bool active;

}


class MockDb extends Mock implements Db {

  MockConnection connection;

  MockDb() {
    connection = new MockConnection();
  }


}
class MockConnection extends Mock implements Connection {

  bool connected = true;

}

main() {

  group("Model", () {
    group("when properly registered", () {
      var db = new MockDb();
      setUp(() {
        modelDescriptions = [];
        registerModel(UserModel, db);
      });

      test("should properly return all changed values", () {
        UserModel userModel = new UserModel()
            ..firstName = "Matias"
            ..active = false;
        expect(userModel.$changedFields, equals({ "firstName": "Matias", "active": false }));

      });
   });
  });
}