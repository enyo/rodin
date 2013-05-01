part of rodin;

class RodinException implements Exception {

  final String msg;

  const RodinException([this.msg]);

  String toString() => msg == null ? 'RodinException' : msg;

}

