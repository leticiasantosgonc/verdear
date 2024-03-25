import 'package:firebase_auth/firebase_auth.dart';

class AutenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user.user!.updateDisplayName(name);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return 'Email já cadastrado';
      }
      return 'Erro desconhecido';
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logOut() async {
    return _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> deleteAccount() async {
    await _auth.currentUser!.delete();

    return logOut();
  }

  String getCurrentUserID() {
    return _auth.currentUser!.uid;
  }
}
