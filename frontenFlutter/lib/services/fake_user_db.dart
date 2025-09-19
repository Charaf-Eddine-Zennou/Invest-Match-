import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile_model.dart';


class FakeUserService {
  static final FakeUserService _instance = FakeUserService._internal();
  factory FakeUserService() => _instance;
  FakeUserService._internal();

  List<UserProfile> _users = [];
  UserProfile? _currentUser;

  // Récupère le fichier local
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/users.json');
  }

  Future<UserProfile?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    if (email == null) return null;
    await loadUsers();
    try {
      return _users.firstWhere((u) => u.email == email);
    } catch (_) {
      return null;
    }
  }


  Future<File> _getDbFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/users.json');
  }

  // Reset complet : vide la liste
  Future<void> resetDB() async {
    _users.clear();
    final file = await _getDbFile();
    await file.writeAsString('[]');
  }

  // Export : renvoie le fichier JSON de la DB locale
  Future<File?> exportDB() async {
    final file = await _getDbFile();
    if (await file.exists()) {
      return file;
    }
    if (_users.isNotEmpty) {
      final jsonString = jsonEncode(_users.map((u) => u.toJson()).toList());
      await file.writeAsString(jsonString);
      return file;
    }
    return null;
  }

  Future<void> importDB(File file) async {
    final jsonString = await file.readAsString();
    final decoded = jsonDecode(jsonString);
    if (decoded is! List) throw Exception("Fichier mal formé (pas une liste)");
    _users = decoded.map<UserProfile>((u) => UserProfile.fromJson(u)).toList();
    await saveUsers();
  }

  Future<void> saveUsers() async {
    final dbFile = await _getDbFile();
    await dbFile.writeAsString(jsonEncode(_users.map((u) => u.toJson()).toList()));
  }

  Future<List<UserProfile>> getAllUsers() async {
    await loadUsers();
    return _users;
  }

  // Charge les users en mémoire
  Future<void> loadUsers() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        _users = [];
        return;
      }
      final content = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(content);
      _users = jsonList.map((e) => UserProfile.fromJson(e)).toList();
    } catch (_) {
      _users = [];
    }
  }

  // Sauvegarde la liste des users
  Future<void> _saveToFile() async {
    final file = await _localFile;
    final jsonList = _users.map((u) => u.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  // Ajout utilisateur
  Future<void> addUser(UserProfile user) async {
    await loadUsers();
    _users.add(user);
    await _saveToFile();
  }

  // Authentification
  Future<UserProfile?> login(String email, String password) async {
    await loadUsers();
    UserProfile? user;
    try {
      user = _users.firstWhere((u) => u.email == email && u.password == password);
    } catch (_) {
      user = null;
    }
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      _currentUser = user;
      return user;
    }
    return null;
  }



  // Cherche user par email
  Future<UserProfile?> findByEmail(String email) async {
    await loadUsers();
    try {
      return _users.firstWhere((u) => u.email == email);
    } catch (_) {
      return null;
    }
  }

  // User courant
  UserProfile? get currentUser => _currentUser;

  // Déconnexion
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  // Suppression utilisateur
  Future<void> deleteUser(String email) async {
    await loadUsers();
    _users.removeWhere((u) => u.email == email);
    await _saveToFile();
  }
}
