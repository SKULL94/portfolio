class AppConstants {
  static const String name = 'Md Zeeshan Haider';
  static const String title = 'SDE-2 | Flutter Developer';
  static const String subtitle = '4+ Years of Experience';
  static const String email = 'Zeeshanhaider794@gmail.com';
  static const String phone = '+91-7250497748';
  static const String location = 'Noida, India';
  static const String linkedIn =
      'https://www.linkedin.com/in/md-zeeshan-haider-6a5246349/';
  static const String github = 'https://github.com/SKULL94';

  static const String aboutMe = '''
4+ years of experience working across both product- and service-based startups, with end-to-end ownership of the development lifecycle—from planning to deployment.

Proven ability to create scalable and user-friendly products, demonstrated by an app with 10K+ downloads and 2500+ Daily Active Users.

Experience in publishing apps on the Play Store and App Store, with 4+ apps successfully published.
''';

  static const List<String> animatedTexts = [
    'Flutter Developer',
    'Mobile App Architect',
    'UI/UX Enthusiast',
    'Problem Solver',
  ];
}

class Skill {
  final String category;
  final List<String> items;
  final String icon;

  const Skill({
    required this.category,
    required this.items,
    required this.icon,
  });
}

const List<Skill> skills = [
  Skill(
    category: 'Languages & Frameworks',
    items: ['Flutter', 'Dart', 'Android', 'iOS'],
    icon: 'code',
  ),
  Skill(
    category: 'State Management',
    items: ['BLoC', 'Provider', 'GetX'],
    icon: 'layers',
  ),
  Skill(
    category: 'Architecture',
    items: ['MVVM', 'Clean Architecture', 'Modular Codebase'],
    icon: 'architecture',
  ),
  Skill(
    category: 'Backend',
    items: ['REST APIs', 'Firebase', 'Supabase', 'SQLite'],
    icon: 'cloud',
  ),
  Skill(
    category: 'AI Integration',
    items: ['TensorFlow Lite', 'On-Device AI', 'OpenAI APIs'],
    icon: 'smart_toy',
  ),
  Skill(
    category: 'Tools & Others',
    items: ['Git', 'GitHub Actions', 'Figma', 'Postman'],
    icon: 'build',
  ),
];

class Experience {
  final String company;
  final String role;
  final String duration;
  final List<Project> projects;

  const Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.projects,
  });
}

class Project {
  final String name;
  final String description;
  final String? playStoreLink;
  final String? githubLink;
  final List<String> highlights;
  final bool isPersonal;

  const Project({
    required this.name,
    required this.description,
    this.playStoreLink,
    this.githubLink,
    required this.highlights,
    this.isPersonal = false,
  });
}

const List<Experience> experiences = [
  Experience(
    company: 'Quokka Labs LLP',
    role: 'Flutter Developer',
    duration: 'July 2025 - Present',
    projects: [
      Project(
        name: 'Smartwatch Health App',
        description: 'BLE-connected smartwatch application for health tracking',
        highlights: [
          'End-to-end development of smartwatch application',
          'Track heart rate, SpO2, calories burned, and step count',
          'Real-time synchronization with BLE devices',
          'User-friendly data visualization',
        ],
      ),
      Project(
        name: 'Cricket Live Streaming App',
        description: 'Live cricket streaming with real-time overlays',
        highlights: [
          'Real-time score ticker and match highlights',
          'YouTube and other channel integration',
          'Live overlay implementation',
        ],
      ),
      Project(
        name: 'AI Voice Chatbot App',
        description: 'Voice-enabled AI chatbot with natural interactions',
        highlights: [
          'OpenAI Realtime API integration',
          'ElevenLabs voice synthesis',
          'Streaming responses for low-latency',
        ],
      ),
    ],
  ),
  Experience(
    company: 'Jina Code Systems',
    role: 'Flutter Developer',
    duration: 'Jan 2024 - Mar 2025',
    projects: [
      Project(
        name: 'Eris AI - Paper Trading',
        description: 'B2B app for global paper trading company',
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.erisai',
        highlights: [
          '25% reduction in app load time through optimization',
          'Real-time bidding features',
          'AI Chatbot integration boosting transactions by 30%',
        ],
      ),
      Project(
        name: 'Tennis Booking App',
        description: 'Court reservation and slot management',
        highlights: [
          'Real-time court availability updates',
          'Slot booking flow with push notifications',
        ],
      ),
      Project(
        name: 'LHC Connect - CA Marketplace',
        description: 'Tax-filing platform for CAs and users',
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.lhcconnect',
        highlights: [
          'Complete UI/UX design and development',
          'Role-based dashboards (Admin, CA, Users)',
          'API integration for tax-filing features',
        ],
      ),
    ],
  ),
  Experience(
    company: 'Helppr.ai',
    role: 'Flutter Developer',
    duration: 'Jan 2022 - Oct 2023',
    projects: [
      Project(
        name: 'Helppr.ai - UPSC Learning App',
        description: 'Self-learning mobile app for UPSC preparation',
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.helppr.ai',
        highlights: [
          '10K+ users with 2,500+ Daily Active Users',
          'Cross-platform (Android, iOS, Web)',
          'Agile development with bug-free releases',
        ],
      ),
    ],
  ),
];

const List<Project> personalProjects = [
  Project(
    name: 'SkinSync',
    description: 'AI-powered skin care tracker app with CNN-based analysis',
    githubLink: 'https://github.com/mdzeeshan/skinsync',
    isPersonal: true,
    highlights: [
      'TFLite model integration (HAM10000 CNN)',
      'GetX state management',
      'Hybrid data sync (SQLite <-> Firestore)',
      '65% reduction in image processing latency',
      'Custom routine creation with notifications',
      'Social sharing of skin analysis results',
    ],
  ),
  Project(
    name: 'FreshCart',
    description: 'Grocery shopping app with modern UI',
    githubLink: 'https://github.com/mdzeeshan/freshcart',
    isPersonal: true,
    highlights: [
      'GetX state management migration',
      'ScreenUtil for full device responsiveness',
      'Complete codebase refactoring',
    ],
  ),
];

