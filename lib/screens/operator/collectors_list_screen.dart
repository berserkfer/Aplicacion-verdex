import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/collector.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';

class CollectorsListScreen extends StatefulWidget {
  const CollectorsListScreen({super.key});

  @override
  State<CollectorsListScreen> createState() => _CollectorsListScreenState();
}

class _CollectorsListScreenState extends State<CollectorsListScreen> {
  bool _loading = true;
  var _collectors = const <Collector>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final api = context.read<AuthProvider>().api;
      final collectors = await api.getCollectors();
      if (!mounted) return;
      setState(() {
        _collectors = collectors;
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

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _collectors.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final collector = _collectors[index];
          return Card(
            child: ListTile(
              title: Text(collector.fullName),
              subtitle: Text(
                '${collector.email}\n'
                '${collector.phone ?? 'Sin teléfono'} • '
                '${collector.vehicleType ?? 'Sin vehículo'} • '
                '${collector.assignedZone ?? 'Sin zona'}',
              ),
              isThreeLine: true,
              trailing: collector.active
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.cancel, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
