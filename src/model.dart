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

  ObjectId id;

  ModelDescription _description;

  /// Returns the model description for this model.
  ///
  /// Gets the [ModelDescription] with [getModelDescription] the first time
  /// and caches the response for further requests.
  ModelDescription get $description {
    if (_description == null) {
      _description = getModelDescription(this);
    }
    return _description;
  }

  /// Returns the collection for this model.
  DbCollection get _dbCollection {
    $description.dbCollection;
  }

  /// Returns a list of changed fields.
  Map<String, dynamic> get $changedFields {
    var reflection = reflect(this);
    var changedFields = { };

    $description.fields.forEach((fieldName, value) {
      var value = reflection.getField(new Symbol(fieldName)).reflectee;
      if (value != null) {
        changedFields[fieldName] = value;
      }
    });

    return changedFields;
  }

  /// Finds the model in the database.
  ///
  /// Usually this is used like this:
  ///
  ///     new MyModel()
  ///         ..name = "test"
  ///         ..find().then((Model record) {
  ///           // handle the record
  ///         });
  Future<Model> find() {
    Completer completer = new Completer();

    var _this = this;

    SelectorBuilder selectors = where;
    $changedFields.forEach((fieldName, value) => selectors.eq(fieldName, value));

    _dbCollection.findOne(selectors).then((result) {
      // TODO: Actually fill the values.
      completer.complete(_this);
    }, (error) => completer.completeError(error));

    completer.future;
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