enum JobStatus { completed, unserved, cancelled }

enum RiskLevel { critical, high, medium, low }

class Job {
  final String id;
  final String title;
  final String type;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final double rate;
  final JobStatus status;
  final RiskLevel risk;
  final int officerCount;
  final int officerRequired;

  const Job({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.rate,
    required this.status,
    required this.risk,
    required this.officerCount,
    required this.officerRequired,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      rate: (json['rate'] as num).toDouble(),
      status: JobStatus.values.byName(json['status'] as String),
      risk: RiskLevel.values.byName(json['risk'] as String),
      officerCount: json['officerCount'] as int,
      officerRequired: json['officerRequired'] as int,
    );
  }

  String get formattedRate => '\$${rate.toStringAsFixed(0)}/hr';

  String get formattedDateRange {
    final start = '${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}-${startDate.year}';
    final end = '${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}-${endDate.year}';
    return '$start to $end';
  }

  Duration get duration => endDate.difference(startDate);
  String get formattedDuration => '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')} hrs';
}
