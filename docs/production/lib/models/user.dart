class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? avatarUrl;
  final int activeProtekts;
  final double trustScore;
  final double rating;
  final int totalJobs;
  final int completionRate;
  final String profileId;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.avatarUrl,
    required this.activeProtekts,
    required this.trustScore,
    required this.rating,
    required this.totalJobs,
    required this.completionRate,
    required this.profileId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      activeProtekts: json['activeProtekts'] as int,
      trustScore: (json['trustScore'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      totalJobs: json['totalJobs'] as int,
      completionRate: json['completionRate'] as int,
      profileId: json['profileId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'avatarUrl': avatarUrl,
        'activeProtekts': activeProtekts,
        'trustScore': trustScore,
        'rating': rating,
        'totalJobs': totalJobs,
        'completionRate': completionRate,
        'profileId': profileId,
      };
}
