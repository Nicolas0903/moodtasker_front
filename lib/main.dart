import 'package:flutter/material.dart';
import 'pages/courses_page.dart';
import 'pages/history_page.dart';
import 'pages/alerts_page.dart';
import 'pages/register_page.dart';
import 'pages/new_task_page.dart';
import 'pages/projects_page.dart';
import 'pages/mood_check_page.dart';
import 'pages/tasks_list_page.dart';
import 'pages/recommendations_page.dart';

void main() {
  runApp(const MoodTaskerApp());
}

class MoodTaskerApp extends StatelessWidget {
  const MoodTaskerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoodTasker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4CAF50)),
        scaffoldBackgroundColor: const Color(0xFFF2FAF2),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF4CAF50),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/register',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/mood': (context) => const MoodCheckPage(),
        '/home': (context) => const HomePage(),
        '/newtask': (context) => const NewTaskPage(),
        '/projects': (context) => const ProjectsPage(),
        '/recommendations': (context) => const RecommendationsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CoursesPage(), // 🏠
    MoodCheckPage(), // ⚡
    TasksListPage(), // 📅
    HistoryPage(), // 🖼
    ProjectsPage(), // 🔧
  ];

  static const Color _green = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: _green,

            // Íconos sin labels y todos blancos
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedIconTheme: const IconThemeData(size: 24),
            unselectedIconTheme: const IconThemeData(size: 24),

            currentIndex: _currentIndex,
            onTap: (i) {
              if (i == 1) {
                // ⚡ acción (no tab)
                Navigator.pushNamed(context, '/mood');
                return; // no cambiamos pestaña
              }
              setState(() => _currentIndex = i);
            },

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bolt_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_available_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.build_rounded),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
