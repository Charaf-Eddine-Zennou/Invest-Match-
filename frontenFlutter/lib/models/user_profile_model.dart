class UserProfile {
  final String id;
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final String phone;
  final String profileType; // "investisseur" ou "entreprise"
  final String? investorLevel; // null si entreprise
  final List<String> sectors; // [] si entreprise
  final String? companyName;
  final String? siret;
  final String? address;
  final String? domain;
  final bool notificationsEnabled;

  // Champs "profil social" avec valeurs par défaut
  final String bio;
  final String profileImage;
  final int followers;
  final int following;
  final bool isVerified;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.profileType,
    this.investorLevel,
    required this.sectors,
    this.companyName,
    this.siret,
    this.address,
    this.domain,
    required this.notificationsEnabled,
    this.bio = '',
    this.profileImage = '',
    this.followers = 0,
    this.following = 0,
    this.isVerified = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'birthDate': birthDate.toIso8601String(),
    'gender': gender,
    'phone': phone,
    'profileType': profileType,
    'investorLevel': investorLevel,
    'sectors': sectors,
    'companyName': companyName,
    'siret': siret,
    'address': address,
    'domain': domain,
    'notificationsEnabled': notificationsEnabled,
    'bio': bio,
    'profileImage': profileImage,
    'followers': followers,
    'following': following,
    'isVerified': isVerified,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json['id'],
    username: json['username'],
    email: json['email'],
    password: json['password'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    birthDate: DateTime.parse(json['birthDate']),
    gender: json['gender'],
    phone: json['phone'],
    profileType: json['profileType'],
    investorLevel: json['investorLevel'],
    sectors: List<String>.from(json['sectors'] ?? []),
    companyName: json['companyName'],
    siret: json['siret'],
    address: json['address'],
    domain: json['domain'],
    notificationsEnabled: json['notificationsEnabled'] ?? false,
    bio: json['bio'] ?? '',
    profileImage: json['profileImage'] ?? '',
    followers: json['followers'] ?? 0,
    following: json['following'] ?? 0,
    isVerified: json['isVerified'] ?? false,
  );
}
