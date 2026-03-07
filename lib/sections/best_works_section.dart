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
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getHorizontalPadding(context),
        vertical: 100,
      ),
      decoration: BoxDecoration(color: AppTheme.darkBg),
      child: Column(
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 20),
          Text(
            'Featured projects showcasing end-to-end development expertise',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // Work Selector Tabs
          _buildWorkSelector(context, isMobile),
          const SizedBox(height: 40),

          // Selected Work Detail Card
          _buildWorkDetailCard(
            context,
            bestWorks[_selectedWorkIndex],
            isMobile,
            isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Column(
      children: [
        Text('Best Works', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkSelector(BuildContext context, bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(bestWorks.length, (index) {
          final work = bestWorks[index];
          final isSelected = _selectedWorkIndex == index;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 10),
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
                  horizontal: isMobile ? 16 : 24,
                  vertical: isMobile ? 12 : 16,
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
                        margin: const EdgeInsets.only(right: 8),
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
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: isMobile ? 13 : 15,
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
    BuildContext context,
    BestWork work,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with status badge
          _buildCardHeader(context, work, isMobile),

          // Main content - Screenshots & Info
          Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: isMobile
                ? Column(
                    children: [
                      _buildScreenshotArea(context, work, isMobile),
                      const SizedBox(height: 32),
                      _buildInfoArea(context, work, isMobile),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isTablet ? 5 : 4,
                        child: _buildScreenshotArea(context, work, isMobile),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: isTablet ? 5 : 6,
                        child: _buildInfoArea(context, work, isMobile),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context, BestWork work, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withValues(alpha: 0.15),
            AppTheme.secondaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  work.category,
                  style: TextStyle(
                    color: AppTheme.secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
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
                        margin: const EdgeInsets.only(right: 6),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Links
              if (work.githubLink != null)
                IconButton(
                  onPressed: () => _launchUrl(work.githubLink!),
                  icon: const FaIcon(
                    FontAwesomeIcons.github,
                    color: AppTheme.lightText,
                    size: 20,
                  ),
                  tooltip: 'View on GitHub',
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            work.name,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            work.tagline,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotArea(
    BuildContext context,
    BestWork work,
    bool isMobile,
  ) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: isMobile ? 350 : 450),
          decoration: BoxDecoration(
            color: AppTheme.darkBg,
            borderRadius: BorderRadius.circular(16),
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
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                Center(
                  child: _buildScreenshotImage(
                    work.screenshots[_currentScreenshotIndex],
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
                        onTap: () {
                          setState(() {
                            _currentScreenshotIndex =
                                (_currentScreenshotIndex -
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
                        onTap: () {
                          setState(() {
                            _currentScreenshotIndex =
                                (_currentScreenshotIndex + 1) %
                                work.screenshots.length;
                          });
                        },
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_currentScreenshotIndex + 1} / ${work.screenshots.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
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

        const SizedBox(height: 16),

        if (work.screenshots.length > 1)
          SizedBox(
            height: 60,
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
                    width: isActive ? 70 : 55,
                    height: isActive ? 55 : 45,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
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
                                color: AppTheme.primaryColor.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _buildScreenshotImage(
                        work.screenshots[index],
                        isThumbnail: true,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  Widget _buildScreenshotImage(String assetPath, {bool isThumbnail = false}) {
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
                size: isThumbnail ? 20 : 48,
                color: AppTheme.primaryColor.withValues(alpha: 0.5),
              ),
              if (!isThumbnail) ...[
                const SizedBox(height: 12),
                Text(
                  'Screenshot',
                  style: TextStyle(color: AppTheme.subtleText, fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavArrow({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildInfoArea(BuildContext context, BestWork work, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        Text(
          work.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
        ),
        const SizedBox(height: 28),

        // Tech Stack
        _buildInfoSection(
          context,
          title: 'Tech Stack',
          icon: Icons.code,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: work.techStack.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        // Key Features
        _buildInfoSection(
          context,
          title: 'Key Features',
          icon: Icons.star_outline,
          child: Column(
            children: work.keyFeatures.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(height: 1.5),
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
          const SizedBox(height: 24),
          _buildInfoSection(
            context,
            title: 'Roadmap',
            icon: Icons.rocket_launch_outlined,
            child: Column(
              children: work.futurePlans.map((plan) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: Colors.amber.withValues(alpha: 0.8),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          plan,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                height: 1.5,
                                color: AppTheme.subtleText,
                                fontStyle: FontStyle.italic,
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppTheme.secondaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
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
