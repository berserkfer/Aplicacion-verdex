class UserAddress {
  const UserAddress({
    required this.id,
    required this.alias,
    required this.addressText,
    required this.latitude,
    required this.longitude,
  });

  final int id;
  final String alias;
  final String addressText;
  final double latitude;
  final double longitude;

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'] as int,
      alias: json['alias'] as String? ?? '',
      addressText: (json['addressText'] ?? json['address_text'] ?? '') as String,
      latitude: double.tryParse('${json['latitude']}') ?? 0,
      longitude: double.tryParse('${json['longitude']}') ?? 0,
    );
  }
}
