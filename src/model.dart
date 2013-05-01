part of rodin;


/// Extend this class to create a model of your own.
///
/// Define all fields of your database with normal types.
///
/// Use the static field `specifications` to define the specifications
/// for now (see the [Specification] class).
///
/// In the future you will be able to use metadata for it.
class Model {


  /// Finds the model in the database.
  ///
  /// Usually this is used like this:
  ///
  ///     new MyModel()
  ///         ..name = "test"
  ///         ..find().then((record) {
  ///           // handle the record
  ///         });
  Future<Model> find() {

  }

  /// Saves the model to the database.
  Future save() {

  }

  /// Deletes the model from the database.
  Future delete() {

  }

  /// Updates the model in the database.
  Future update() {

  }

}