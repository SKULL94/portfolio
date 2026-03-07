import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/best_works_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'widgets/footer.dart';
import 'widgets/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Md Zeeshan Haider - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  String _currentSection = 'home';

  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'experience': GlobalKey(),
    'bestworks': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.offset;
    String newSection = 'home';

    for (final entry in _sectionKeys.entries) {
      final key = entry.value;
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero).dy;
          if (position <= 200) {
            newSection = entry.key;
          }
        }
      }
    }

    if (newSection != _currentSection) {
      setState(() {
        _currentSection = newSection;
      });
    }
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                Container(
                  key: _sectionKeys['home'],
                  child: HeroSection(onScrollToSection: _scrollToSection),
                ),

                // About Section
                Container(
                  key: _sectionKeys['about'],
                  child: const AboutSection(),
                ),

                // Skills Section
                Container(
                  key: _sectionKeys['skills'],
                  child: const SkillsSection(),
                ),

                // Experience Section
                Container(
                  key: _sectionKeys['experience'],
                  child: const ExperienceSection(),
                ),

                // Best Works Section
                Container(
                  key: _sectionKeys['bestworks'],
                  child: const BestWorksSection(),
                ),

                // Projects Section
                Container(
                  key: _sectionKeys['projects'],
                  child: const ProjectsSection(),
                ),

                // Contact Section
                Container(
                  key: _sectionKeys['contact'],
                  child: const ContactSection(),
                ),

                // Footer
                const Footer(),
              ],
            ),
          ),

          // Fixed NavBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              onNavTap: _scrollToSection,
              currentSection: _currentSection,
            ),
          ),
        ],
      ),
    );
  }
}
