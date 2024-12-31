import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:provider/provider.dart';
import 'package:test_project/LandingPage/home_page_widget.dart';

import 'package:test_project/app_state.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/dashboard/gamePage/eventsPage/firstTutorial/first_tutorial_widget.dart';
import 'package:test_project/dashboard/loadgame/loadgame_widget.dart';
import 'package:test_project/dashboard/options/options_widget.dart';
import 'package:test_project/dashboard/gamePage/eventsAnimation/startinSequence/starting_sequence_widget.dart';
import 'package:test_project/dashboard/gamePage/gamePage/game_platform_widget.dart';
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';
import 'package:test_project/logginPages/Forgor/forgot/forgot_password_widget.dart';
import 'package:test_project/logginPages/Forgor/recover/recover_password_widget.dart';
import 'package:test_project/logginPages/Login/login_widget.dart';
import 'package:test_project/logginPages/Register/continue/create_account_widget.dart';
import 'package:test_project/logginPages/Register/enterEmail/register_widget.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:test_project/policy/cookies.dart';
import 'package:test_project/policy/privacy_policy.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  await FlutterFlowTheme.initialize();

  setUrlStrategy(PathUrlStrategy());

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;
  
  final GoRouter _router = GoRouter(
    routes: [
    //Landing Page
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: HomePageWidget(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 250),
                child: child,
              ).buildTransitions(context, animation, secondaryAnimation, child);
            },
          );
        },
      ),
      //gdpr
      GoRoute(
        path: '/privacy_policy',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: PrivacyPolicyPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 250),
                child: child,
              ).buildTransitions(context, animation, secondaryAnimation, child);
            },
          );
        },
      ),
      GoRoute(
        path: '/cookies',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: CookiesPolicyPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 250),
                child: child,
              ).buildTransitions(context, animation, secondaryAnimation, child);
            },
          );
        },
      ),

      //Login + Register + Create Account
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginWidget(),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: RegisterWidget(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 250),
                child: child,
              ).buildTransitions(context, animation, secondaryAnimation, child);
            },
          );
        },
      ),
      GoRoute(
        path: '/createAccount',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final userEmail = extra?['userEmail'] as String?;
          return CreateAccountWidget(userEmail: userEmail);
        },
      ),
      GoRoute(
        path: '/forgotPassword',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: RegisterWidget(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 250),
                child: child,
              ).buildTransitions(context, animation, secondaryAnimation, child);
            },
          );
        },
      ),
      GoRoute(
        path: '/recoverPassword',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final userEmail = extra?['userEmail'] as String?;
          return RecoverPasswordWidget(userEmail: userEmail);
        },
      ),

      //DashBoard
      GoRoute(
        path: '/dashboard',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: LoadgameWidget(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 250),
                child: child,
              ).buildTransitions(context, animation, secondaryAnimation, child);
            },
          );
        },
      ),
      GoRoute(
        path: '/dashboard/options',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: OptionsWidget(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 250),
                child: child,
              ).buildTransitions(context, animation, secondaryAnimation, child);
            },
          );
        },
      ),
      //Game page
      GoRoute(
        path: '/game',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: FirstTutorialWidget(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 250),
                child: child,
              ).buildTransitions(context, animation, secondaryAnimation, child);
            },
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Just INF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}