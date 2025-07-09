import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yg_assignment/blocs/course/course_bloc.dart';
import 'package:yg_assignment/blocs/course/course_event.dart';
import 'package:yg_assignment/blocs/user/user_bloc.dart';
import 'package:yg_assignment/blocs/user/user_event.dart';
import 'package:yg_assignment/constants/constants.dart';
import 'package:yg_assignment/data/models/courses_model.dart';
import 'package:yg_assignment/data/models/user_model.dart';
import 'package:yg_assignment/screens/audio_call/audio_call_screen.dart';
import 'package:yg_assignment/screens/course_list/course_detail_screen.dart';
import 'package:yg_assignment/screens/course_list/course_list_screen.dart';
import 'package:yg_assignment/screens/home/home_screen.dart';
import 'package:yg_assignment/screens/login/otp_verification_screen.dart';
import 'package:yg_assignment/screens/navigation_screen.dart';
import 'package:yg_assignment/services/course_services.dart';
import 'package:yg_assignment/services/user_services.dart';
import '../screens/login/login_screen.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> sectionNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,

    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && state.uri.toString() == '/') {
        return '/home';
      }
      if (user == null && state.uri.toString() == '/home') {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) {
          final phoneNumber = state.extra as String;
          return OtpVerificationScreen(phoneNumber: phoneNumber);
        },
      ),
      GoRoute(
        path: '/audio-call',
        builder: (context, state) {
          final user = state.extra as UserModel;
          return AudioCallScreen(userData: user);
        },
      ),
      GoRoute(
        path: '/course-detail',
        builder: (context, state) {
          final course = state.extra as Course;
          return CourseDetailScreen(course: course);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BlocProvider(
            create:
                (_) =>
                    UserBloc(UserService())
                      ..add(LoadUser(AppConstants.dummyUserId)),
            child: NavigationScreen(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: sectionNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/courses',
                builder:
                    (context, state) => BlocProvider(
                      create:
                          (_) => CourseBloc(
                            CourseService(FirebaseFirestore.instance),
                          )..add(FetchCourses()),
                      child: const CourseListScreen(),
                    ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
