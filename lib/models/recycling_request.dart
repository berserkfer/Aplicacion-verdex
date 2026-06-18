import 'address.dart';
import 'material.dart';

enum RequestStatus {
  pending,
  assigned,
  inProgress,
  completed,
  unknown;

  static RequestStatus fromApi(String? value) {
    switch (value?.toUpperCase()) {
      case 'PENDING':
        return RequestStatus.pending;
      case 'ASSIGNED':
        return RequestStatus.assigned;
      case 'IN_PROGRESS':
        return RequestStatus.inProgress;
      case 'COMPLETED':
        return RequestStatus.completed;
      default:
        return RequestStatus.unknown;
    }
  }

  String get apiValue {
    switch (this) {
      case RequestStatus.pending:
        return 'PENDING';
      case RequestStatus.assigned:
        return 'ASSIGNED';
      case RequestStatus.inProgress:
        return 'IN_PROGRESS';
      case RequestStatus.completed:
        return 'COMPLETED';
      case RequestStatus.unknown:
        return 'PENDING';
    }
  }

  String get label {
    switch (this) {
      case RequestStatus.pending:
        return 'Pendiente';
      case RequestStatus.assigned:
        return 'Asignada';
      case RequestStatus.inProgress:
        return 'En progreso';
      case RequestStatus.completed:
        return 'Completada';
      case RequestStatus.unknown:
        return 'Desconocido';
    }
  }
}

class CollectorSummary {
  const CollectorSummary({
    required this.id,
    required this.fullName,
    this.phone,
    this.email,
    this.vehicleType,
    this.assignedZone,
  });

  final int id;
  final String fullName;
  final String? phone;
  final String? email;
  final String? vehicleType;
  final String? assignedZone;

  factory CollectorSummary.fromJson(Map<String, dynamic> json) {
    return CollectorSummary(
      id: json['id'] as int,
      fullName: (json['full_name'] ?? json['fullName'] ?? '') as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      vehicleType: json['vehicle_type'] as String? ?? json['vehicleType'] as String?,
      assignedZone: json['assigned_zone'] as String? ?? json['assignedZone'] as String?,
    );
  }
}

class RecyclingRequest {
  const RecyclingRequest({
    required this.id,
    required this.requestDate,
    required this.estimatedWeight,
    required this.status,
    this.comments,
    this.citizenName,
    this.citizenPhone,
    this.citizenEmail,
    this.address,
    this.materials = const [],
    this.collector,
  });

  final int id;
  final DateTime? requestDate;
  final double estimatedWeight;
  final RequestStatus status;
  final String? comments;
  final String? citizenName;
  final String? citizenPhone;
  final String? citizenEmail;
  final UserAddress? address;
  final List<RequestMaterialLine> materials;
  final CollectorSummary? collector;

  factory RecyclingRequest.fromJson(Map<String, dynamic> json) {
    final addressJson = json['address'];
    return RecyclingRequest(
      id: json['id'] as int,
      requestDate: json['request_date'] != null
          ? DateTime.tryParse(json['request_date'] as String)
          : json['requestDate'] != null
              ? DateTime.tryParse(json['requestDate'] as String)
              : null,
      estimatedWeight:
          double.tryParse('${json['estimated_weight'] ?? json['estimatedWeight']}') ?? 0,
      status: RequestStatus.fromApi(
        (json['status'] ?? json['request_status']) as String?,
      ),
      comments: json['comments'] as String?,
      citizenName: json['citizen_name'] as String?,
      citizenPhone: json['citizen_phone'] as String?,
      citizenEmail: json['citizen_email'] as String?,
      address: addressJson is Map<String, dynamic>
          ? UserAddress.fromJson(addressJson)
          : null,
      materials: (json['materials'] as List<dynamic>? ?? [])
          .map((e) => RequestMaterialLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      collector: json['collector'] is Map<String, dynamic>
          ? CollectorSummary.fromJson(json['collector'] as Map<String, dynamic>)
          : null,
    );
  }
}
