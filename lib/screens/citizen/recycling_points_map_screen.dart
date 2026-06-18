import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../data/chiclayo_recycling_points.dart';
import '../../models/recycling_point.dart';
import '../../widgets/common_widgets.dart';

class RecyclingPointsMapScreen extends StatefulWidget {
  const RecyclingPointsMapScreen({super.key});

  @override
  State<RecyclingPointsMapScreen> createState() =>
      _RecyclingPointsMapScreenState();
}

class _RecyclingPointsMapScreenState extends State<RecyclingPointsMapScreen> {
  final _mapController = MapController();
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _locateUser();
  }

  Future<void> _locateUser() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
      _mapController.move(_userLocation!, 14);
    } catch (_) {
      if (!mounted) return;
      showAppSnack(
        context,
        'No se pudo obtener tu ubicación',
        error: true,
      );
    }
  }

  void _showPointDetails(RecyclingPoint point) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              point.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(point.address),
            const SizedBox(height: 8),
            Text(point.recyclingType),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final center = _userLocation ??
        const LatLng(chiclayoCenterLat, chiclayoCenterLng);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Text(
            'Lleva tus materiales reciclables a estos puntos de acopio autorizados en Chiclayo - Lambayeque.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: 13,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.verdex',
                  ),
                  MarkerLayer(
                    markers: [
                      ...chiclayoRecyclingPoints.map(
                        (point) => Marker(
                          point: LatLng(point.latitude, point.longitude),
                          width: 42,
                          height: 42,
                          child: GestureDetector(
                            onTap: () => _showPointDetails(point),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.green,
                              size: 42,
                            ),
                          ),
                        ),
                      ),
                      if (_userLocation != null)
                        Marker(
                          point: _userLocation!,
                          width: 36,
                          height: 36,
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.blue,
                            size: 36,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: FilledButton.icon(
            onPressed: _locateUser,
            icon: const Icon(Icons.my_location),
            label: const Text('Usar mi ubicación'),
          ),
        ),
      ],
    );
  }
}
