import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/material.dart' as models;
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  bool _loading = true;
  var _materials = const <models.MaterialItem>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final api = context.read<AuthProvider>().api;
      final materials = await api.getMaterials();
      if (!mounted) return;
      setState(() {
        _materials = materials;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showAppSnack(context, e.message, error: true);
    }
  }

  Future<void> _toggleActive(models.MaterialItem material) async {
    try {
      final api = context.read<AuthProvider>().api;
      await api.updateMaterial(material.id, active: !material.active);
      if (!mounted) return;
      showAppSnack(context, 'Material actualizado');
      _load();
    } on ApiException catch (e) {
      if (!mounted) return;
      showAppSnack(context, e.message, error: true);
    }
  }

  Future<void> createMaterial(BuildContext context) async {
    final api = context.read<AuthProvider>().api;
    final messenger = ScaffoldMessenger.of(context);
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo material'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Crear'),
          ),
        ],
      ),
    );

    if (saved != true) return;

    try {
      await api.createMaterial(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
      );
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Material creado'),
          backgroundColor: AppTheme.primaryGreen,
        ),
      );
      _load();
    } on ApiException catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () => createMaterial(context),
              icon: const Icon(Icons.add),
              label: const Text('Nuevo material'),
            ),
          ),
          const SizedBox(height: 12),
          ..._materials.map(
            (material) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: SwitchListTile(
                  title: Text(material.name),
                  subtitle: Text(material.description),
                  value: material.active,
                  onChanged: (_) => _toggleActive(material),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
