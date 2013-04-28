part of mongo_mache;


/// Serves as interface for all Specifications.
abstract class Specification {

}


/// Marks a property as required.
class Required implements Specification {

  const Required();

}

/// Marks a property as unique.
class Unique implements Specification {

  const Unique();

}


/// Specifies an index for a property.
class Index implements Specification {

  const Index();

}


class Direction {

  static const ASCENDING = const Direction._(1);
  static const ASC = this.ASCENDING;

  static const DESCENDING = const Direction._(-1);
  static const DESC = this.DESCENDING;


  final int _direction;

  const Direction._(this._direction);

}

/// Specifies a compound index for multiple properties.
class CompoundIndex implements Specification {

  /**
   * A compound index could look like this:
   *
   *     { "firstName": Direction.ASC, "lastName": Direction.DESC }
   */
  final Map<String, Direction> properties;

  const CompoundIndex(this.properties);

}

