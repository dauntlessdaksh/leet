import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/data/models/badges_model.dart' as badges_model;
import 'package:leet/presentation/widgets/badge_display.dart';
import 'package:shimmer/shimmer.dart';

class HomeHeader extends StatelessWidget {
  final LeetCodeUserInfo? userInfo;
  final List<badges_model.Badge>? badges;

  const HomeHeader({
    super.key,
    required this.userInfo,
    this.badges,
  });

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryColor, width: 2),
            ),
            child: ClipOval(
              child: userInfo?.profile?.userAvatar != null
                  ? CachedNetworkImage(
                      imageUrl: userInfo!.profile!.userAvatar!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: AppTheme.cardBg,
                        highlightColor: AppTheme.bgNeutral,
                        child: Container(color: AppTheme.cardBg),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.person),
                    )
                  : const Icon(Icons.person, size: 40, color: AppTheme.textSecondary),
            ),
          ),
          const SizedBox(width: 20),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        userInfo?.username ?? 'User',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    BadgeDisplay(badges: badges, maxDisplay: 3),
                  ],
                ),
                if (userInfo?.profile?.realName != null)
                  Text(
                    userInfo!.profile!.realName!,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Rank: ${userInfo?.profile?.ranking?.toString() ?? "N/A"}',
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
