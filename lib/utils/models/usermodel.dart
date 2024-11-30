class Usermodel {
  final String username;
  final String email;
  final String phonenumber;
  final String userid;
  final List<String> completed;
  Usermodel({
    required this.username,
    required this.email,
    required this.phonenumber,
    required this.userid,
    required this.completed,
  });
  toJSON() {
    return {
      "userid": userid,
      "username": username,
      "email": email,
      "phone number": phonenumber.toString(),
      "completed": completed
    };
  }
}
