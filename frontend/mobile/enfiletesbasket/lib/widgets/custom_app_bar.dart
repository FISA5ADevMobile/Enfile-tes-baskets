import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPersonIconPressed;

  const CustomAppBar({Key? key, this.onPersonIconPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.5),
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: onPersonIconPressed ?? () {},
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/logo_enfiletesbaskets_transparent.png',
                height: 40,
              ),
            ),
          ),
          const SizedBox(width: 48), // Ajustez pour équilibrer la barre
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
