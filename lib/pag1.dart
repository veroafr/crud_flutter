import 'package:app_bd/estudiante.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CRUD Estudiantes',
      home: Pag1(),
    );
  }
}

class Pag1 extends StatefulWidget {
  const Pag1({super.key});

  @override
  State<Pag1> createState() => _Pag1State();
}

class _Pag1State extends State<Pag1> {
  final _controllerNome = TextEditingController();
  final _controllerMatricula = TextEditingController();
  List<Estudiante> _listaEstudiantes = [];

  @override
  void dispose() {
    _controllerNome.dispose();
    _controllerMatricula.dispose();
    super.dispose();
  }

  void _salvarEstudante() {
    final nome = _controllerNome.text.trim();
    final matricula = _controllerMatricula.text.trim();

    if (nome.isEmpty || matricula.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    setState(() {
      _listaEstudiantes.add(Estudiante(nome: nome, matricula: matricula));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Estudante salvo')),
    );

    _controllerNome.clear();
    _controllerMatricula.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Estudiantes'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerNome,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _controllerMatricula,
              decoration: const InputDecoration(
                labelText: "Matricula",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                onPressed: _salvarEstudante,
                child: const Text('Salvar'),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _listaEstudiantes.length,
                itemBuilder: (context, index) {
                  final estudiante = _listaEstudiantes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(estudiante.nome),
                      subtitle: Text('Matrícula: ${estudiante.matricula}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
