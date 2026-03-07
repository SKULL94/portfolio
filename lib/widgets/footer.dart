import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: const Text(
              'ZH',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppConstants.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '${AppConstants.title} | ${AppConstants.subtitle}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Text(
            'Built with Flutter',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.subtleText.withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\u00A9 ${DateTime.now().year} ${AppConstants.name}. All rights reserved.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.subtleText.withValues(alpha: 0.6),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
