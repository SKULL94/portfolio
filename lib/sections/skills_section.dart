import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      decoration: BoxDecoration(color: AppTheme.cardBg.withValues(alpha: 0.3)),
      child: Column(
        children: [
          _buildSectionTitle(context, 'Skills & Expertise', r),
          SizedBox(height: r.spacing(60)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: r.gridCrossAxisCount,
              crossAxisSpacing: r.spacing(24),
              mainAxisSpacing: r.spacing(24),
              mainAxisExtent: r.value(
                mobile: 180,
                smallPhone: 170,
                tablet: 190,
                desktop: 200,
              ),
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) =>
                _buildSkillCard(context, skills[index], r),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Responsive r) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: r.fontSize(40),
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: r.spacing(16)),
        Container(
          width: r.value(mobile: 60, desktop: 80),
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillCard(BuildContext context, Skill skill, Responsive r) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(r.cardRadius),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: r.value(mobile: 12, desktop: 20),
            offset: Offset(0, r.value(mobile: 6, desktop: 10)),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(r.spacing(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: r.value(mobile: 40, desktop: 46),
                  height: r.value(mobile: 40, desktop: 46),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(r.cardRadius * 0.6),
                  ),
                  child: Icon(
                    _getIconForSkill(skill.icon),
                    color: Colors.white,
                    size: r.iconSize,
                  ),
                ),
                SizedBox(width: r.spacing(16)),
                Expanded(
                  child: Text(
                    skill.category,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: r.fontSize(15),
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: r.spacing(16)),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: r.spacing(8),
                  runSpacing: r.spacing(8),
                  children: skill.items
                      .map((item) => _buildSkillChip(item, r))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill, Responsive r) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(12),
        vertical: r.spacing(6),
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        skill,
        style: TextStyle(
          fontSize: r.fontSize(12),
          color: AppTheme.lightText,
        ),
      ),
    );
  }

  IconData _getIconForSkill(String iconName) {
    switch (iconName) {
      case 'code':
        return Icons.code;
      case 'layers':
        return Icons.layers;
      case 'architecture':
        return Icons.architecture;
      case 'cloud':
        return Icons.cloud;
      case 'smart_toy':
        return Icons.smart_toy;
      case 'build':
        return Icons.build;
      default:
        return Icons.star;
    }
  }
}
