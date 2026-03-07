import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      child: Column(
        children: [
          _buildSectionTitle(context, 'Work Experience', r),
          SizedBox(height: r.spacing(60)),
          ...experiences.asMap().entries.map(
                (entry) => _buildExperienceCard(context, entry.value, entry.key, r),
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

  Widget _buildExperienceCard(
      BuildContext context, Experience experience, int index, Responsive r) {
    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(40)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!r.isMobile) ...[
            // Timeline
            Column(
              children: [
                Container(
                  width: r.value(mobile: 16, desktop: 20),
                  height: r.value(mobile: 16, desktop: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                if (index < experiences.length - 1)
                  Container(
                    width: 2,
                    height: r.value(mobile: 200, tablet: 250, desktop: 300),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor,
                          AppTheme.primaryColor.withValues(alpha: 0.2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: r.spacing(30)),
          ],
          Expanded(
            child: Container(
              padding: EdgeInsets.all(r.spacing(24)),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(r.cardRadius),
                border: Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: r.value(mobile: 12, desktop: 20),
                    offset: Offset(0, r.value(mobile: 6, desktop: 10)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header - responsive layout
                  r.isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.company,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontSize: r.fontSize(22),
                                  ),
                            ),
                            SizedBox(height: r.spacing(4)),
                            Text(
                              experience.role,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: r.fontSize(16)),
                            ),
                            SizedBox(height: r.spacing(12)),
                            _buildDurationBadge(experience.duration, r),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    experience.company,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          color: AppTheme.primaryColor,
                                          fontSize: r.fontSize(24),
                                        ),
                                  ),
                                  SizedBox(height: r.spacing(4)),
                                  Text(
                                    experience.role,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontSize: r.fontSize(18)),
                                  ),
                                ],
                              ),
                            ),
                            _buildDurationBadge(experience.duration, r),
                          ],
                        ),
                  SizedBox(height: r.spacing(24)),
                  ...experience.projects.map(
                    (project) => _buildProjectItem(context, project, r),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationBadge(String duration, Responsive r) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(16),
        vertical: r.spacing(8),
      ),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.secondaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        duration,
        style: TextStyle(
          color: AppTheme.secondaryColor,
          fontSize: r.fontSize(13),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProjectItem(
      BuildContext context, Project project, Responsive r) {
    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(20)),
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: AppTheme.darkBg.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(r.cardRadius * 0.6),
        border: Border.all(
          color: AppTheme.subtleText.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder_outlined,
                color: AppTheme.secondaryColor,
                size: r.iconSize,
              ),
              SizedBox(width: r.spacing(10)),
              Expanded(
                child: Text(
                  project.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: r.fontSize(15),
                        color: AppTheme.lightText,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            project.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: r.fontSize(13),
                ),
          ),
          SizedBox(height: r.spacing(12)),
          ...project.highlights.map(
            (highlight) => Padding(
              padding: EdgeInsets.only(bottom: r.spacing(6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: r.spacing(8)),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: r.spacing(10)),
                  Expanded(
                    child: Text(
                      highlight,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: r.fontSize(12),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
