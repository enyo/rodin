import 'package:unittest/unittest.dart';

import 'package:unittest/mock.dart';

import 'package:mongo_dart/mongo_dart.dart';

import "../rodin.dart";


@CompoundIndex(const { "firstName": Direction.ASC, "lastName": Direction.DESC })
class UserModel extends Model {

  @Required
  @Unique
  String username;

  String firstName;

  String lastName;

  num age;

  bool active;

  static Map<String, List<Specification>> specifications = {
    "_MODEL_": [ const CompoundIndex(const { "firstName": Direction.ASC, "lastName": Direction.DESC }) ],
    "username": [ const Required(), const Unique() ]
  };

}

class LongModelNameModel extends Model {

  String value;

}


class InvalidModel extends Model {

  int invalidType;

}


class MockDb extends Mock implements Db {

  MockConnection connection;

  MockDb() {
    connection = new MockConnection();
    when(callsTo('collection')).alwaysCall((collectionName) {
      return new MockDbCollection(collectionName);
    });
  }

}
class MockConnection extends Mock implements Connection {

  bool connected = true;

}
class MockDbCollection extends Mock implements DbCollection {

  String collectionName;

  MockDbCollection(this.collectionName);

}

main() {

  group("ModelDescription", () {
    group("registerModel()", () {
      var db = new MockDb();

      setUp(() => modelDescriptions = []);

      group("when disconnected", () {
        setUp(() => db.connection.connected = false);
        tearDown(() => db.connection.connected = true);

        test("should fail", () =>
            expect(() => registerModel(UserModel, db), throws));

      });

      group("when connected", () {
        setUp(() => db.connection.connected = true);

        test("should not fail", () => registerModel(UserModel, db, specifications: UserModel.specifications));

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
          expect(desc.dbCollection.collectionName, equals("users"));
        });

        test("getModelDescription() should return the correct model", () {
          var desc = registerModel(UserModel, db, specifications: UserModel.specifications);
          var userModel = new UserModel();
          var foundDesc = getModelDescription(userModel);
          expect(desc, equals(foundDesc));
        });

        test("model.description should return the correct description", () {
          var desc = registerModel(UserModel, db, specifications: UserModel.specifications);
          var userModel = new UserModel();
          expect(desc, equals(userModel.$description));
        });

        test("the collection name should be detected from the model name", () {
          var desc = registerModel(LongModelNameModel, db);
          expect(desc.dbCollection.collectionName, equals("long_model_names"));
        });
      });
    });
  });
}