class SignupParams {
  final String name;
  final String nickName;
  final String? password;
  final String email;
  final String university;
  final int academicYear;
  final String avatarKey;

  const SignupParams({
    required this.name,
    required this.nickName,
    this.password,
    required this.email,
    required this.university,
    required this.academicYear,
    required this.avatarKey,
  });
}
