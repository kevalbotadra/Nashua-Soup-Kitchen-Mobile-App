import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/providers/authentication_provider.dart';
import 'package:nsks/helpers/firebase_functions.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider;

  AuthenticationRepository(this._authenticationProvider);

  Future<NsksUser> loginUser(String email, String password) async {
    final User? user =
        await _authenticationProvider.login(email: email, password: password);

    if (user != null) {
      final NsksUser finalUser = await getCurrentUserFromFirebaseUser(user);
      return finalUser;
    } else {
      return NsksUser(isValid: false);
    }
  }

  Future<NsksUser> registerUser({
    required String username,
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    bool isStaff = false,
    bool isVerified = false,
  }) async {
    final User? user = await _authenticationProvider.registerUser(
      username: username,
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
      isStaff: isStaff,
      isVerified: isVerified,
    );

    if (user != null) {
      final NsksUser finalUser = await getCurrentUserFromFirebaseUser(user);
      return finalUser;
    } else {
      return NsksUser(isValid: false);
    }
  }

  Future<NsksUser> getCurrentUser() async {
    final User? currentUser = await _authenticationProvider.getCurrentUser();
    return await getCurrentUserFromFirebaseUser(currentUser);
  }

  Future<void> signOut() async {
    await _authenticationProvider.logout();
  }
}