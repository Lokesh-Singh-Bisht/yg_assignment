import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yg_assignment/routes/app_routes.dart';

class NavigationScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationScreen({super.key, required this.navigationShell});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              AppRoutes.router.go('/home');
              break;
            case 1:
              AppRoutes.router.go('/courses');
              break;
          }
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'Courses'),
        ],
      ),
    );
  }
}
