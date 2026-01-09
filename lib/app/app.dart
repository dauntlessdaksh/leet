import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/auth/auth_bloc.dart';
import 'package:leet/presentation/screens/home/home_screen.dart';
import 'package:leet/presentation/screens/questions/questions_screen.dart';
import 'package:leet/presentation/screens/compare/compare_users_screen.dart';
import 'package:leet/presentation/screens/calendar/calendar_screen.dart';
import 'package:leet/presentation/screens/contests/contests_screen.dart';
import 'package:leet/presentation/widgets/app_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:leet/presentation/screens/auth/login_screen.dart';



class LeetApp extends StatelessWidget {
  const LeetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeetCode Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppTheme.bgNeutral,
        primaryColor: AppTheme.primaryColor,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.bgNeutral,
          elevation: 0,
          iconTheme: IconThemeData(color: AppTheme.textPrimary),
          titleTextStyle: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return Scaffold(
            drawer: AppDrawer(
              currentIndex: _currentIndex,
              onItemTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
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
