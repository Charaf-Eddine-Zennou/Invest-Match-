import '../models/user_profile_model.dart';

extension UserProfileX on UserProfile {
  bool get isInvestor => profileType.toLowerCase() == 'investisseur';
  bool get isCompany => profileType.toLowerCase() == 'entreprise';

  String get displayName {
    final name = '$firstName $lastName'.trim();
    if (companyName != null && companyName!.trim().isNotEmpty) return companyName!;
    if (name.isNotEmpty) return name;
    return username;
  }

  String? get avatar => (profileImage.isNotEmpty) ? profileImage : null;

  // Domaine/site
  String? get websiteUrl {
    if (domain == null || domain!.trim().isEmpty) return null;
    final d = domain!.trim();
    if (d.startsWith('http')) return d;
    return 'https://$d';
  }
}
