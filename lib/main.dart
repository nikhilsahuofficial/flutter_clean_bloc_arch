import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'features/daily_news/presentation/bloc/article/remote_article_bloc.dart';
import 'features/daily_news/presentation/bloc/article/remote_article_event.dart';
import 'features/daily_news/presentation/bloc/login/auth_bloc.dart';
import 'features/daily_news/presentation/bloc/login/auth_event.dart';
import 'features/daily_news/presentation/bloc/login/auth_state.dart';
import 'features/daily_news/presentation/pages/home/daily_news.dart';
import 'features/daily_news/presentation/pages/login/login.dart';
import 'features/daily_news/presentation/pages/splash_screen/splash_screen.dart';
import 'injection_container.dart';

/// Entry point of the application.
Future<void> main() async {
  // Load environment variables from .env file
  await dotenv.load(fileName: '.env');

  // Ensure that Flutter widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies using dependency injection
  await initializeDependencies();

  try {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Configure Flutter error handling with Firebase Crashlytics
    const fatalError = true; // Set to true to treat errors as fatal
    FlutterError.onError = (details) {
      if (fatalError) {
        FirebaseCrashlytics.instance.recordFlutterError(details);
      }
    };

    // Handle asynchronous errors with Firebase Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      if (fatalError) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
      return true;
    };
  } catch (e, stackTrace) {
    // Handle initialization errors and log them
    print('Firebase initialization error: $e');
    FirebaseCrashlytics.instance.recordError(e, stackTrace);
  }

  // Run the application
  runApp(MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide the RemoteArticlesBloc for managing remote article data
        BlocProvider<RemoteArticlesBloc>(
          create: (context) =>
              sl<RemoteArticlesBloc>()..add(const GetArticles()),
        ),
        // Provide the AuthBloc for managing authentication state
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(FirebaseAuth.instance, FirebaseAnalytics.instance)
                ..add(AuthCheckRequested()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        // Set the theme of the application
        title: 'Daily News',
        // Set the title of the application
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        // Define route generation logic
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // Handle different authentication states to determine initial screen
            if (state is AuthLoading) {
              return SplashScreen(); // Show splash screen while checking authentication
            } else if (state is AuthAuthenticated) {
              return DailyNews(); // Navigate to home screen if authenticated
            } else {
              return LoginScreen(); // Show login screen if not authenticated
            }
          },
        ),
      ),
    );
  }
}
