class DashboardStats {
  const DashboardStats({
    required this.totalRequests,
    required this.completedRequests,
    required this.pendingRequests,
    required this.inProgressRequests,
    required this.totalCollectors,
    required this.totalCitizens,
    required this.totalKgRecollected,
  });

  final int totalRequests;
  final int completedRequests;
  final int pendingRequests;
  final int inProgressRequests;
  final int totalCollectors;
  final int totalCitizens;
  final String totalKgRecollected;

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalRequests: json['total_requests'] as int? ?? 0,
      completedRequests: json['completed_requests'] as int? ?? 0,
      pendingRequests: json['pending_requests'] as int? ?? 0,
      inProgressRequests: json['in_progress_requests'] as int? ?? 0,
      totalCollectors: json['total_collectors'] as int? ?? 0,
      totalCitizens: json['total_citizens'] as int? ?? 0,
      totalKgRecollected: '${json['total_kg_recolected'] ?? '0'}',
    );
  }
}

class CollectorStats {
  const CollectorStats({
    required this.assignedTotal,
    required this.inProgress,
    required this.completed,
  });

  final int assignedTotal;
  final int inProgress;
  final int completed;

  factory CollectorStats.fromJson(Map<String, dynamic> json) {
    return CollectorStats(
      assignedTotal: json['assigned_total'] as int? ?? 0,
      inProgress: json['in_progress'] as int? ?? 0,
      completed: json['completed'] as int? ?? 0,
    );
  }
}
