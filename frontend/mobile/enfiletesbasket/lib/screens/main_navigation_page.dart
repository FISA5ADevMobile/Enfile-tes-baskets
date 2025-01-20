import 'package:flutter/material.dart';
import 'classes_page.dart';
import 'communities_page.dart';
import 'home_page.dart';
import 'actuality_details_screen.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_app_bar.dart';

class MainNavigationPage extends StatefulWidget {
  final int initialIndex;

  const MainNavigationPage({Key? key, this.initialIndex = 0}) : super(key: key);

  static void navigateToActualityDetails(BuildContext context, int actualityId) {
    final state = context.findAncestorStateOfType<_MainNavigationPageState>();
    state?._showActualityDetails(actualityId);
  }

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late int _selectedIndex;
  int? _selectedActualityId;

  final List<Widget> _screens = [
    const HomePage(),
    const CommunitiesPage(),
    ClassesPage(),
  ];
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedActualityId = null;
    });
  }

  void _showActualityDetails(int actualityId) {
    setState(() {
      _selectedActualityId = actualityId;
    });
  }

  bool _shouldShowBackButton() {
    return _selectedIndex != 0 || _selectedActualityId != null;
  }

  Widget _getCurrentScreen() {
    if (_selectedActualityId != null) {
      return ActualityDetailPage(actualityId: _selectedActualityId!);
    } else {
      return _screens[_selectedIndex];
    }
  }

  int _getCurrentNavigationIndex() {
    if (_selectedActualityId != null) {
      return 0;
    }
    return _selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: _shouldShowBackButton(),
        onBackButtonPressed: () {
          setState(() {
            if (_selectedActualityId != null) {
              _selectedActualityId = null;
            } else {
              _selectedIndex = 0;
            }
          });
        },
      ),
      body: _getCurrentScreen(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _getCurrentNavigationIndex(),
        onTap: _onItemTapped,
      ),
    );
  }
}
