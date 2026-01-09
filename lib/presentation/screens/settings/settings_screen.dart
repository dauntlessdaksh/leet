import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/settings/settings_bloc.dart';
import 'package:leet/presentation/blocs/auth/auth_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SettingsBloc>().add(LoadSettings());
    
    return Scaffold(
      backgroundColor: AppTheme.bgNeutral,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
               context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.code, color: AppTheme.textPrimary),
            title: const Text('Source Code', style: TextStyle(color: AppTheme.textPrimary)),
            trailing: const Icon(Icons.open_in_new, color: AppTheme.textSecondary, size: 16),
            onTap: () {
              launchUrl(Uri.parse('https://github.com/Start-up-fair/twice'));
            },
          ),
          const Divider(color: Colors.grey),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                 return ListTile(
                   title: const Text('Version', style: TextStyle(color: AppTheme.textSecondary)),
                   trailing: Text('${state.appVersion} (${state.buildNumber})', style: const TextStyle(color: AppTheme.textSecondary)),
                 );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
