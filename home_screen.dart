import 'package:flutter/material.dart';
import 'task_controller.dart';
import 'tarea.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CtrControlTareas controlador = CtrControlTareas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizador de Tareas'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tareas Pendientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controlador.getTareas().where((t) => !t.esRealizado).length,
              itemBuilder: (context, index) {
                final tarea = controlador.getTareas().where((t) => !t.esRealizado).elementAt(index);
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  color: const Color(0xFFF33574),
                  child: ListTile(
                    title: Text(
                      tarea.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Entrega: ${tarea.fechaEntrega?.toLocal().toString().split(' ')[0]}\nCalificación: ${tarea.fechaCalificacion?.toLocal().toString().split(' ')[0] ?? "No asignada"}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.check),
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          controlador.marcarComoRealizado(tarea.id);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tareas Realizadas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controlador.getTareas().where((t) => t.esRealizado).length,
              itemBuilder: (context, index) {
                final tarea = controlador.getTareas().where((t) => t.esRealizado).elementAt(index);
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.greenAccent,
                  child: ListTile(
                    title: Text(
                      tarea.nombre,
                      style: const TextStyle(decoration: TextDecoration.lineThrough, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Entrega: ${tarea.fechaEntrega?.toLocal().toString().split(' ')[0]}\nCalificación: ${tarea.fechaCalificacion?.toLocal().toString().split(' ')[0] ?? "No asignada"}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          controlador.marcarComoPendiente(tarea.id);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoNuevaTarea,
        tooltip: 'Agregar Tarea',
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarDialogoNuevaTarea() {
    final TextEditingController nombreController = TextEditingController();
    DateTime? fechaEntrega;
    DateTime? fechaCalificacion;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Nueva Tarea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(hintText: 'Nombre de la tarea'),
              ),
              const SizedBox(height: 10),
              _seleccionarFecha('Fecha de Entrega', (fecha) => fechaEntrega = fecha),
              _seleccionarFecha('Fecha de Calificación', (fecha) => fechaCalificacion = fecha),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (nombreController.text.isNotEmpty && fechaEntrega != null) {
                  setState(() {
                    controlador.agregarTarea(Tarea(
                      id: controlador.tareas.length + 1,
                      nombre: nombreController.text,
                      fechaEntrega: fechaEntrega,
                      fechaCalificacion: fechaCalificacion,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Agregar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Widget _seleccionarFecha(String texto, Function(DateTime?) callback) {
    return TextButton(
      onPressed: () async {
        final fecha = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );
        if (fecha != null) setState(() => callback(fecha));
      },
      child: Text(texto),
    );
  }
}
