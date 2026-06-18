import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/recycling_request.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  bool _loading = true;
  List<RecyclingRequest> _requests = [];

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
        _requests = requests;
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

    if (_requests.isEmpty) {
      return RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          children: const [
            SizedBox(height: 120),
            Icon(Icons.inbox_outlined, size: 64, color: Colors.black26),
            SizedBox(height: 12),
            Center(child: Text('Aún no tienes solicitudes')),
          ],
        ),
      );
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
                  Text(formatRequestDate(request.requestDate)),
                  if (request.address != null) ...[
                    const SizedBox(height: 8),
                    Text(request.address!.addressText),
                  ],
                  const SizedBox(height: 8),
                  Text('Peso estimado: ${request.estimatedWeight} kg'),
                  if (request.materials.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
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
                  ],
                  if (request.collector != null) ...[
                    const SizedBox(height: 8),
                    Text('Recolector: ${request.collector!.fullName}'),
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
