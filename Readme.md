# Mongo Mâché

This is an object modeling tool for MongoDB, based on [mongo dart](https://github.com/vadimtsushko/mongo_dart).

> This library is not yet finished! Do not use.

The name comes from [Papier mâché](http://en.wikipedia.org/wiki/Papier-m%C3%A2ch%C3%A9).

## Metdata (annotations)

Until reflection for metadata is possible in dart, the configuration for Models
is a bit noisy and temporary.

This is how you'll define the models as soon as it's done:


```dart

@CompoundIndex({ "firstName": Direction.ASC, "lastName": Direction.DESC });
class UserModel {

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