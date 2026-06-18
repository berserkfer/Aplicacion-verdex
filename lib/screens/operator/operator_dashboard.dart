import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/dashboard_stats.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';

class OperatorDashboard extends StatefulWidget {
  const OperatorDashboard({super.key});

  @override
  State<OperatorDashboard> createState() => _OperatorDashboardState();
}

class _OperatorDashboardState extends State<OperatorDashboard> {
  bool _loading = true;
  DashboardStats? _stats;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final api = context.read<AuthProvider>().api;
      final stats = await api.getDashboardStats();
      if (!mounted) return;
      setState(() {
        _stats = stats;
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
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final stats = _stats!;

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Panel de Control - Municipalidad',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          StatCard(
            label: 'Solicitudes totales',
            value: '${stats.totalRequests}',
            icon: Icons.recycling,
          ),
          const SizedBox(height: 12),
          StatCard(
            label: 'Completadas',
            value: '${stats.completedRequests}',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          StatCard(
            label: 'Pendientes',
            value: '${stats.pendingRequests}',
            icon: Icons.pending,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          StatCard(
            label: 'En progreso',
            value: '${stats.inProgressRequests}',
            icon: Icons.local_shipping,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 12),
          StatCard(
            label: 'Kg recolectados',
            value: stats.totalKgRecollected,
            icon: Icons.scale,
          ),
          const SizedBox(height: 12),
          StatCard(
            label: 'Ciudadanos registrados',
            value: '${stats.totalCitizens}',
            icon: Icons.people_outline,
          ),
          const SizedBox(height: 12),
          StatCard(
            label: 'Recolectores activos',
            value: '${stats.totalCollectors}',
            icon: Icons.groups_outlined,
          ),
        ],
      ),
    );
  }
}
