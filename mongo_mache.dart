library mongo_mache;

import "dart:async";
import "package:mongo_dart/mongo_dart.dart";
import 'dart:mirrors';

part "src/exceptions.dart";
part "src/specifications.dart";
part "src/model.dart";
part "src/model_specification.dart";


List<ModelSpecification> modelDefinitions;

ModelSpecification registerModel(Model model, Db db) {
  return new ModelSpecification(model, db);
}