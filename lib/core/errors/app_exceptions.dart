/// Thrown when the auth call reports success but returns no user,
/// or the credentials are rejected. Nothing upstream can recover from it.
class InvalidCredentialsException implements Exception {
  const InvalidCredentialsException();

  @override
  String toString() => 'InvalidCredentialsException';
}

/// Thrown when auth succeeds but there is no matching row in `public.users`.
/// Carries the id so the log tells you *which* user is missing a profile.
class ProfileMissingException implements Exception {
  final String userId;

  const ProfileMissingException(this.userId);

  @override
  String toString() => 'ProfileMissingException(userId: $userId)';
}

/// Thrown when sign up returns without a user.
class AuthSignUpFailedException implements Exception {
  const AuthSignUpFailedException();

  @override
  String toString() => 'AuthSignUpFailedException';
}

/// Thrown when a session is required but email confirmation is still pending.
/// This is not a failure of the provider — it is a state the UI must handle.
class EmailConfirmationRequiredException implements Exception {
  const EmailConfirmationRequiredException();

  @override
  String toString() => 'EmailConfirmationRequiredException';
}
