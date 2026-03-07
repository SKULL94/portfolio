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
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withValues(alpha: 0.3),
      ),
      child: Column(
        children: [
          _buildSectionTitle(context, 'Personal Projects', r),
          SizedBox(height: r.spacing(20)),
          Text(
            'Side projects I\'ve built to explore new technologies',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: r.fontSize(14),
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spacing(60)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: r.isMobile ? 1 : 2,
              crossAxisSpacing: r.spacing(24),
              mainAxisSpacing: r.spacing(24),
              mainAxisExtent: r.value(
                mobile: 320,
                smallPhone: 300,
                tablet: 340,
                desktop: 360,
              ),
            ),
            itemCount: personalProjects.length,
            itemBuilder: (context, index) =>
                _buildProjectCard(context, personalProjects[index], r),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
      BuildContext context, String title, Responsive r) {
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

  Widget _buildProjectCard(
      BuildContext context, Project project, Responsive r) {
    return Container(
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
      child: Padding(
        padding: EdgeInsets.all(r.spacing(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: r.value(mobile: 50, desktop: 60),
                  height: r.value(mobile: 50, desktop: 60),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(r.cardRadius * 0.75),
                  ),
                  child: Icon(
                    Icons.rocket_launch,
                    color: Colors.white,
                    size: r.iconSize + 4,
                  ),
                ),
                Row(
                  children: [
                    if (project.githubLink != null)
                      IconButton(
                        onPressed: () => _launchUrl(project.githubLink!),
                        icon: FaIcon(
                          FontAwesomeIcons.github,
                          color: AppTheme.lightText,
                          size: r.iconSize,
                        ),
                        tooltip: 'View on GitHub',
                      ),
                    if (project.playStoreLink != null)
                      IconButton(
                        onPressed: () => _launchUrl(project.playStoreLink!),
                        icon: FaIcon(
                          FontAwesomeIcons.googlePlay,
                          color: AppTheme.lightText,
                          size: r.iconSize,
                        ),
                        tooltip: 'View on Play Store',
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: r.spacing(20)),
            Text(
              project.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: r.fontSize(22),
                  ),
            ),
            SizedBox(height: r.spacing(8)),
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: r.fontSize(13),
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: r.spacing(16)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: project.highlights.take(4).map(
                    (highlight) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: r.spacing(8)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: r.fontSize(16),
                              color: AppTheme.secondaryColor,
                            ),
                            SizedBox(width: r.spacing(10)),
                            Expanded(
                              child: Text(
                                highlight,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: r.fontSize(12)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
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
