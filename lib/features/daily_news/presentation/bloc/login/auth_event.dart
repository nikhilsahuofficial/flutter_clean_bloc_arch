import 'package:equatable/equatable.dart';

/// Abstract base class for authentication events.
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event indicating a login request with email and password.
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  /// Constructs an [AuthLoginRequested] event with the provided [email] and [password].
  AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Event indicating a logout request.
class AuthLogoutRequested extends AuthEvent {}

/// Event indicating a check authentication status request.
class AuthCheckRequested extends AuthEvent {}
