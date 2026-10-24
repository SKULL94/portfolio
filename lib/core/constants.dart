class AppConstants {
  static const String name = 'Md Zeeshan Haider';
  static const String title = 'Senior Flutter Developer';
  static const String yearsOfExperience = '4.8+';
  static const String subtitle = '$yearsOfExperience Years of Experience';
  static const String email = 'Zeeshanhaider794@gmail.com';
  static const String phone = '+91-7250497748';
  static const String location = 'Noida, India';
  static const String linkedIn =
      'https://www.linkedin.com/in/md-zeeshan-haider-6a5246349/';
  static const String github = 'https://github.com/SKULL94';

  static const String aboutMe = '''
Flutter developer with 4.8+ years across product- and service-based companies, with end-to-end ownership from architecture through deployment.

Proven ability to ship scalable mobile products (10K+ downloads, 2,500+ DAU) and to design AI-integration pipelines, including multilingual voice assistants and LLM integration.

Now extending into full-stack development: building Mettle, an AI mock-interview platform that pairs a Flutter client with a FastAPI + LangGraph backend. I use AI coding tools (GitHub Copilot, Claude) in day-to-day development.
''';

  static const List<String> animatedTexts = [
    'Flutter Developer',
    'Mobile App Architect',
    'AI Integration Engineer',
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
    category: 'Languages & Platforms',
    items: ['Flutter', 'Dart', 'Android', 'iOS', 'Web App'],
    icon: 'code',
  ),
  Skill(
    category: 'State Management',
    items: ['BLoC / Cubit', 'Provider', 'GetX'],
    icon: 'layers',
  ),
  Skill(
    category: 'Architecture',
    items: [
      'Clean Architecture',
      'MVVM',
      'Modular Codebase',
      'GetIt (DI)',
      'GoRouter',
    ],
    icon: 'architecture',
  ),
  Skill(
    category: 'Backend',
    items: [
      'REST APIs',
      'Firebase (Auth, Firestore)',
      'Supabase',
      'FastAPI (learning)',
    ],
    icon: 'cloud',
  ),
  Skill(
    category: 'AI Integration',
    items: [
      'On-Prem / On-Device / Cloud AI',
      'LLM Tool-Calling & Prompting',
      'Multilingual Voice Pipelines',
      'LangGraph Agents (learning)',
    ],
    icon: 'smart_toy',
  ),
  Skill(
    category: 'CI/CD & Tooling',
    items: [
      'GitHub Actions',
      'Git',
      'GitHub',
      'AI-Assisted Dev (Copilot, Claude)',
    ],
    icon: 'build',
  ),
  Skill(
    category: 'Other',
    items: [
      'Pixel-Perfect Responsive UI',
      'Platform Channels',
      'Navigator 2.0',
      'Streams / Reactive Programming',
      'Animations (Rive, Lottie, native)',
      'Performance Optimization',
      'Agile Development',
    ],
    icon: 'tune',
  ),
];

class Experience {
  final String company;
  final String role;
  final String duration;
  final String summary;
  final List<Project> projects;

