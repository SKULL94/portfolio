import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: r.spacing(30),
        horizontal: r.horizontalPadding,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
        ),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              'MZH',
              style: TextStyle(
                fontSize: r.fontSize(28),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            AppConstants.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: r.fontSize(18),
                ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            '${AppConstants.title} | ${AppConstants.subtitle}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: r.fontSize(13),
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'Built with Flutter',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.subtleText.withValues(alpha: 0.6),
                  fontSize: r.fontSize(12),
                ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            '\u00A9 ${DateTime.now().year} ${AppConstants.name}. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.subtleText.withValues(alpha: 0.6),
                  fontSize: r.fontSize(11),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
