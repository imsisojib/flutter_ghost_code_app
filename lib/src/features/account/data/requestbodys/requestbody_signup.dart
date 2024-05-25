class RequestBodySignup {
  String firstName;
  String lastName;
  String email;
  String password;

  RequestBodySignup({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'RequestBodySignup{firstName: $firstName, lastName: $lastName, email: $email, password: $password}';
  }
}
