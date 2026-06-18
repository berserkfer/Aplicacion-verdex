import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/recycling_request.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';
import 'new_request_screen.dart';

class CitizenDashboard extends StatefulWidget {
  const CitizenDashboard({super.key});

  @override
  State<CitizenDashboard> createState() => _CitizenDashboardState();
}

class _CitizenDashboardState extends State<CitizenDashboard> {
  bool _loading = true;
  int _totalRequests = 0;
  int _pendingRequests = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final api = context.read<AuthProvider>().api;
      final requests = await api.getRequests();
      if (!mounted) return;
      setState(() {
        _totalRequests = requests.length;
        _pendingRequests = requests
            .where(
              (r) =>
                  r.status == RequestStatus.pending ||
                  r.status == RequestStatus.assigned ||
                  r.status == RequestStatus.inProgress,
            )
            .length;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showAppSnack(context, e.message, error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user!;

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Hola, ${user.fullName}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Realiza tu primera solicitud de reciclaje o revisa el estado de tus pedidos.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          StatCard(
            label: 'Mis solicitudes',
            value: '$_totalRequests',
            icon: Icons.recycling,
          ),
          const SizedBox(height: 12),
          StatCard(
            label: 'Activas',
            value: '$_pendingRequests',
            icon: Icons.pending_actions,
            color: Colors.orange,
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Nueva solicitud de reciclaje'),
              subtitle: const Text('Materiales a reciclar desde tu domicilio'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NewRequestScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
