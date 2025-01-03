import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPersonIconPressed;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;

  const CustomAppBar({
    Key? key,
    this.onPersonIconPressed,
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
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                size: 32,
                color: Color(0xFF49454F),
              ),
              onPressed: onPersonIconPressed ?? () {},
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
