import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const TaskOrganizerApp());
}

class TaskOrganizerApp extends StatelessWidget {
  const TaskOrganizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizador de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFFFF0F5),
      ),
      home: const HomeScreen(),
    );
  }
}
