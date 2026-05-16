import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withValues(alpha: 0.3),
      ),
      child: Column(
        children: [
          _buildSectionHeader(r),
          SizedBox(height: r.spacing(50)),
          _buildSkillsGrid(r),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(Responsive r) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'Skills & Expertise',
            style: TextStyle(
              fontSize: r.fontSize(32),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: r.spacing(12)),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: r.spacing(16)),
        Text(
          'Technologies I work with',
          style: TextStyle(
            color: AppTheme.subtleText,
            fontSize: r.fontSize(14),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsGrid(Responsive r) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: r.gridCrossAxisCount,
          crossAxisSpacing: r.spacing(16),
          mainAxisSpacing: r.spacing(16),
          mainAxisExtent: r.value(mobile: 160.0, tablet: 170.0, desktop: 180.0),
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) => _buildSkillCard(skills[index], r),
      ),
    );
  }

  Widget _buildSkillCard(Skill skill, Responsive r) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.all(r.spacing(20)),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(r.cardRadius),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and title
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(r.spacing(10)),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _getIconForSkill(skill.icon),
                      color: Colors.white,
                      size: r.fontSize(18),
                    ),
                  ),
                  SizedBox(width: r.spacing(12)),
                  Expanded(
                    child: Text(
                      skill.category,
                      style: TextStyle(
                        color: AppTheme.lightText,
                        fontSize: r.fontSize(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.spacing(16)),
              // Skill chips
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: r.spacing(6),
                    runSpacing: r.spacing(6),
                    children: skill.items.map((item) => _buildSkillChip(item, r)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill, Responsive r) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(10),
        vertical: r.spacing(5),
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        skill,
        style: TextStyle(
          fontSize: r.fontSize(10),
          color: AppTheme.lightText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  IconData _getIconForSkill(String iconName) {
    switch (iconName) {
      case 'code':
        return Icons.code_rounded;
      case 'layers':
        return Icons.layers_rounded;
      case 'architecture':
        return Icons.architecture_rounded;
      case 'cloud':
        return Icons.cloud_rounded;
      case 'smart_toy':
        return Icons.smart_toy_rounded;
      case 'build':
        return Icons.build_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}