// Best Works Showcase
class BestWork {
  final String name;
  final String tagline;
  final String description;
  final String status; // 'In Progress' or 'Completed'
  final List<String> screenshots; // Asset paths for screenshots
  final List<String> techStack;
  final List<String> keyFeatures;
  final List<String> futurePlans;
  final String? playStoreLink;
  final String? githubLink;
  final String category; // e.g., 'AI/ML', 'Healthcare', 'FinTech', 'Enterprise'

  const BestWork({
    required this.name,
    required this.tagline,
    required this.description,
    required this.status,
    required this.screenshots,
    required this.techStack,
    required this.keyFeatures,
    this.futurePlans = const [],
    this.playStoreLink,
    this.githubLink,
    required this.category,
  });
}

const List<BestWork> bestWorks = [
  // Sales Calling App - Currently Working (Top Priority)
  BestWork(
    name: 'Sales Calling App',
    tagline: 'AI-Powered Sales Acceleration Platform',
    description:
        'Enterprise-grade sales calling solution enabling Loan Consultants (LCs) to efficiently manage and convert leads. The app supports both CPaaS integration and direct SIM calling, with real-time audio streaming and intelligent lead management.',
    status: 'In Progress',
    screenshots: [
      'assets/best_works/superconnect/super-one.jpg',
      'assets/best_works/superconnect/super-two.jpg',
      'assets/best_works/superconnect/super-three.jpg',
    ],
    techStack: ['Flutter', 'WebRTC', 'CPaaS', 'Firebase', 'Node.js', 'AI/ML'],
    keyFeatures: [
      'Dual calling modes - CPaaS integration & direct SIM calling',
      'Real-time call merging with seamless audio streaming',
      'Audio recording & cloud storage for compliance',
      'Smart lead tracking with call completion metrics',
      'Automated lead push to LC on call completion',
      'Real-time call analytics dashboard',
    ],
    futurePlans: [
      'AI-powered noise cancellation for clearer calls',
      'Speech-to-Text (STT) for live transcription',
      'AI Live Insights - Real-time pitch suggestions',
      'Sentiment analysis for user emotion detection',
      'Predictive lead scoring based on conversation',
    ],
    category: 'Enterprise Sales',
  ),

  // Smartwatch Health App
  BestWork(
    name: 'Smartwatch Health App',
    tagline: 'BLE-Connected Health & Fitness Companion',
    description:
        'Comprehensive health tracking application that seamlessly syncs with BLE-enabled smartwatches. Provides real-time health metrics visualization with beautiful charts and actionable insights.',
    status: 'Completed',
    screenshots: [
      'assets/best_works/fulcrum/fulcrum-one.jpg',
      'assets/best_works/fulcrum/fulcrum-two.jpg',
      'assets/best_works/fulcrum/fulcrum-three.jpg',
    ],
    techStack: ['Flutter', 'BLE', 'SQLite', 'Provider', 'FL Chart'],
    keyFeatures: [
      'Real-time heart rate & SpO2 monitoring',
      'Step count with daily/weekly/monthly trends',
      'Calories burned calculation & tracking',
      'Sleep quality analysis with patterns',
      'BLE device pairing & auto-reconnection',
      'Health data export & sharing',
    ],
    category: 'Healthcare',
  ),

  // AI Voice Chatbot App
  BestWork(
    name: 'AI Voice Chatbot',
    tagline: 'Natural Voice Conversations with AI',
    description:
        'Voice-first AI chatbot delivering human-like conversations using cutting-edge voice synthesis and real-time AI processing. Features ultra-low latency responses for natural dialogue flow.',
    status: 'Completed',
    screenshots: [
      'assets/best_works/ai-voice/chatbot-one.jpeg',
      'assets/best_works/ai-voice/chatbot-two.jpeg',
      'assets/best_works/ai-voice/chatbot-three.jpeg',
    ],
    techStack: [
      'Flutter',
      'OpenAI Realtime API',
      'ElevenLabs',
      'WebSocket',
      'BLoC'
    ],
    keyFeatures: [
      'OpenAI Realtime API for instant responses',
      'ElevenLabs voice synthesis for natural speech',
      'Streaming responses for minimal latency',
      'Voice activity detection (VAD)',
      'Conversation history & context retention',
      'Multiple voice personas & customization',
    ],
    category: 'AI/ML',
  ),

  // Eris AI - Global Paper Trading
  BestWork(
    name: 'Eris AI - Paper Trading',
    tagline: 'B2B Platform for Global Paper Industry',
    description:
        'Enterprise B2B application serving a global paper trading company. Features real-time bidding, AI-powered chatbot assistance, and comprehensive trading tools that increased transaction efficiency by 30%.',
    status: 'Completed',
    screenshots: [
      'assets/best_works/eris-ai/eris-ai-1.png',
      'assets/best_works/eris-ai/eris-ai-2.png',
      'assets/best_works/eris-ai/eris-ai-3.png',
    ],
    techStack: ['Flutter', 'REST APIs', 'Firebase', 'AI Chatbot', 'BLoC'],
    keyFeatures: [
      'Real-time bidding & auction system',
      'AI Chatbot boosting transactions by 30%',
      '25% reduction in app load time',
      'Multi-currency support for global trade',
      'Document management & verification',
      'Push notifications for bid updates',
    ],
    playStoreLink: 'https://play.google.com/store/apps/details?id=com.erisai',
    category: 'FinTech',
  ),
];
