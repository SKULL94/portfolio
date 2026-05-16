import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      child: Column(
        children: [
          _buildSectionHeader(r),
          SizedBox(height: r.spacing(50)),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              children: experiences.map((exp) => _buildExperienceCard(exp, r)).toList(),
            ),
          ),
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
            'Experience',
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
          'My professional journey',
          style: TextStyle(
            color: AppTheme.subtleText,
            fontSize: r.fontSize(14),
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(Experience exp, Responsive r) {
    return Padding(
      padding: EdgeInsets.only(bottom: r.spacing(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(r.cardRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(r.spacing(24)),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(r.cardRadius),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                r.isMobile ? _buildMobileHeader(exp, r) : _buildDesktopHeader(exp, r),

                SizedBox(height: r.spacing(20)),

                // Projects
                ...exp.projects.map((project) => _buildProjectItem(project, r)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileHeader(Experience exp, Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Company icon
            Container(
              padding: EdgeInsets.all(r.spacing(10)),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.business_rounded,
                color: Colors.white,
                size: r.fontSize(18),
              ),
            ),
            SizedBox(width: r.spacing(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp.company,
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: r.fontSize(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: r.spacing(2)),
                  Text(
                    exp.role,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: r.fontSize(12),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: r.spacing(12)),
        _buildDurationBadge(exp.duration, r),
      ],
    );
  }

  Widget _buildDesktopHeader(Experience exp, Responsive r) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company icon
        Container(
          padding: EdgeInsets.all(r.spacing(12)),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.business_rounded,
            color: Colors.white,
            size: r.fontSize(20),
          ),
        ),
        SizedBox(width: r.spacing(16)),
        // Company info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exp.company,
                style: TextStyle(
                  color: AppTheme.lightText,
                  fontSize: r.fontSize(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: r.spacing(4)),
              Text(
                exp.role,
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: r.fontSize(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Duration badge
        _buildDurationBadge(exp.duration, r),
      ],
    );
  }

  Widget _buildDurationBadge(String duration, Responsive r) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(12),
        vertical: r.spacing(6),
      ),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.secondaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        duration,
        style: TextStyle(
          color: AppTheme.secondaryColor,
          fontSize: r.fontSize(11),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProjectItem(Project project, Responsive r) {
    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(12)),
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(r.cardRadius - 4),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder_rounded,
                color: AppTheme.secondaryColor,
                size: r.fontSize(16),
              ),
              SizedBox(width: r.spacing(10)),
              Expanded(
                child: Text(
                  project.name,
                  style: TextStyle(
                    color: AppTheme.lightText,
                    fontSize: r.fontSize(13),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (project.description.isNotEmpty) ...[
            SizedBox(height: r.spacing(8)),
            Text(
              project.description,
              style: TextStyle(
                color: AppTheme.subtleText,
                fontSize: r.fontSize(11),
                height: 1.4,
              ),
            ),
          ],
          SizedBox(height: r.spacing(10)),
          ...project.highlights.map((highlight) => Padding(
            padding: EdgeInsets.only(bottom: r.spacing(6)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: r.spacing(5)),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: r.spacing(8)),
                Expanded(
                  child: Text(
                    highlight,
                    style: TextStyle(
                      color: AppTheme.subtleText,
                      fontSize: r.fontSize(11),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
