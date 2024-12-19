import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPersonIconPressed;

  const CustomAppBar({Key? key, this.onPersonIconPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Couleur blanche pour l'AppBar
      elevation: 4, // Ombre sous l'AppBar
      shadowColor: Colors.black.withOpacity(0.75), // Couleur de l'ombre
      toolbarHeight: 80, // Hauteur augmentée de la CustomAppBar
      title: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.account_circle, // Icône avec tout le bonhomme en couleur
              size: 32, // Taille ajustée de l'icône
              color: Color(0xFF49454F),
              // Couleur personnalisée (49454F)
            ),
            onPressed: onPersonIconPressed ?? () {},
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/logo_enfiletesbaskets_appbar.png',
                height: 60, // Taille augmentée pour le logo
              ),
            ),
          ),
          const SizedBox(width: 48), // Ajustement pour équilibrer la barre
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // Hauteur de l'AppBar
}
