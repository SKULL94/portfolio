import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
            constraints: const BoxConstraints(maxWidth: 1000),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: r.isMobile ? 1 : 2,
                crossAxisSpacing: r.spacing(20),
                mainAxisSpacing: r.spacing(20),
                mainAxisExtent: r.value(mobile: 280.0, tablet: 300.0, desktop: 320.0),
              ),
              itemCount: personalProjects.length,
              itemBuilder: (context, index) => _buildProjectCard(personalProjects[index], r),
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
            'Personal Projects',
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
          'Side projects exploring new technologies',
          style: TextStyle(
            color: AppTheme.subtleText,
            fontSize: r.fontSize(14),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(Project project, Responsive r) {
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
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(r.spacing(12)),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.rocket_launch_rounded,
                      color: Colors.white,
                      size: r.fontSize(20),
                    ),
                  ),
                  Row(
                    children: [
                      if (project.githubLink != null)
                        _buildIconButton(FontAwesomeIcons.github, project.githubLink!, r),
                      if (project.playStoreLink != null) ...[
                        SizedBox(width: r.spacing(8)),
                        _buildIconButton(FontAwesomeIcons.googlePlay, project.playStoreLink!, r),
                      ],
                    ],
                  ),
                ],
              ),
              SizedBox(height: r.spacing(16)),

              // Title
              Text(
                project.name,
                style: TextStyle(
                  color: AppTheme.lightText,
                  fontSize: r.fontSize(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: r.spacing(6)),

              // Description
              Text(
                project.description,
                style: TextStyle(
                  color: AppTheme.subtleText,
                  fontSize: r.fontSize(12),
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: r.spacing(14)),

              // Highlights
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: project.highlights.take(4).map((highlight) => Padding(
                      padding: EdgeInsets.only(bottom: r.spacing(6)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: r.fontSize(14),
                            color: AppTheme.secondaryColor,
                          ),
                          SizedBox(width: r.spacing(8)),
                          Expanded(
                            child: Text(
                              highlight,
                              style: TextStyle(
                                color: AppTheme.subtleText,
                                fontSize: r.fontSize(11),
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(FaIconData icon, String url, Responsive r) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(r.spacing(8)),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: FaIcon(icon, color: AppTheme.lightText, size: r.fontSize(16)),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
