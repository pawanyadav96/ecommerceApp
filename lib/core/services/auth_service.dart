import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn =
  GoogleSignIn();

  Future<User?> signInWithGoogle() async {

    try {

      final GoogleSignInAccount?
      googleUser =
      await _googleSignIn.signIn();

      // User cancelled login
      if (googleUser == null) {

        throw Exception(
          "Login Cancelled",
        );
      }

      final GoogleSignInAuthentication
      googleAuth =
      await googleUser.authentication;

      final credential =
      GoogleAuthProvider.credential(
        accessToken:
        googleAuth.accessToken,
        idToken:
        googleAuth.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(
        credential,
      );

      return userCredential.user;

    } on FirebaseAuthException catch (e) {

      throw Exception(e.message);

    } catch (e) {

      rethrow;
    }
  }

  Future<void> logout() async {

    await _googleSignIn.signOut();

    await _auth.signOut();
  }
}