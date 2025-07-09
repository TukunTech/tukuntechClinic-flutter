class RegisterDTO {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;

  RegisterDTO({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
  };
}
