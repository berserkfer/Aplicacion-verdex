import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/material.dart' as models;
import '../../models/address.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key});

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  bool _loading = true;
  bool _submitting = false;
  List<models.MaterialItem> _materials = [];
  List<UserAddress> _addresses = [];
  UserAddress? _selectedAddress;
  final _weightController = TextEditingController(text: '2');
  final _commentsController = TextEditingController();
  final Map<int, TextEditingController> _quantityControllers = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _commentsController.dispose();
    for (final controller in _quantityControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final api = context.read<AuthProvider>().api;
      final materials = await api.getMaterials(onlyActive: true);
      final addresses = await api.getAddresses();
      for (final material in materials) {
        _quantityControllers[material.id] = TextEditingController(text: '0');
      }
      if (!mounted) return;
      setState(() {
        _materials = materials;
        _addresses = addresses;
        _selectedAddress = addresses.isNotEmpty ? addresses.first : null;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showAppSnack(context, e.message, error: true);
    }
  }

  Future<void> _createAddress() async {
    final aliasController = TextEditingController();
    final addressController = TextEditingController();
    final latController = TextEditingController(text: '-6.7714');
    final lngController = TextEditingController(text: '-79.8410');

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva dirección'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: aliasController,
                decoration: const InputDecoration(labelText: 'Alias'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Dirección'),
              ),
              TextField(
                controller: latController,
                decoration: const InputDecoration(labelText: 'Latitud'),
              ),
              TextField(
                controller: lngController,
                decoration: const InputDecoration(labelText: 'Longitud'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (saved != true || !mounted) return;

    try {
      final api = context.read<AuthProvider>().api;
      final address = await api.createAddress(
        alias: aliasController.text.trim(),
        addressText: addressController.text.trim(),
        latitude: double.parse(latController.text.trim()),
        longitude: double.parse(lngController.text.trim()),
      );
      setState(() {
        _addresses = [..._addresses, address];
        _selectedAddress = address;
      });
      if (!mounted) return;
      showAppSnack(context, 'Dirección creada');
    } on ApiException catch (e) {
      if (!mounted) return;
      showAppSnack(context, e.message, error: true);
    }
  }

  Future<void> _submit() async {
    if (_selectedAddress == null) {
      showAppSnack(context, 'Agrega una dirección primero', error: true);
      return;
    }

    final selectedMaterials = <Map<String, dynamic>>[];
    for (final material in _materials) {
      final qty = double.tryParse(
            _quantityControllers[material.id]?.text ?? '0',
          ) ??
          0;
      if (qty > 0) {
        selectedMaterials.add({
          'material_id': material.id,
          'quantity': qty,
        });
      }
    }

    if (selectedMaterials.isEmpty) {
      showAppSnack(context, 'Selecciona al menos un material', error: true);
      return;
    }

    setState(() => _submitting = true);
    try {
      final api = context.read<AuthProvider>().api;
      await api.createRequest(
        addressId: _selectedAddress!.id,
        estimatedWeight: double.parse(_weightController.text.trim()),
        comments: _commentsController.text.trim().isEmpty
            ? null
            : _commentsController.text.trim(),
        materials: selectedMaterials,
      );
      if (!mounted) return;
      showAppSnack(context, 'Solicitud creada exitosamente');
      Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (!mounted) return;
      showAppSnack(context, e.message, error: true);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva solicitud')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Dirección de recojo',
                          border: OutlineInputBorder(),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<UserAddress>(
                            value: _selectedAddress,
                            isExpanded: true,
                            hint: const Text('Selecciona una dirección'),
                            items: _addresses
                                .map(
                                  (a) => DropdownMenuItem(
                                    value: a,
                                    child: Text('${a.alias} — ${a.addressText}'),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _selectedAddress = value),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _createAddress,
                      icon: const Icon(Icons.add_location_alt),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso estimado (kg)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _commentsController,
                  decoration: const InputDecoration(
                    labelText: 'Comentarios (opcional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                Text(
                  'Materiales a reciclar',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ..._materials.map((material) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  material.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(material.description),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: TextField(
                              controller: _quantityControllers[material.id],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Kg',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _submitting ? null : _submit,
                  child: _submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Enviar solicitud'),
                ),
              ],
            ),
    );
  }
}
