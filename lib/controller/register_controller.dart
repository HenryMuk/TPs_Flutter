import 'package:firebase_auth/firebase_auth.dart';

class RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Inscription avec nom, email et mot de passe
  Future<String?> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Mettre à jour le displayName
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();

      return null; // succès
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') return 'Mot de passe trop court';
      if (e.code == 'email-already-in-use') return 'Email déjà utilisé';
      if (e.code == 'invalid-email') return 'Email invalide';
      return 'Erreur: ${e.message}';
    } catch (e) {
      return 'Une erreur inattendue est survenue: $e';
    }
  }
}
