part of mongo_mache;


/// This class reflects the model and extracts all the specifications of it.
class ModelSpecification {

  Type modelClass;

  Db db;

  List<Specification> specifications;

  ModelSpecification(this.modelClass, this.db) {
    if (!db.connection.connected) {
      throw new MongoMacheException("You can only add models with a valid database connection.");
    }
    _reflectModel();
  }

  void _reflectModel() {
    ClassMirror cm = reflectClass(modelClass); // Reflects MyClass
    for (var k in cm.members.keys) print(MirrorSystem.getName(k));
//    cm.members.forEach((Symbol k,v) => print(k));
//    for (var m in cm.members.values) print(m.);
  }

}