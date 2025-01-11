import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackButtonPressed;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    this.showBackButton = false,
    this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.75),
      toolbarHeight: 80,
      title: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 32,
                color: Color(0xFF49454F),
              ),
              onPressed: onBackButtonPressed ?? () {
                Navigator.pop(context);
              },
            ),
          if (!showBackButton)
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'logout') {
                  await Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              icon: const Icon(
                Icons.account_circle,
                size: 32,
                color: Color(0xFF49454F),
              ),
              offset: const Offset(0, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Center(
                    child: Text(
                      'Déconnexion',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              color: Colors.white,
            ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/logo_enfiletesbaskets_appbar.png',
                height: 60,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
