import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import 'collectors_list_screen.dart';
import 'create_collector_screen.dart';
import 'manage_requests_screen.dart';
import 'materials_screen.dart';
import 'operator_dashboard.dart';

class OperatorShell extends StatefulWidget {
  const OperatorShell({super.key});

  @override
  State<OperatorShell> createState() => _OperatorShellState();
}

class _OperatorShellState extends State<OperatorShell> {
  int _index = 0;

  final _pages = const [
    OperatorDashboard(),
    ManageRequestsScreen(),
    MaterialsScreen(),
    CollectorsListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Municipal'),
        actions: [
          IconButton(
            onPressed: () => context.read<AuthProvider>().logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _pages[_index],
      floatingActionButton: _index == 3
          ? FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreateCollectorScreen(),
                  ),
                );
                setState(() {});
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Nuevo recolector'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Panel',
          ),
          NavigationDestination(
            icon: Icon(Icons.manage_search_outlined),
            selectedIcon: Icon(Icons.manage_search),
            label: 'Solicitudes',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Materiales',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Recolectores',
          ),
        ],
      ),
    );
  }
}
