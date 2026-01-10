import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/badges_model.dart' as badges_model;

class BadgeDisplay extends StatelessWidget {
  final List<badges_model.Badge>? badges;
  final int maxDisplay;

  const BadgeDisplay({
    super.key,
    this.badges,
    this.maxDisplay = 3,
  });

  @override
  Widget build(BuildContext context) {
    if (badges == null || badges!.isEmpty) return const SizedBox.shrink();

    final displayBadges = badges!.take(maxDisplay).toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...displayBadges.map((badge) => Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Tooltip(
                message: badge.displayName ?? badge.name ?? 'Badge',
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: badge.icon != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: CachedNetworkImage(
                            imageUrl: badge.icon!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.emoji_events, size: 16, color: AppTheme.primaryColor),
                          ),
                        )
                      : const Icon(Icons.emoji_events, size: 16, color: AppTheme.primaryColor),
                ),
              ),
            )),
        if (badges!.length > maxDisplay)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '+${badges!.length - maxDisplay}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
