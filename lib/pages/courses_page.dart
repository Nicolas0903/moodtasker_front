import 'package:flutter/material.dart';
import 'task_detail_page.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  static const green = Color(0xFF4CAF50);

  final ScrollController _scrollController = ScrollController();

  final List<_CourseInfo> _allCourses = [
    _CourseInfo(
      name: 'Cálculo 1',
      teacher: 'Nombre del Profesor',
      imagePath: 'assets/images/course_calculo.jpg',
      tasks: const [
        _CourseTask(title: 'Tarea 1 de límites', due: '10/03', urgent: false),
        _CourseTask(title: 'Práctica derivadas', due: '18/03', urgent: true),
      ],
    ),
    _CourseInfo(
      name: 'Programación web',
      teacher: 'Nombre del Profesor',
      imagePath: 'assets/images/course_web.jpg',
      tasks: const [
        _CourseTask(
          title: 'Ensayo de redes sociales',
          due: '12/09',
          urgent: true,
        ),
        _CourseTask(
          title: 'Proyecto final framework',
          due: '25/09',
          urgent: false,
        ),
      ],
    ),
    _CourseInfo(
      name: 'Historia',
      teacher: 'Nombre del Profesor',
      imagePath: 'assets/images/course_historia.jpg',
      tasks: const [
        _CourseTask(
          title: 'Escribir resumen de clase',
          due: '05/04',
          urgent: false,
        ),
      ],
    ),
    // extras para que la flecha tenga sentido
    _CourseInfo(
      name: 'Álgebra Lineal',
      teacher: 'Nombre del Profesor',
      imagePath: 'assets/images/course_algebra.jpg',
      tasks: const [
        _CourseTask(title: 'Guía de matrices', due: '20/03', urgent: false),
      ],
    ),
    _CourseInfo(
      name: 'Introducción a la Economía',
      teacher: 'Nombre del Profesor',
      imagePath: 'assets/images/course_economia.jpg',
      tasks: const [
        _CourseTask(
          title: 'Ensayo sobre oferta y demanda',
          due: '28/03',
          urgent: false,
        ),
      ],
    ),
  ];

  String _query = '';
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  List<_CourseInfo> get _filteredCourses {
    if (_query.trim().isEmpty) return _allCourses;
    final q = _query.toLowerCase();
    return _allCourses.where((c) => c.name.toLowerCase().contains(q)).toList();
  }

  void _toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
      if (!_showSearch) {
        _query = '';
        _searchController.clear();
      }
    });
  }

  void _openCourseDetail(_CourseInfo course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _CourseDetailPage(course: course)),
    );
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'CURSOS 2025-1',
                        style: TextStyle(
                          color: green,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Tarjeta grande con listado de cursos
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Fila con icono de búsqueda
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.search_rounded,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: _toggleSearch,
                                ),
                              ],
                            ),

                            if (_showSearch) ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText: 'Buscar curso...',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _query = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],

                            Column(
                              children: List.generate(_filteredCourses.length, (
                                index,
                              ) {
                                final course = _filteredCourses[index];
                                final number = (index + 1).toString().padLeft(
                                  2,
                                  '0',
                                );

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(14),
                                    onTap: () => _openCourseDetail(course),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.03,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // Imagen del curso
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: SizedBox(
                                                width: 64,
                                                height: 64,
                                                child: Image.asset(
                                                  course.imagePath,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),

                                            // Nombre + profesor
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    course.name,
                                                    style: const TextStyle(
                                                      color: Color(0xFF1E88E5),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    course.teacher,
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(width: 8),
                                            Text(
                                              number,
                                              style: const TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Flecha inferior: hace scroll hacia abajo
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.blueAccent,
                        ),
                        onPressed: _scrollToBottom,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// MODELOS INTERNOS
// ---------------------------------------------------------------------------

class _CourseInfo {
  final String name;
  final String teacher;
  final String imagePath;
  final List<_CourseTask> tasks;

  const _CourseInfo({
    required this.name,
    required this.teacher,
    required this.imagePath,
    required this.tasks,
  });
}

class _CourseTask {
  final String title;
  final String? due;
  final bool urgent;

  const _CourseTask({required this.title, this.due, required this.urgent});
}

// ---------------------------------------------------------------------------
// PANTALLA DE DETALLE DE CURSO (lista de tareas, conectada con UC7)
// ---------------------------------------------------------------------------

class _CourseDetailPage extends StatefulWidget {
  final _CourseInfo course;
  const _CourseDetailPage({required this.course});

  @override
  State<_CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<_CourseDetailPage> {
  static const green = Color(0xFF4CAF50);

  late List<_CourseTask> _tasks;

  @override
  void initState() {
    super.initState();
    // copiamos las tareas para poder mutar la lista local
    _tasks = List<_CourseTask>.from(widget.course.tasks);
  }

  Future<void> _openTaskDetail(int index) async {
    final t = _tasks[index];

    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => TaskDetailPage(
          course: widget.course.name,
          taskTitle: t.title,
          dateText: t.due != null
              ? 'Entrega: ${t.due}'
              : 'Entrega: No estimada',
          stars: t.urgent ? 3 : 1,
        ),
      ),
    );

    if (completed == true) {
      setState(() {
        _tasks.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarea marcada como realizada')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.course.name,
          style: const TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tareas del curso',
                    style: TextStyle(
                      color: green,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _tasks.isEmpty
                        ? const Center(
                            child: Text(
                              'No tienes tareas pendientes en este curso.',
                              style: TextStyle(color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.separated(
                            itemCount: _tasks.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final t = _tasks[index];
                              final iconColor = t.urgent
                                  ? Colors.red
                                  : const Color(0xFF3F7CD7);

                              return InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () => _openTaskDetail(index),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        t.urgent
                                            ? Icons.event_rounded
                                            : Icons.event_available_rounded,
                                        color: iconColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              t.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (t.due != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 2,
                                                ),
                                                child: Text(
                                                  'Entrega: ${t.due}',
                                                  style: TextStyle(
                                                    color: t.urgent
                                                        ? Colors.red
                                                        : Colors.black54,
                                                    fontSize: 12.5,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
