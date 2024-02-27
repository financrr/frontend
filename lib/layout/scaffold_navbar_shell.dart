import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavBarShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldNavBarShell({super.key, required this.navigationShell});

  static ScaffoldNavBarShellState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<ScaffoldNavBarShellState>();

  @override
  State<StatefulWidget> createState() => ScaffoldNavBarShellState();
}

class ScaffoldNavBarShellState extends State<ScaffoldNavBarShell> {
  static const List<NavigationDestination> _destinations = [
    NavigationDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    NavigationDestination(
      icon: Icon(Icons.account_balance_wallet_outlined),
      selectedIcon: Icon(Icons.account_balance_wallet),
      label: 'Transactions',
    ),
    NavigationDestination(
      icon: Icon(Icons.leaderboard_outlined),
      selectedIcon: Icon(Icons.leaderboard),
      label: 'Statistics',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: widget.navigationShell,
      ),
      appBar: AppBar(),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) => goToBranch(index),
          selectedIndex: widget.navigationShell.currentIndex,
          destinations: _destinations),
    );
  }

  // Resets the current branch. Useful for popping an unknown amount of pages.
  void resetLocation() {
    widget.navigationShell.goBranch(widget.navigationShell.currentIndex, initialLocation: true);
  }

  /// Jumps to the corresponding [StatefulShellBranch], based on the specified index.
  void goToBranch(int index) {
    widget.navigationShell.goBranch(index, initialLocation: index != widget.navigationShell.currentIndex);
  }
}
