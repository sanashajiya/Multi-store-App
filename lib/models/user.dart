import 'dart:convert';

class User {
  // Define fields
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  // Serialization: convert User object to a Map
  // Map: A Map is a collection of key/value pairs
  // why: Converting to a map is an intermediate step that makes it easier to serialize
  // the object to formates like json for storage or transmission.

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

  // Serialization : Map to a Json String
  // This method directly encodes the data  from the Map into a Json String

  // The json.encode() function converts a Dart object (such as Map or List)
  // into a Json String representation, making it suitable for communication
  // between different systems.

  String toJson() => json.encode(toMap());

  // Deserialization: Convert a Map to a User object
  // purpose - Manipuation and user: Once the data is converted to a User Object
  // it can be easily manipulated and used within the application. for example
  // we might want to display the user's fullName,email etc on the UI or we might 
  // want to save the data locally


  // the factory constructor takes a Map(Usually obtained from a json object)
  // and converts it into a User object.if a field is not present in the map,
  // it defaults to an empty string

  // fromMap: this constructor take a Map<String,dynamic> and converts it into a User object
  // its usefull when you already have the data in map format
  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['_id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      locality: map['locality'] as String? ?? '',
      password: map['password'] as String? ?? '',
      token: map['token'] as String? ?? '',
    );
  }

  // fromJson: This factory constructor takes Json String, and decoded into a Map<String,dynamic>
  // and then uses fromMap to convert that Map into a User object.

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String,dynamic>);
}
