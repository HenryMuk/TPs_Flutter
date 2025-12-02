import 'package:flutter/material.dart';
import 'package:l4_seance_2/controller/register_controller.dart';
import 'package:l4_seance_2/view/home_page.dart';
import 'package:l4_seance_2/view/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = RegisterController();
  bool _isLoading = false;

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF5F7FA),
    body: Center(
      child: SingleChildScrollView(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // TITRE
              Text(
                "Créer un compte",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Inscris-toi pour accéder à l'application",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 35),

              // NOM
              const Text("Nom", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Votre nom",
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: _inputBorder(),
                  enabledBorder: _inputBorder(),
                  focusedBorder: _inputBorderFocused(),
                ),
              ),

              const SizedBox(height: 25),

              // EMAIL
              const Text("Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "email@example.com",
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: _inputBorder(),
                  enabledBorder: _inputBorder(),
                  focusedBorder: _inputBorderFocused(),
                ),
              ),

              const SizedBox(height: 25),

              // MOT DE PASSE
              const Text("Mot de passe",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Votre mot de passe",
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: _inputBorder(),
                  enabledBorder: _inputBorder(),
                  focusedBorder: _inputBorderFocused(),
                ),
              ),

              const SizedBox(height: 40),

              // BOUTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    shadowColor: const Color.fromARGB(255, 244, 244, 244).withOpacity(0.5),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "S'INSCRIRE",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // Lien login
              Center(
                child: TextButton(
                 onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                  child: const Text(
                    "Déjà un compte ? Se connecter",
                    style: TextStyle(
                      color: Color.fromARGB(255, 141, 141, 141),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    ),
  );
}

// BORDER STYLÉS
OutlineInputBorder _inputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  );
}

OutlineInputBorder _inputBorderFocused() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Color(0xFF26C318),
      width: 2,
    ),
  );
}


  void _register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez remplir tous les champs'), backgroundColor: Colors.red));
      return;
    }

    setState(() => _isLoading = true);

    final error = await _controller.register(name, email, password);

    if (error == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: Colors.red));
    }

    setState(() => _isLoading = false);
  }
}
