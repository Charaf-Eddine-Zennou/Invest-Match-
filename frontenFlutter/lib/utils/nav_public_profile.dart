import 'package:flutter/material.dart';
import 'package:nebula_app/models/user_profile_model.dart';
import 'package:nebula_app/main.dart' show pushPeerSlide;
import 'package:nebula_app/utils/user_helpers.dart';
import 'package:nebula_app/screens/public_profile/company_public_profile_screen.dart';
import 'package:nebula_app/screens/public_profile/user_public_profile_screen.dart';

void openPublicProfile(BuildContext context, UserProfile profile, {bool root = false}) {
  final page = profile.isCompany
      ? CompanyPublicProfileScreen(profile: profile)
      : UserPublicProfileScreen(profile: profile);
  pushPeerSlide(context, page, rootNavigator: root);
}
