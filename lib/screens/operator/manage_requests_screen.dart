import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/collector.dart';
import '../../models/recycling_request.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';

class ManageRequestsScreen extends StatefulWidget {
  const ManageRequestsScreen({super.key});

  @override
  State<ManageRequestsScreen> createState() => _ManageRequestsScreenState();
}

class _ManageRequestsScreenState extends State<ManageRequestsScreen> {
  bool _loading = true;
  List<RecyclingRequest> _requests = [];
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
      final requests = await api.getRequests();
      final collectors = await api.getCollectors();
      if (!mounted) return;
      setState(() {
        _requests = requests;
        _collectors = collectors;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showAppSnack(context, e.message, error: true);
    }
  }

  Future<void> _assign(int requestId) async {
    if (_collectors.isEmpty) {
      showAppSnack(context, 'No hay recolectores disponibles', error: true);
      return;
    }

    final api = context.read<AuthProvider>().api;
    final collector = await showDialog<Collector>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Asignar recolector'),
        children: _collectors
            .map(
              (c) => SimpleDialogOption(
                onPressed: () => Navigator.pop(context, c),
                child: Text('${c.fullName} — ${c.assignedZone ?? 'Sin zona'}'),
              ),
            )
            .toList(),
      ),
    );

    if (collector == null || !mounted) return;

    try {
      await api.assignRequest(
        requestId: requestId,
        collectorId: collector.id,
      );
      if (!mounted) return;
      showAppSnack(context, 'Solicitud asignada');
      _load();
    } on ApiException catch (e) {
      if (!mounted) return;
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
        itemCount: _requests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final request = _requests[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Solicitud #${request.id}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      StatusChip(status: request.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (request.citizenName != null)
                    Text('${request.citizenName} • ${request.citizenPhone ?? ''}'),
                  if (request.address != null)
                    Text(request.address!.addressText),
                  const SizedBox(height: 8),
                  Text('Peso: ${request.estimatedWeight} kg'),
                  if (request.materials.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: request.materials
                            .map(
                              (m) => Chip(
                                label: Text('${m.materialName} (${m.quantity} kg)'),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  if (request.collector != null) ...[
                    const SizedBox(height: 8),
                    Text('Recolector: ${request.collector!.fullName}'),
                  ],
                  if (request.status == RequestStatus.pending) ...[
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => _assign(request.id),
                      child: const Text('Asignar recolector'),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
