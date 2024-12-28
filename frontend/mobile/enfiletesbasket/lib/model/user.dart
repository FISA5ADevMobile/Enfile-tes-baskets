
// Modèle pour représenter un utilisateur
class User {
  final int id;
  final String pseudo;
  final String email;
  final bool isAdmin;

  User({
    required this.id,
    required this.pseudo,
    required this.email,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      pseudo: json['pseudo'],
      email: json['email'],
      isAdmin: json['isAdmin'],
    );
  }
}