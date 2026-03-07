import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/theme.dart';

class BestWorksSection extends StatefulWidget {
  const BestWorksSection({super.key});

  @override
  State<BestWorksSection> createState() => _BestWorksSectionState();
}

class _BestWorksSectionState extends State<BestWorksSection> {
  int _selectedWorkIndex = 0;
  int _currentScreenshotIndex = 0;

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.horizontalPadding,
        vertical: r.sectionVerticalPadding,
      ),
      decoration: const BoxDecoration(color: AppTheme.darkBg),
      child: Column(
        children: [
          _buildSectionTitle(context, r),
          SizedBox(height: r.spacing(20)),
          Text(
            'Featured projects showcasing end-to-end development expertise',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: r.fontSize(14),
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spacing(60)),

          // Work Selector Tabs
          _buildWorkSelector(context, r),
          SizedBox(height: r.spacing(40)),

          // Selected Work Detail Card
          _buildWorkDetailCard(context, bestWorks[_selectedWorkIndex], r),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, Responsive r) {
    return Column(
      children: [
        Text(
          'Best Works',
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

  Widget _buildWorkSelector(BuildContext context, Responsive r) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(bestWorks.length, (index) {
          final work = bestWorks[index];
          final isSelected = _selectedWorkIndex == index;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: r.spacing(8)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedWorkIndex = index;
                  _currentScreenshotIndex = 0;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(20),
                  vertical: r.spacing(12),
                ),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppTheme.primaryGradient : null,
                  color: isSelected ? null : AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : AppTheme.primaryColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryColor.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (work.status == 'In Progress')
                      Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.only(right: r.spacing(8)),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withValues(alpha: 0.5),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    Text(
                      work.name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.subtleText,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: r.fontSize(14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWorkDetailCard(
      BuildContext context, BestWork work, Responsive r) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(r.cardRadius + 4),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: r.value(mobile: 20, desktop: 30),
            offset: Offset(0, r.value(mobile: 10, desktop: 15)),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with status badge
          _buildCardHeader(context, work, r),

          // Main content - Screenshots & Info
          Padding(
            padding: EdgeInsets.all(r.spacing(28)),
            child: r.isMobile
                ? Column(
                    children: [
                      _buildScreenshotArea(context, work, r),
                      SizedBox(height: r.spacing(32)),
                      _buildInfoArea(context, work, r),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: r.isTablet ? 5 : 4,
                        child: _buildScreenshotArea(context, work, r),
                      ),
                      SizedBox(width: r.spacing(40)),
                      Expanded(
                        flex: r.isTablet ? 5 : 6,
                        child: _buildInfoArea(context, work, r),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context, BestWork work, Responsive r) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.spacing(24)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withValues(alpha: 0.15),
            AppTheme.secondaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(r.cardRadius + 4),
          topRight: Radius.circular(r.cardRadius + 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: r.spacing(12),
            runSpacing: r.spacing(8),
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Category badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(14),
                  vertical: r.spacing(6),
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  work.category,
                  style: TextStyle(
                    color: AppTheme.secondaryColor,
                    fontSize: r.fontSize(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Status badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(14),
                  vertical: r.spacing(6),
                ),
                decoration: BoxDecoration(
                  color: work.status == 'In Progress'
                      ? Colors.green.withValues(alpha: 0.2)
                      : AppTheme.secondaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (work.status == 'In Progress')
                      Container(
                        width: 6,
                        height: 6,
                        margin: EdgeInsets.only(right: r.spacing(6)),
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      work.status,
                      style: TextStyle(
                        color: work.status == 'In Progress'
                            ? Colors.greenAccent
                            : AppTheme.secondaryColor,
                        fontSize: r.fontSize(12),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // GitHub link
              if (work.githubLink != null && !r.isMobile)
                IconButton(
                  onPressed: () => _launchUrl(work.githubLink!),
                  icon: FaIcon(
                    FontAwesomeIcons.github,
                    color: AppTheme.lightText,
                    size: r.iconSize,
                  ),
                  tooltip: 'View on GitHub',
                ),
            ],
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            work.name,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: r.fontSize(28),
                ),
          ),
          SizedBox(height: r.spacing(6)),
          Text(
            work.tagline,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: r.fontSize(16),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotArea(
      BuildContext context, BestWork work, Responsive r) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: r.value(
              mobile: r.height * 0.4,
              smallPhone: r.height * 0.35,
              tablet: 400,
              desktop: 450,
            ),
          ),
          decoration: BoxDecoration(
            color: AppTheme.darkBg,
            borderRadius: BorderRadius.circular(r.cardRadius),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(r.cardRadius - 2),
            child: Stack(
              children: [
                Center(
                  child: _buildScreenshotImage(
                    work.screenshots[_currentScreenshotIndex],
                    r,
                  ),
                ),

                if (work.screenshots.length > 1)
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _buildNavArrow(
                        icon: Icons.chevron_left,
                        r: r,
                        onTap: () {
                          setState(() {
                            _currentScreenshotIndex = (_currentScreenshotIndex -
                                    1 +
                                    work.screenshots.length) %
                                work.screenshots.length;
                          });
                        },
                      ),
                    ),
                  ),
                if (work.screenshots.length > 1)
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _buildNavArrow(
                        icon: Icons.chevron_right,
                        r: r,
                        onTap: () {
                          setState(() {
                            _currentScreenshotIndex = (_currentScreenshotIndex +
                                    1) %
                                work.screenshots.length;
                          });
                        },
                      ),
                    ),
                  ),
                // Counter
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.spacing(12),
                        vertical: r.spacing(6),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_currentScreenshotIndex + 1} / ${work.screenshots.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: r.fontSize(12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: r.spacing(16)),

        // Thumbnails
        if (work.screenshots.length > 1)
          SizedBox(
            height: r.value(mobile: 50, desktop: 60),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(work.screenshots.length, (index) {
                  final isActive = index == _currentScreenshotIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentScreenshotIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: isActive
                          ? r.value(mobile: 55, desktop: 70)
                          : r.value(mobile: 45, desktop: 55),
                      height: isActive
                          ? r.value(mobile: 45, desktop: 55)
                          : r.value(mobile: 38, desktop: 45),
                      margin: EdgeInsets.symmetric(horizontal: r.spacing(6)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isActive
                              ? AppTheme.primaryColor
                              : AppTheme.primaryColor.withValues(alpha: 0.3),
                          width: isActive ? 2 : 1,
                        ),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: AppTheme.primaryColor
                                      .withValues(alpha: 0.3),
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: _buildScreenshotImage(
                          work.screenshots[index],
                          r,
                          isThumbnail: true,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildScreenshotImage(String assetPath, Responsive r,
      {bool isThumbnail = false}) {
    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppTheme.cardBg,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                size: isThumbnail ? 20 : r.value(mobile: 36, desktop: 48),
                color: AppTheme.primaryColor.withValues(alpha: 0.5),
              ),
              if (!isThumbnail) ...[
                SizedBox(height: r.spacing(12)),
                Text(
                  'Screenshot',
                  style: TextStyle(
                    color: AppTheme.subtleText,
                    fontSize: r.fontSize(14),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavArrow({
    required IconData icon,
    required VoidCallback onTap,
    required Responsive r,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(r.spacing(8)),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: r.iconSize),
      ),
    );
  }

  Widget _buildInfoArea(BuildContext context, BestWork work, Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        Text(
          work.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.7,
                fontSize: r.fontSize(14),
              ),
        ),
        SizedBox(height: r.spacing(28)),

        // Tech Stack
        _buildInfoSection(
          context,
          title: 'Tech Stack',
          icon: Icons.code,
          r: r,
          child: Wrap(
            spacing: r.spacing(8),
            runSpacing: r.spacing(8),
            children: work.techStack.map((tech) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(14),
                  vertical: r.spacing(8),
                ),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: r.fontSize(11),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: r.spacing(24)),

        // Key Features
        _buildInfoSection(
          context,
          title: 'Key Features',
          icon: Icons.star_outline,
          r: r,
          child: Column(
            children: work.keyFeatures.map((feature) {
              return Padding(
                padding: EdgeInsets.only(bottom: r.spacing(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: r.spacing(6)),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: r.spacing(12)),
                    Expanded(
                      child: Text(
                        feature,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                              fontSize: r.fontSize(13),
                            ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        // Future Plans (only for In Progress projects)
        if (work.futurePlans.isNotEmpty) ...[
          SizedBox(height: r.spacing(24)),
          _buildInfoSection(
            context,
            title: 'Roadmap',
            icon: Icons.rocket_launch_outlined,
            r: r,
            child: Column(
              children: work.futurePlans.map((plan) {
                return Padding(
                  padding: EdgeInsets.only(bottom: r.spacing(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: r.fontSize(16),
                        color: Colors.amber.withValues(alpha: 0.8),
                      ),
                      SizedBox(width: r.spacing(12)),
                      Expanded(
                        child: Text(
                          plan,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.5,
                                    color: AppTheme.subtleText,
                                    fontStyle: FontStyle.italic,
                                    fontSize: r.fontSize(13),
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
    required Responsive r,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: r.fontSize(18), color: AppTheme.secondaryColor),
            SizedBox(width: r.spacing(8)),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: r.fontSize(16),
                  ),
            ),
          ],
        ),
        SizedBox(height: r.spacing(14)),
        child,
      ],
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
