import 'package:unittest/unittest.dart';

import 'package:unittest/mock.dart';

import 'package:mongo_dart/mongo_dart.dart';

import "../rodin.dart";


@CompoundIndex(const [ "firstName", "lastName" ])
class UserModel extends Model {

  @Required
  @Unique
  String username;

  String firstName;

  String lastName;

  num age;

  bool active;

  static Map<String, List<Specification>> specifications = {
    "_MODEL_": [ const CompoundIndex(const [ "firstName", "lastName" ]) ],
    "username": [ const Required(), const Unique() ]
  };

}


class InvalidModel extends Model {

  int invalidType;

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

  group("ModelSpecification", () {
    group("registerModel()", () {
      var db = new MockDb();

      setUp(() => modelDescriptions = []);

      group("disconnected", () {
        setUp(() => db.connection.connected = false);
        tearDown(() => db.connection.connected = true);

        test("should fail if the database is not connected", () =>
            expect(() => registerModel(UserModel, db), throws));

      });

      group("connected", () {
        setUp(() => db.connection.connected = true);

        test("should not fail if connected", () => registerModel(UserModel, db, specifications: UserModel.specifications));

        test("should fail if using an invalid type", () {
          expect(() => registerModel(InvalidModel, db), throwsException);
        });

        test("should properly reflect the model", () {
          var desc = registerModel(UserModel, db, specifications: UserModel.specifications);
          expect(desc.fields, equals({
            "username": "dart.core.String",
            "firstName": "dart.core.String",
            "lastName": "dart.core.String",
            "age": "dart.core.num",
            "active": "dart.core.bool"
          }));
        });

        test("getModelDescription()", () {
          var desc = registerModel(UserModel, db, specifications: UserModel.specifications);
          var userModel = new UserModel();
          var foundDesc = getModelDescription(userModel);
          expect(desc, equals(foundDesc));
        });
      });
    });
  });
}