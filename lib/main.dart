import 'package:flutter/material.dart';
import 'pages/courses_page.dart';
import 'pages/history_page.dart';
import 'pages/alerts_page.dart';
import 'pages/register_page.dart';
import 'pages/new_task_page.dart';
import 'pages/projects_page.dart';

void main () {
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
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF2FAF2),
        useMaterial3: true,
      ),
      initialRoute: '/register',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/newtask': (context) => const NewTaskPage(),
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
    CoursesPage(),
    HistoryPage(),
    AlertsPage(),
    ProjectsPage(),
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.bar_chart,
    Icons.notifications,
    Icons.work,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.green,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
         // BottomNavigationBarItem(icon: Icon(Icons.work), label: ''),

        ],
      ),
    );
  }
}
