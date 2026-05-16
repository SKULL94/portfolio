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
        color: AppTheme.darkBg,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              'MZH',
              style: TextStyle(
                fontSize: r.fontSize(24),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: r.spacing(14)),
          Text(
            AppConstants.name,
            style: TextStyle(
              color: AppTheme.lightText,
              fontSize: r.fontSize(16),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: r.spacing(6)),
          Text(
            '${AppConstants.title} | ${AppConstants.subtitle}',
            style: TextStyle(
              color: AppTheme.subtleText,
              fontSize: r.fontSize(12),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spacing(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, color: AppTheme.secondaryColor, size: r.fontSize(16)),
              SizedBox(width: r.spacing(6)),
              Text(
                'Built with Flutter',
                style: TextStyle(
                  color: AppTheme.subtleText.withValues(alpha: 0.6),
                  fontSize: r.fontSize(11),
                ),
              ),
            ],
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            '\u00A9 ${DateTime.now().year} ${AppConstants.name}. All rights reserved.',
            style: TextStyle(
              color: AppTheme.subtleText.withValues(alpha: 0.5),
              fontSize: r.fontSize(10),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
