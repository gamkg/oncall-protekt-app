enum OfficerStatus { available, onDuty, offline }

class PreferredOfficer {
  final String id;
  final String name;
  final String rank;
  final double rating;
  final int jobCount;
  final OfficerStatus status;

  const PreferredOfficer({
    required this.id,
    required this.name,
    required this.rank,
    required this.rating,
    required this.jobCount,
    required this.status,
  });

  factory PreferredOfficer.fromJson(Map<String, dynamic> json) {
    return PreferredOfficer(
      id: json['id'] as String,
      name: json['name'] as String,
      rank: json['rank'] as String,
      rating: (json['rating'] as num).toDouble(),
      jobCount: json['jobCount'] as int,
      status: OfficerStatus.values.byName(json['status'] as String),
    );
  }

  String get initials => name
      .split(' ')
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase())
      .join();
}
