enum UserRole {
  citizen,
  collector,
  operator,
  unknown;

  static UserRole fromApi(String? value) {
    switch (value?.toUpperCase()) {
      case 'CITIZEN':
        return UserRole.citizen;
      case 'COLLECTOR':
        return UserRole.collector;
      case 'OPERATOR':
        return UserRole.operator;
      default:
        return UserRole.unknown;
    }
  }

  String get apiValue => name.toUpperCase();

  String get label {
    switch (this) {
      case UserRole.citizen:
        return 'Ciudadano';
      case UserRole.collector:
        return 'Recolector';
      case UserRole.operator:
        return 'Operador municipal';
      case UserRole.unknown:
        return 'Usuario';
    }
  }
}

class User {
  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.dni,
    this.phone,
    this.vehicleType,
    this.assignedZone,
    this.active = true,
  });

  final int id;
  final String fullName;
  final String email;
  final UserRole role;
  final String? dni;
  final String? phone;
  final String? vehicleType;
  final String? assignedZone;
  final bool active;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      fullName: (json['fullName'] ?? json['full_name'] ?? '') as String,
      email: json['email'] as String,
      role: UserRole.fromApi(json['role'] as String?),
      dni: json['dni'] as String?,
      phone: json['phone'] as String?,
      vehicleType: json['vehicleType'] as String?,
      assignedZone: json['assignedZone'] as String?,
      active: json['active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'role': role.apiValue,
      'dni': dni,
      'phone': phone,
      'vehicleType': vehicleType,
      'assignedZone': assignedZone,
      'active': active,
    };
  }
}
