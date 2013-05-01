library rodin;

import "dart:async";
import "package:mongo_dart/mongo_dart.dart";
import 'dart:mirrors';

part "src/exceptions.dart";
part "src/specifications.dart";
part "src/model.dart";
part "src/model_description.dart";


List<ModelDescription> modelDescriptions = [ ];


/// Creates a [ModelDescription] for the provided model, and adds it to the
/// [modelDescriptions] List.
ModelDescription registerModel(Type model, Db db, { specifications }) {
  var desc = new ModelDescription(model, db, specifications: specifications);
  modelDescriptions.add(desc);
  return desc;
}


/// Returns the description for given model.
///
/// See [ModelDescription] for more information.
ModelDescription getModelDescription(Model model) {
  return modelDescriptions.firstWhere((ModelDescription desc) => model.runtimeType.toString() == desc.modelClass.toString());
}

abstract class MongoMache {

  Future<Model> find(Model model) {

  }

}