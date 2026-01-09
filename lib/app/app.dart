import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/auth/auth_bloc.dart';
import 'package:leet/presentation/screens/home/home_screen.dart';
import 'package:leet/presentation/screens/questions/questions_screen.dart';
import 'package:leet/presentation/screens/compare/compare_users_screen.dart';
import 'package:leet/presentation/screens/calendar/calendar_screen.dart';
import 'package:leet/presentation/screens/contests/contests_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:leet/presentation/screens/auth/login_screen.dart';



class LeetApp extends StatelessWidget {
  const LeetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leet',
      theme: AppTheme.darkTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(AppTheme.darkTheme.textTheme),
      ),
      home: const AppView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: [
                const HomeScreen(),
                const QuestionsScreen(),
                const CompareUsersScreen(),
                CalendarScreen(username: state.username),
                const ContestsScreen(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: AppTheme.bgNeutral,
              selectedItemColor: AppTheme.primaryColor,
              unselectedItemColor: AppTheme.textSecondary,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Questions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows),
                  label: 'Compare',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'POTD',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events),
                  label: 'Contests',
                ),
              ],
            ),
          );
        } else {
          // If not authenticated, show login screen
          // We need to import LoginScreen
          return const LoginScreenWrapper();
        }
      },
    );
  }
}

// Wrapper to avoid circular dependency if any or just clean separation
class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
