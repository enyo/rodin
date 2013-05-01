# Rodin

/roʊˈdæn/

This is an object modeling tool for MongoDB, based on [mongo dart](https://github.com/vadimtsushko/mongo_dart).

> This library is not yet finished! Do not use.

The name comes from [Auguste Rodin](http://en.wikipedia.org/wiki/Auguste_Rodin)
who was a french sculptor.

## Metadata (annotations)

Until reflection for metadata is possible in dart, the configuration for Models
is a bit noisy and temporary.

This is how you'll define the models as soon as it's done:


```dart

@CompoundIndex({ "firstName": Direction.ASC, "lastName": Direction.DESC })
class UserModel extends Model {

  @Required()
  @Unique()
  String username;
  
  String firstName;

  String lastName;

}

UserModel user = new UserModel()
  ..username = "enyo"
  ..firstName = "Matias"
  ..lastName = "Meno"
  ..save(); // And save the record to the database.
 
```

For now you'll have to specify the specifications like this:

```dart
class UserModel extends Model {

  String username;
  
  String firstName;

  String lastName;

  static Map<String, List<Specification>> specifications = {
    "_MODEL_": [ const CompoundIndex(const { "firstName": Direction.ASC, "lastName": Direction.DESC }) ],
    "username": [ const Required(), const Unique() ]
  };
}
```


## Other database

The database implementation of rodin is very decoupled of the rest. So it isn't
difficult to write other database adapters for it. I might extend it for 
other databases some day.