  const Experience({
    required this.company,
    required this.role,
    required this.duration,
    this.summary = '',
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
    summary:
        'Sole architecture owner across all four projects below, from tech-stack and state-management choices through data flow, integration design and release.',
    projects: [
      Project(
        name: 'Coffee AI Assistant App',
        description:
            'AI voice assistant that guides users step-by-step through brewing coffee',
        highlights: [
          'Step-by-step voice guidance across multiple brew methods',
          'Handles both scale-based and no-scale brewing flows',
          'Coffee bean ordering placed through conversation',
          'Architected the voice pipeline and brew-session state machine, keeping timers, TTS and voice input in sync',
        ],
      ),
      Project(
        name: 'Smartwatch Health App',
        description: 'BLE-connected smartwatch application for health tracking',
        highlights: [
          'End-to-end development of the smartwatch app',
          'Real-time BLE sync of heart rate, SpO2, calories and step count',
          'User-friendly health data visualization',
          'Stream-based repository separating device layer from UI, handling reconnection and data buffering',
        ],
      ),
      Project(
        name: 'Agricultural Advisory Voice Chatbot (MVP)',
        description:
            'MVP AI voice assistant for Punjab farmers, in Hindi, English and Punjabi',
        highlights: [
          'Answers queries on agricultural issues and government schemes',
          'Multilingual support across Hindi, English and Punjabi',
          'Owned the speech-to-text to LLM to text-to-speech voice pipeline',
          'Designed language routing and the API integration',
        ],
      ),
      Project(
        name: 'Cricket Live Streaming App',
        description: 'Live cricket streaming with real-time overlays',
        highlights: [
          'Real-time score ticker and match-highlight overlays',
          'YouTube and other streaming channel integration',
          'Designed the overlay architecture from live score data to rendered stream overlays',
          'Low-latency update pipeline',
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
        name: 'Eris AI - Global Paper Trading',
        description: 'B2B app for a global paper trading company',
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.attention.eris',
        highlights: [
          'Refactored and optimized legacy code, reducing app load time by 25%',
          'Integrated real-time bidding',
          'AI chatbot integration boosting user transactions by 30%',
        ],
      ),
      Project(
        name: 'Tennis Booking App',
        description: 'Court reservation and slot management',
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.app.m3mtennis',
        highlights: [
          'Court reservation flow with real-time availability updates',
          'Push-notification-driven booking',
        ],
      ),
      Project(
        name: 'LHC Connect - Open Marketplace for CAs',
        description: 'Tax-filing platform for CAs and end users',
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.attention.lhc',
        highlights: [
          'Single-handedly designed and built the full UI/UX',
          'Complete API integration for the tax-filing platform',
          'Role-based dashboards for admins, CAs and end users',
        ],
      ),
    ],
  ),
  Experience(
    company: 'Triptam Labs Private Limited',
    role: 'Flutter Developer',
    duration: 'Jan 2022 - Oct 2023',
    projects: [
      Project(
        name: 'Helppr.ai - UPSC Learning App',
        description: 'Self-learning mobile app for UPSC preparation',
        playStoreLink:
            'https://play.google.com/store/apps/dev?id=7971218242887866811&hl=en_IN',
        highlights: [
          'Developed core features for a UPSC self-learning app',
          '10K+ users with 2,500+ Daily Active Users',
          'Cross-platform across Android, iOS and Web',
          'Agile sprints with bug-free releases delivered on schedule',
        ],
      ),
    ],
  ),
];

const List<Project> personalProjects = [
  Project(
    name: 'Mettle',
    description:
        'AI mock interviews for mobile engineers - rubric-scored practice with progress tracking (in progress)',
    githubLink: 'https://github.com/SKULL94/mettle',
    isPersonal: true,
    highlights: [
      'Monorepo: Flutter client built, FastAPI + LangGraph backend in progress',
      'Clean Architecture with BLoC, GetIt and GoRouter',
      'Splash, home dashboard, streaming interview and rubric scorecard screens, each handling loading, empty, error and loaded states',
      'Custom-painted score ring and sparkline',
      'LangGraph state machine: conditional follow-up routing on weak answers, interrupt-based answer wait, checkpointed session resume',
      'Versioned SSE event protocol; client currently runs against a scripted source that mirrors it',
    ],
  ),
  Project(
    name: 'FreshCart',
    description: 'Grocery shopping app with modern UI',
    githubLink: 'https://github.com/SKULL94/fresh-cart-grocery',
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
  // Mettle - Personal full-stack project (Top Priority)
  BestWork(
    name: 'Mettle',
    tagline: 'AI Mock Interviews for Mobile Engineers',
    description:
        'Personal full-stack project, currently in progress, pairing a Flutter client with a FastAPI + LangGraph backend. Runs rubric-scored mock interviews with streaming questions, conditional follow-ups on weak answers, and progress tracking across sessions. Screens below are from the in-progress design.',
    status: 'In Progress',
    screenshots: [
      'assets/best_works/mettle/mettle-one.png',
      'assets/best_works/mettle/mettle-two.png',
      'assets/best_works/mettle/mettle-three.png',
    ],
    techStack: [
      'Flutter',
      'BLoC',
      'GetIt',
      'GoRouter',
      'FastAPI',
      'LangGraph',
      'SSE',
    ],
    keyFeatures: [
      'Monorepo: Flutter client built, FastAPI + LangGraph backend in progress',
      'Clean Architecture with BLoC, GetIt and GoRouter',
      'Splash, home dashboard, streaming interview and rubric scorecard screens',
      'Every screen handles loading, empty, error and loaded states',
      'Custom-painted score ring and sparkline',
      'LangGraph state machine with interrupt-based answer wait and checkpointed session resume',
    ],
    futurePlans: [
      'Wire the Flutter client to the live FastAPI + LangGraph backend',
      'Expand the rubric with role- and seniority-specific question banks',
      'Session history and long-term progress analytics',
    ],
    githubLink: 'https://github.com/SKULL94/mettle',
    category: 'AI/ML',
  ),

  // Birch Coffee - AI voice brewing assistant
  BestWork(
    name: 'Birch Coffee',
    tagline: 'Brew Buddy - Voice-Guided AI Brewing Assistant',
    description:
        'Vinny, an AI barista that walks users step-by-step through brewing coffee across five brew methods, handling both smart-scale and no-scale flows, and taking coffee bean orders through conversation. Architected the full voice pipeline and the brew-session state machine that keeps step timers, speech output and voice input in sync.',
    status: 'Completed',
    screenshots: [
      'assets/best_works/birch/birch-one.jpeg',
      'assets/best_works/birch/birch-two.jpeg',
      'assets/best_works/birch/birch-three.jpeg',
    ],
    techStack: [
      'Flutter',
      'BLoC',
      'GetIt',
      'GoRouter',
      'Claude API',
      'ElevenLabs',
      'BLE',
      'Firebase',
    ],
    keyFeatures: [
      'Step-by-step voice guidance across V60, Chemex, Kalita, AeroPress and French Press',
      'Parallel scale-connected and no-scale brewing flows',
      'Brew-session state machine driving live step timers and pour targets',
      'BLE smart-scale pairing, streaming weight readings straight into pour steps',
      'Conversational ordering - place, recommend and cancel orders by voice',
      'Camera-based grind checker backed by a vision model',
      'Realtime speech-to-text with streaming text-to-speech playback',
      'In-context coffee facts surfaced while a brew is steeping',
    ],
    category: 'AI/ML',
  ),

  // Sales Calling App
  BestWork(
    name: 'Sales Calling App',
    tagline: 'AI-Powered Sales Acceleration Platform',
    description:
        'Enterprise-grade sales calling solution enabling Lead Consultants (LCs) to efficiently manage and convert leads. The app supports both CPaaS integration and direct SIM calling, with real-time audio streaming and intelligent lead management.',
    status: 'Completed',
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

  // Agricultural Advisory Voice Chatbot
  BestWork(
    name: 'Agricultural Advisory Voice Chatbot',
    tagline: 'Multilingual AI Voice Assistant for Punjab Farmers',
    description:
        'MVP AI voice assistant that answers farmer queries on agricultural issues and government schemes in Hindi, English and Punjabi. Owned the full speech-to-text to LLM to text-to-speech pipeline, including language routing and API integration design.',
    status: 'Completed',
    screenshots: [
      'assets/best_works/ai-voice/chatbot-one.jpeg',
      'assets/best_works/ai-voice/chatbot-two.jpeg',
      'assets/best_works/ai-voice/chatbot-three.jpeg',
    ],
    techStack: ['Flutter', 'Speech-to-Text', 'LLM', 'Text-to-Speech', 'BLoC'],
    keyFeatures: [
      'Voice queries answered in Hindi, English and Punjabi',
      'Speech-to-text to LLM to text-to-speech voice pipeline',
      'Language routing across the three supported languages',
      'Guidance on agricultural issues and government schemes',
      'Crop diagnosis flow with image upload',
      'Weather and farming guidance on the home dashboard',
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
    playStoreLink:
        'https://play.google.com/store/apps/details?id=com.attention.eris',
    category: 'FinTech',
  ),
];
