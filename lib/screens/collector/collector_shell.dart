import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import 'collector_dashboard.dart';
import 'my_assigned_requests_screen.dart';

class CollectorShell extends StatefulWidget {
  const CollectorShell({super.key});

  @override
  State<CollectorShell> createState() => _CollectorShellState();
}

class _CollectorShellState extends State<CollectorShell> {
  int _index = 0;

  final _pages = const [
    CollectorDashboard(),
    MyAssignedRequestsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verdex — Recolector'),
        actions: [
          IconButton(
            onPressed: () => context.read<AuthProvider>().logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Asignadas',
          ),
        ],
      ),
    );
  }
}
