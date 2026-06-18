class MaterialItem {
  const MaterialItem({
    required this.id,
    required this.name,
    required this.description,
    required this.active,
  });

  final int id;
  final String name;
  final String description;
  final bool active;

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      active: json['active'] as bool? ?? true,
    );
  }
}

class RequestMaterialLine {
  const RequestMaterialLine({
    required this.materialId,
    required this.materialName,
    required this.quantity,
  });

  final int materialId;
  final String materialName;
  final double quantity;

  factory RequestMaterialLine.fromJson(Map<String, dynamic> json) {
    return RequestMaterialLine(
      materialId: json['material_id'] as int,
      materialName: json['material_name'] as String,
      quantity: double.tryParse('${json['quantity']}') ?? 0,
    );
  }
}
