/// Punto de reciclaje en Chiclayo.
class RecyclingPoint {
  const RecyclingPoint({
    required this.name,
    required this.address,
    required this.recyclingType,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final String address;
  final String recyclingType;
  final double latitude;
  final double longitude;
}
