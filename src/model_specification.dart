part of mongo_mache;


/// This class reflects the model and extracts all the specifications of it.
class ModelSpecification {

  Model model;

  Db db;

  List<Specification> specifications;

  ModelSpecification(this.model, this.db) {
    if (!db.connection.connected) {
      throw new MongoMacheException("You can only add models with a valid database connection.");
    }
    _reflectModel();
  }

  void _reflectModel() {

  }

}