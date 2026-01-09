import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/auth/auth_bloc.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTap;

  const AppDrawer({
    super.key,
    required this.currentIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.bgNeutral,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryColor.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.code,
                    size: 32,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Leet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthAuthenticated) {
                      return Text(
                        '@${state.username}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _DrawerItem(
                  icon: Icons.dashboard_rounded,
                  title: 'Home',
                  isSelected: currentIndex == 0,
                  onTap: () => onItemTap(0),
                ),
                _DrawerItem(
                  icon: Icons.list_alt_rounded,
                  title: 'Questions',
                  isSelected: currentIndex == 1,
                  onTap: () => onItemTap(1),
                ),
                _DrawerItem(
                  icon: Icons.compare_arrows_rounded,
                  title: 'Compare',
                  isSelected: currentIndex == 2,
                  onTap: () => onItemTap(2),
                ),
                _DrawerItem(
                  icon: Icons.calendar_today_rounded,
                  title: 'POTD',
                  isSelected: currentIndex == 3,
                  onTap: () => onItemTap(3),
                ),
                _DrawerItem(
                  icon: Icons.emoji_events_rounded,
                  title: 'Contests',
                  isSelected: currentIndex == 4,
                  onTap: () => onItemTap(4),
                ),
                const Divider(height: 32, thickness: 1),
                _DrawerItem(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  isSelected: false,
                  isLogout: true,
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                ),
              ],
            ),
          ),
          
          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final bool isLogout;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    this.isLogout = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: AppTheme.primaryColor.withOpacity(0.3), width: 1)
            : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout
              ? Colors.red
              : isSelected
                  ? AppTheme.primaryColor
                  : AppTheme.textSecondary,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isLogout
                ? Colors.red
                : isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.textPrimary,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
