import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';

class CollectorDashboard extends StatefulWidget {
  const CollectorDashboard({super.key});

  @override
  State<CollectorDashboard> createState() => _CollectorDashboardState();
}

class _CollectorDashboardState extends State<CollectorDashboard> {
  bool _loading = true;
  int _assigned = 0;
  int _inProgress = 0;
  int _completed = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final api = context.read<AuthProvider>().api;
      final stats = await api.getCollectorStats();
      if (!mounted) return;
      setState(() {
        _assigned = stats.assignedTotal;
        _inProgress = stats.inProgress;
        _completed = stats.completed;
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
          Text('Hola, ${user.fullName}', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          if (user.vehicleType != null)
            Text('Vehículo: ${user.vehicleType} • Zona: ${user.assignedZone ?? 'Sin zona'}'),
          const SizedBox(height: 20),
          StatCard(label: 'Asignadas', value: '$_assigned', icon: Icons.assignment),
          const SizedBox(height: 12),
          StatCard(
            label: 'En progreso',
            value: '$_inProgress',
            icon: Icons.local_shipping,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 12),
          StatCard(
            label: 'Completadas',
            value: '$_completed',
            icon: Icons.check_circle_outline,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
