import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/recycling_request.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';

class MyAssignedRequestsScreen extends StatefulWidget {
  const MyAssignedRequestsScreen({super.key});

  @override
  State<MyAssignedRequestsScreen> createState() =>
      _MyAssignedRequestsScreenState();
}

class _MyAssignedRequestsScreenState extends State<MyAssignedRequestsScreen> {
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

  Future<void> _updateStatus(int requestId, RequestStatus status) async {
    try {
      final api = context.read<AuthProvider>().api;
      await api.updateRequestStatus(
        requestId: requestId,
        status: status.apiValue,
      );
      if (!mounted) return;
      showAppSnack(context, 'Estado actualizado');
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

    if (_requests.isEmpty) {
      return RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          children: const [
            SizedBox(height: 120),
            Icon(Icons.assignment_outlined, size: 64, color: Colors.black26),
            SizedBox(height: 12),
            Center(child: Text('No tienes solicitudes asignadas')),
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
                  if (request.citizenName != null)
                    Text('Ciudadano: ${request.citizenName}'),
                  if (request.address != null)
                    Text(request.address!.addressText),
                  const SizedBox(height: 8),
                  Text('Peso: ${request.estimatedWeight} kg'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      if (request.status == RequestStatus.assigned)
                        FilledButton(
                          onPressed: () =>
                              _updateStatus(request.id, RequestStatus.inProgress),
                          child: const Text('Iniciar recojo'),
                        ),
                      if (request.status == RequestStatus.inProgress)
                        FilledButton(
                          onPressed: () =>
                              _updateStatus(request.id, RequestStatus.completed),
                          child: const Text('Marcar completada'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
