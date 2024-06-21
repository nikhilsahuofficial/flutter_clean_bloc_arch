import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC for handling authentication related events and states.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAnalytics _firebaseAnalytics;

  /// Constructs an [AuthBloc] with [FirebaseAuth] and [FirebaseAnalytics] instances.
  AuthBloc(this._firebaseAuth, this._firebaseAnalytics) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onCheckRequested);
  }

  /// Handles the login requested event.
  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Logging user ID and timing to Firebase Analytics
      final startTime = DateTime.now();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime).inMilliseconds;
      final user = userCredential.user!;
      final userId = user.uid;

      await _firebaseAnalytics.logEvent(
        name: 'login',
        parameters: {
          'user_id': userId,
          'duration': duration,
        },
      );
      await _firebaseAnalytics.setUserId(id: userId);

      emit(AuthAuthenticated(user: userCredential.user!));
    } catch (e) {
      emit(AuthError(error: e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  /// Handles the logout requested event.
  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    emit(AuthUnauthenticated());
  }

  /// Handles the check authentication requested event.
  Future<void> _onCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
