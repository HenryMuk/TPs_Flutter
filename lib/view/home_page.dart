import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:l4_seance_2/view/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;

  return Scaffold(
    backgroundColor: const Color(0xFFF4F6FA),
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Bienvenue ${user?.displayName ?? ''}',
        style: const TextStyle(
          color: Color(0xFF1A1D1F),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.black87),
          tooltip: 'Se déconnecter',
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // ***** PROFILE CARD *****
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: const Color(0xFF1A73E8),
                  child: Text(
                    user?.displayName?.substring(0, 1).toUpperCase() ?? "U",
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bonjour ${user?.displayName ?? 'Utilisateur'} 👋",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1D1F),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          // ***** MENU LIST *****
          Expanded(
            child: ListView(
              children: [
                _buildActionTile(
                  icon: Icons.person_outline,
                  title: 'Mon profil',
                  onTap: () {},
                ),
                _buildActionTile(
                  icon: Icons.settings_outlined,
                  title: 'Paramètres',
                  onTap: () {},
                ),
                _buildActionTile(
                  icon: Icons.help_outline,
                  title: 'Aide & Support',
                  onTap: () {},
                ),
                _buildActionTile(
                  icon: Icons.info_outline,
                  title: 'À propos',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildActionTile({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Icon(icon, size: 26, color: const Color(0xFF1A73E8)),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black45),
          ],
        ),
      ),
    ),
  );
}

}
