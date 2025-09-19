import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile profile;

  const ProfileHeader({required this.profile, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 42.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 78,
                  backgroundImage: AssetImage(profile.profileImage),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          profile.firstName,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (profile.isVerified)
                          const Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(Icons.verified, color: Colors.green, size: 20),
                          ),
                      ],
                    ),
                    Text('@${profile.username}', style: TextStyle(color: Colors.grey.shade600)),
                    Text('${profile.followers} abonnés  •  ${profile.following} suivis',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
              ],
            ),
        ),


        const SizedBox(height: 16),

        // Bio
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            profile.bio,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),


        const SizedBox(height: 16),

        // Bouton modifier
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Modifier le profil"),
          ),
        ),
      ],
    );
  }
}
