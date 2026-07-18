import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/AppBackground.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final String name;
  final String subtitle;
  final String quote;
  final String avatarUrl;
  final VoidCallback? onBack;

  const ProfileHeader({
    super.key,
    this.title = 'Profile',
    this.name = 'Devotee',
    this.subtitle = 'Thiruvathira',
    this.quote = '"May Lord Kuttichathan bless your path."',
    this.avatarUrl =
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.maroon, AppColors.maroonDark],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onBack ?? () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_none,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 4),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              quote,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}