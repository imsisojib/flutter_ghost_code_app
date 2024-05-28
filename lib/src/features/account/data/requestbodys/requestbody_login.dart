class RequestBodyLogin {
  String email;
  String password;

  RequestBodyLogin({
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'RequestBodyLogin{email: $email, password: $password}';
  }
}
