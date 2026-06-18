import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_widgets.dart';

class CreateCollectorScreen extends StatefulWidget {
  const CreateCollectorScreen({super.key});

  @override
  State<CreateCollectorScreen> createState() => _CreateCollectorScreenState();
}

class _CreateCollectorScreenState extends State<CreateCollectorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dniController = TextEditingController();
  final _phoneController = TextEditingController();
  String _vehicleType = 'MOTO';
  String _zone = 'CENTRO';
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dniController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      final api = context.read<AuthProvider>().api;
      await api.createCollector(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        dni: _dniController.text.trim(),
        phone: _phoneController.text.trim(),
        vehicleType: _vehicleType,
        assignedZone: _zone,
      );
      if (!mounted) return;
      showAppSnack(context, 'Recolector creado exitosamente');
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
      appBar: AppBar(title: const Text('Crear recolector')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dniController,
                decoration: const InputDecoration(
                  labelText: 'DNI',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Vehículo',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _vehicleType,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'MOTO', child: Text('Moto')),
                      DropdownMenuItem(
                        value: 'CAMIONETA',
                        child: Text('Camioneta'),
                      ),
                      DropdownMenuItem(value: 'CAMION', child: Text('Camión')),
                    ],
                    onChanged: (v) => setState(() => _vehicleType = v ?? 'MOTO'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Zona asignada',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _zone,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'CENTRO', child: Text('Centro')),
                      DropdownMenuItem(value: 'NORTE', child: Text('Norte')),
                      DropdownMenuItem(value: 'SUR', child: Text('Sur')),
                      DropdownMenuItem(value: 'ESTE', child: Text('Este')),
                    ],
                    onChanged: (v) => setState(() => _zone = v ?? 'CENTRO'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Crear recolector'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
