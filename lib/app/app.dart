import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/auth/auth_bloc.dart';
import 'package:leet/presentation/blocs/home/home_bloc.dart';
import 'package:leet/presentation/screens/home/home_screen.dart';
import 'package:leet/presentation/screens/questions/questions_screen.dart';
import 'package:leet/presentation/screens/compare/compare_users_screen.dart';
import 'package:leet/presentation/screens/calendar/calendar_screen.dart';
import 'package:leet/presentation/screens/contests/contests_screen.dart';
import 'package:leet/presentation/screens/ai_chat/ai_chat_screen.dart';
import 'package:leet/presentation/widgets/app_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

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
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void dispose() {
    _advancedDrawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return AdvancedDrawer(
            backdrop: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.bgNeutral,
                    AppTheme.bgNeutral.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            disabledGestures: false,
            childDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            drawer: AppDrawer(
              currentIndex: _currentIndex,
              onItemTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _advancedDrawerController.hideDrawer();
              },
            ),
            child: Scaffold(
              appBar: AppBar(
                title: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, homeState) {
                    if (_currentIndex == 0 && homeState is HomeLoaded) {
                      final name = homeState.userInfo?.profile?.realName ?? 
                                   homeState.userInfo?.username ?? 
                                   'LeetCoder';
                      return Text('Hi $name!');
                    }
                    // Show tab names for other tabs
                    final titles = ['Home', 'Questions', 'Compare', 'POTD', 'Contests', 'AI Assistant'];
                    return Text(titles[_currentIndex.clamp(0, titles.length - 1)]);
                  },
                ),
                leading: IconButton(
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.close : Icons.menu_rounded,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                  onPressed: _handleMenuButtonPressed,
                ),
              ),
              body: IndexedStack(
                index: _currentIndex,
                children: [
                  const HomeScreen(),
                  const QuestionsScreen(),
                  const CompareUsersScreen(),
                  CalendarScreen(username: state.username),
                  const ContestsScreen(),
                  const AiChatScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex > 4 ? 0 : _currentIndex, // Clamp to valid range
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

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
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
