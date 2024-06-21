/// This screen displays a login interface allowing users to enter their email
/// and password to authenticate using Firebase Authentication. It utilizes
/// Flutter's Bloc pattern for state management.
///
/// The [LoginScreen] class is a [StatelessWidget] that initializes an [AuthBloc]
/// to handle authentication events and states. Upon successful authentication,
/// users are navigated to the '/DailyNews' route.
///
/// Dependencies:
///   - firebase_analytics: ^x.x.x
///   - flutter_bloc: ^x.x.x
///   - firebase_auth: ^x.x.x
///
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/auth_bloc.dart';
import '../../bloc/login/auth_event.dart';
import '../../bloc/login/auth_state.dart';

/// The login screen widget responsible for displaying the UI for user login.
class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// Constructor for the [LoginScreen] widget.
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        // Provide the AuthBloc with Firebase services for authentication and analytics.
        create: (context) =>
            AuthBloc(FirebaseAuth.instance, FirebaseAnalytics.instance),
        child: _buildBody(context),
      ),
    );
  }

  /// Builds the main body of the login screen UI.
  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 40),
            _buildLoginButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Widget for displaying the title 'Welcome Back!' on the screen.
  Widget _buildTitle() {
    return const Text(
      'Welcome Back!',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  /// Widget for displaying the email input field.
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  /// Widget for displaying the password input field.
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.lock),
      ),
      obscureText: true,
    );
  }

  /// Widget for displaying the login button.
  Widget _buildLoginButton(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushNamed(context, '/DailyNews');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final email = _emailController.text;
              final password = _passwordController.text;
              context.read<AuthBloc>().add(AuthLoginRequested(
                    email: email,
                    password: password,
                  ));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Login'),
          ),
        );
      },
    );
  }
}
