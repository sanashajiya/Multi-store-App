import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_cart/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  // constructor initializing with the default User Object
  // Purpose: Manage the state of the user object allowing updates
  UserProvider() : super(null);
  // Getter method to extract value from an object
  User? get user => state;

  //method to set user state from Json
  //purpose : updates the user state based on json string representation of user object
  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  //Method to clear user state
  void signOut() {
    state = null;
  }

  // Method to Recreate the user state
  void recreateUserState({
    required String state,
    required String city,
    required String locality,
  }) {
    if (this.state != null) {
      this.state = User(
        id: this.state!.id,  //preserves the existing user
        username: this.state!.username,  //preserves the existing user
        email: this.state!.email,  //preserves the existing user email
        state: state,
        city: city,
        locality: locality,
        password: this.state!.password,  // preserve the existing user password
        token: this.state!.token,     // preserve the existing user token
      );
    }
  }
}

// make the data accessible within the application
final userProvider = StateNotifierProvider<UserProvider, User?>(
  (ref) => UserProvider(),
);
