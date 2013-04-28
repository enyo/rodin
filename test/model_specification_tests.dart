import 'package:unittest/unittest.dart';

import 'package:unittest/mock.dart';

import 'package:mongo_dart/mongo_dart.dart';

import "../mongo_mache.dart";


@CompoundIndex([ "firstName", "lastName" ])
class UserModel extends Model {

  const Model_spec = const [ const CompoundIndex([ "firstName", "lastName" ]) ];

  const username_spec = const [ const Required(), const Unique() ];
  @Required
  @Unique
  String username;

  String firstName;
  String lastName;

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

      group("disconnected", () {
        setUp(() => db.connection.connected = false);
        tearDown(() => db.connection.connected = true);

        test("should fail if the database is not connected", () =>
            expect(() => registerModel(UserModel, db), throws));

      });

      group("connected", () {
        setUp(() => db.connection.connected = true);
        test("should not fail if connected", () => registerModel(UserModel, db));
      });
    });
  });
}