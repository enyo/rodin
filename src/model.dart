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

  /// Every model has an ID.
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

    $description.fields.keys.forEach((fieldName) {
      var value = reflection.getField(new Symbol(fieldName)).reflectee;
      if (value != null) {
        changedFields[fieldName] = value;
      }
    });

    return changedFields;
  }

  /// Goes through all the values and sets them on the model.
  ///
  /// If an `_id` key is present, the `id` attribute will be set.
  setValues(Map<String, dynamic> values) {
    if (values.containsKey("_id")) {
      this.id = new ObjectId.fromHexString(values["_id"]);
    }
    var reflection = reflect(this);
    $description.fields.keys.forEach((fieldName) {
      if (values.containsKey(fieldName)) {
        reflection.setField(new Symbol(fieldName), values[fieldName]);
      }
    });
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
    SelectorBuilder selectors = where;
    $changedFields.forEach(selectors.eq);

    return _dbCollection.findOne(selectors).then((result) {
      setValues(result);
      return this;
    });
  }

  /// Inserts the model to the database.
  Future insert() {

  }

  /// Deletes the model from the database.
  Future delete() {

  }

  /// Updates the model in the database.
  Future update() {

  }

}