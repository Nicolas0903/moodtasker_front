import 'package:flutter/material.dart';
import 'pages/courses_page.dart';
import 'pages/history_page.dart';
import 'pages/alerts_page.dart';
import 'pages/register_page.dart';
import 'pages/new_task_page.dart';

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
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.bar_chart,
    Icons.notifications,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      // ✅ Botón flotante para registrar nueva tarea
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushNamed(context, '/newtask');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ✅ Barra inferior de navegación
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            final isSelected = index == _currentIndex;
            return IconButton(
              onPressed: () => setState(() => _currentIndex = index),
              icon: Icon(
                _icons[index],
                color: isSelected ? Colors.white : Colors.white70,
              ),
            );
          }),
        ),
      ),
    );
  }
}
