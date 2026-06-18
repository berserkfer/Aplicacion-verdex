import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/address.dart';
import '../models/collector.dart';
import '../models/dashboard_stats.dart';
import '../models/material.dart';
import '../models/recycling_request.dart';
import '../models/user.dart';

class ApiException implements Exception {
  ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  String? _token;

  void setToken(String? token) => _token = token;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _decodeObject(response);
  }

  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'full_name': fullName,
        'email': email,
        'password': password,
        'role': role.apiValue,
      }),
    );
    return _decodeObject(response);
  }

  Future<List<MaterialItem>> getMaterials({bool onlyActive = false}) async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}/materials'),
      headers: _headers,
    );
    final list = _decodeList(response);
    final materials = list
        .map((e) => MaterialItem.fromJson(e as Map<String, dynamic>))
        .toList();
    if (onlyActive) {
      return materials.where((m) => m.active).toList();
    }
    return materials;
  }

  Future<MaterialItem> createMaterial({
    required String name,
    required String description,
    bool active = true,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/materials'),
      headers: _headers,
      body: jsonEncode({
        'name': name,
        'description': description,
        'active': active,
      }),
    );
    final data = _decodeObject(response);
    return MaterialItem.fromJson(data['material'] as Map<String, dynamic>);
  }

  Future<MaterialItem> updateMaterial(
    int id, {
    String? name,
    String? description,
    bool? active,
  }) async {
    final body = <String, dynamic>{};
    if (name != null) body['name'] = name;
    if (description != null) body['description'] = description;
    if (active != null) body['active'] = active;

    final response = await _client.put(
      Uri.parse('${ApiConfig.baseUrl}/materials/$id'),
      headers: _headers,
      body: jsonEncode(body),
    );
    final data = _decodeObject(response);
    return MaterialItem.fromJson(data['material'] as Map<String, dynamic>);
  }

  Future<List<UserAddress>> getAddresses() async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}/addresses'),
      headers: _headers,
    );
    return _decodeList(response)
        .map((e) => UserAddress.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<UserAddress> createAddress({
    required String alias,
    required String addressText,
    required double latitude,
    required double longitude,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/addresses'),
      headers: _headers,
      body: jsonEncode({
        'alias': alias,
        'address_text': addressText,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      }),
    );
    final data = _decodeObject(response);
    return UserAddress.fromJson(data['address'] as Map<String, dynamic>);
  }

  Future<List<RecyclingRequest>> getRequests() async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}/requests'),
      headers: _headers,
    );
    return _decodeList(response)
        .map((e) => RecyclingRequest.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<RecyclingRequest> createRequest({
    required int addressId,
    required double estimatedWeight,
    required List<Map<String, dynamic>> materials,
    String? comments,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/requests'),
      headers: _headers,
      body: jsonEncode({
        'address_id': addressId,
        'estimated_weight': estimatedWeight,
        'comments': comments,
        'materials': materials,
      }),
    );
    final data = _decodeObject(response);
    final requestJson = data['request'] as Map<String, dynamic>;
    return RecyclingRequest.fromJson({
      ...requestJson,
      'estimated_weight': requestJson['estimatedWeight'] ?? requestJson['estimated_weight'],
      'request_date': requestJson['requestDate'] ?? requestJson['request_date'],
    });
  }

  Future<void> assignRequest({
    required int requestId,
    required int collectorId,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/requests/$requestId/assign'),
      headers: _headers,
      body: jsonEncode({'collector_id': collectorId}),
    );
    _decodeObject(response);
  }

  Future<RecyclingRequest> updateRequestStatus({
    required int requestId,
    required String status,
  }) async {
    final response = await _client.put(
      Uri.parse('${ApiConfig.baseUrl}/requests/$requestId/status'),
      headers: _headers,
      body: jsonEncode({'status': status}),
    );
    final data = _decodeObject(response);
    return RecyclingRequest.fromJson(data['request'] as Map<String, dynamic>);
  }

  Future<DashboardStats> getDashboardStats() async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}/dashboard/stats'),
      headers: _headers,
    );
    return DashboardStats.fromJson(_decodeObject(response));
  }

  Future<CollectorStats> getCollectorStats() async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}/dashboard/collector/stats'),
      headers: _headers,
    );
    return CollectorStats.fromJson(_decodeObject(response));
  }

  Future<List<Collector>> getCollectors() async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}/users/collectors'),
      headers: _headers,
    );
    return _decodeList(response)
        .map((e) => Collector.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Collector> createCollector({
    required String fullName,
    required String email,
    required String password,
    required String dni,
    required String phone,
    required String vehicleType,
    required String assignedZone,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/users/collector'),
      headers: _headers,
      body: jsonEncode({
        'full_name': fullName,
        'email': email,
        'password': password,
        'dni': dni,
        'phone': phone,
        'vehicle_type': vehicleType,
        'assigned_zone': assignedZone,
      }),
    );
    final data = _decodeObject(response);
    return Collector.fromJson(data['collector'] as Map<String, dynamic>);
  }

  Map<String, dynamic> _decodeObject(http.Response response) {
    final body = response.body.isEmpty ? '{}' : response.body;
    final decoded = jsonDecode(body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded as Map<String, dynamic>;
    }
    throw ApiException(_extractError(decoded));
  }

  List<dynamic> _decodeList(http.Response response) {
    final body = response.body.isEmpty ? '[]' : response.body;
    final decoded = jsonDecode(body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded as List<dynamic>;
    }
    throw ApiException(_extractError(decoded));
  }

  String _extractError(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      if (decoded['message'] != null) return decoded['message'] as String;
      final errors = decoded['errors'];
      if (errors is List && errors.isNotEmpty) {
        final first = errors.first;
        if (first is Map && first['msg'] != null) {
          return first['msg'] as String;
        }
      }
    }
    return 'Error en la solicitud';
  }
}
