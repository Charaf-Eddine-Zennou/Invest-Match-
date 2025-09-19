import 'package:nebula_app/models/user_profile_model.dart';

final greenFuture = UserProfile(
  id: 'c_gfs',
  username: 'greenfuture',
  email: 'greenfuture@demo.local',
  password: 'demo',
  firstName: 'Green', lastName: 'Future',
  birthDate: DateTime(2000,1,1),
  gender: 'N/A', phone: '',
  profileType: 'entreprise',
  investorLevel: null,
  sectors: const ['Énergie', 'Climat', 'IA'],
  companyName: 'Green Future Solutions',
  siret: '123 456 789 00012',
  address: 'Paris',
  domain: 'greenfuture.solutions',
  notificationsEnabled: true,
  bio: 'Pionniers des énergies renouvelables ⚡️🌱',
  profileImage: 'https://i.pravatar.cc/150?img=32',
  followers: 12400, following: 73, isVerified: true,
);
