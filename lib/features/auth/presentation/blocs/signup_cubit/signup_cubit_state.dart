import 'package:equatable/equatable.dart';

class SignupCubitState extends Equatable {
  final String email;
  final String? password;
  final String name;
  final String nickName;
  final String universityName;
  final int academicYear;
  final String avatarKey;

  const SignupCubitState({
    this.email = '',
    this.password,
    this.name = '',
    this.nickName = '',
    this.universityName = '',
    this.academicYear = 1,
    this.avatarKey = '',
  });

  SignupCubitState copyWith({
    String? email,
    String? password,
    String? name,
    String? nickName,
    String? universityName,
    int? academicYear,
    String? avatarKey,
  }) {
    return SignupCubitState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      universityName: universityName ?? this.universityName,
      academicYear: academicYear ?? this.academicYear,
      avatarKey: avatarKey ?? this.avatarKey,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    name,
    nickName,
    universityName,
    academicYear,
    avatarKey,
  ];
}
