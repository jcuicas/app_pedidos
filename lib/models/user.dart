// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String fullName;
  final String userEmail;

  User({
    required this.id,
    required this.fullName,
    required this.userEmail,
  });

  Map toJson() => {
        'id': id,
        'full_name': fullName,
        'email': userEmail,
      };
}
