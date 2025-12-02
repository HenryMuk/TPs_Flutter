import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Connexion avec email et mot de passe
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // succès
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return 'Utilisateur non trouvé';
      if (e.code == 'wrong-password') return 'Mot de passe incorrect';
      if (e.code == 'invalid-email') return 'Email invalide';
      return 'Erreur: ${e.message}';
    } catch (e) {
      return 'Une erreur inattendue est survenue: $e';
    }
  }

  /// Déconnexion
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// Récupérer l'utilisateur actuel
  User? get currentUser => _auth.currentUser;
}
