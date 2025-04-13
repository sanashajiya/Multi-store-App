// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  // Define Fields
  final String id;
  final String username;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.state,
      required this.city,
      required this.locality,
      required this.password,
      required this.token,
    });

//Process of converting user object to a map is called serialisation
//Serialisation: Convert user object to a map
//Map: A Map is a collection of key-value pairs
//Why: Converting to a map is an intermediate step that makes it easier to serialize the object to formates like json for storage or transmission.

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

// Serialisation: Convert Map to a Json String
// This method directly encodes the data from the Map to a Json String

// The json.encode() function converts a dart object (such a Map or List)
// into a JSON string representation , making it suitable for communication
// between different systems.
  String toJson() => json.encode(toMap());

//Deserialization: convert a Map to a User object
//purpose - Manipulation and user : once the data is converted to a User Object
// it can be easily manupulated and use within the application.
//For example we might want to display the user's fullname, email etc.. on the UI. or we might want ti save the data locally.

// the factory constructor takes a Map(usually obtained from a Json Object) and converts it into a User Object. If a field is not present in the Map,
// it defaults to an empty string.

//fromMap: This constructor take a Map<String, dynamic> and converts it into a User Object
// its useful when you already have the data in map format
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      locality: map['locality'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

// fromJson: This factory constructor takes json string, and decodes it into a Map<String, dynamic>
// and then uses fromMap to convert that Map into a User Object
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
