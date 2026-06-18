class Collector {
  const Collector({
    required this.id,
    required this.fullName,
    required this.email,
    this.dni,
    this.phone,
    this.vehicleType,
    this.assignedZone,
    this.active = true,
    this.assignedCount = 0,
    this.completedCount = 0,
    this.pendingCount = 0,
  });

  final int id;
  final String fullName;
  final String email;
  final String? dni;
  final String? phone;
  final String? vehicleType;
  final String? assignedZone;
  final bool active;
  final int assignedCount;
  final int completedCount;
  final int pendingCount;

  factory Collector.fromJson(Map<String, dynamic> json) {
    return Collector(
      id: json['id'] as int,
      fullName: (json['fullName'] ?? json['full_name'] ?? '') as String,
      email: json['email'] as String,
      dni: json['dni'] as String?,
      phone: json['phone'] as String?,
      vehicleType: json['vehicleType'] as String?,
      assignedZone: json['assignedZone'] as String?,
      active: json['active'] as bool? ?? true,
      assignedCount: json['assigned_count'] as int? ?? 0,
      completedCount: json['completed_count'] as int? ?? 0,
      pendingCount: json['pending_count'] as int? ?? 0,
    );
  }
}
