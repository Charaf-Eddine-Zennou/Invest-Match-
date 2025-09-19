class CompanyProfile {
  final String name;
  final String handle;
  final String description;
  final String profileImage;
  final String bannerImage;
  final int followers;
  final int publications;
  final double investmentProgress; // entre 0.0 et 1.0
  final String investmentAmount;   // ex: "250000"
  final String? websiteUrl;
  final String? linkedinUrl;

  CompanyProfile({
    required this.name,
    required this.handle,
    required this.description,
    required this.profileImage,
    required this.bannerImage,
    required this.followers,
    required this.publications,
    required this.investmentProgress,
    required this.investmentAmount,
    this.websiteUrl,
    this.linkedinUrl,
  });
}
