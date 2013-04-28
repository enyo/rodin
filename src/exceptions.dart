part of mongo_mache;

class MongoMacheException implements Exception {

  final String msg;

  const MongoMacheException([this.msg]);

  String toString() => msg == null ? 'MongoMacheException' : msg;

}

