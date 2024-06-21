import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Abstract base class for authentication states.
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state indicating the authentication state has not been determined yet.
class AuthInitial extends AuthState {}

/// State indicating that authentication process is in progress.
class AuthLoading extends AuthState {}

/// State indicating that the user has been successfully authenticated.
class AuthAuthenticated extends AuthState {
  /// The authenticated user.
  final User user;

  /// Constructs an [AuthAuthenticated] state with the authenticated [user].
  AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// State indicating that the user is not authenticated.
class AuthUnauthenticated extends AuthState {}

/// State indicating that an error occurred during the authentication process.
class AuthError extends AuthState {
  /// The error message describing the authentication error.
  final String error;

  /// Constructs an [AuthError] state with the provided [error] message.
  AuthError({required this.error});

  @override
  List<Object?> get props => [error];
}
