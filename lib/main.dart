import 'package:flutter/material.dart';
import 'model/imc.dart';
import 'imc_details.dart';

void main() {
  runApp(IMCCalculatorApp());
}

class IMCCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IMCCalculatorPage(),
    );
  }
}

class IMCCalculatorPage extends StatefulWidget {
  @override
  _IMCCalculatorPageState createState() => _IMCCalculatorPageState();
}

class _IMCCalculatorPageState extends State<IMCCalculatorPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final List<IMC> _imcList = [];

  void _calculateIMC() {
    final String nome = _nomeController.text.trim();
    final int idade = int.tryParse(_idadeController.text) ?? 0;
    final double peso = double.tryParse(_pesoController.text) ?? 0;
    final double altura = double.tryParse(_alturaController.text) ?? 0;

    print('Nome: $nome');
    print('Idade: $idade');
    print('Peso: $peso');
    print('Altura: $altura');

    if (nome.isNotEmpty && idade > 0 && peso > 0 && altura > 0) {
      final IMC imc = IMC(nome: nome, idade: idade, peso: peso, altura: altura);
      print('IMC: ${imc.imc}, Classificação: ${imc.classificacao}');
      setState(() {
        _imcList.add(imc);
      });

      _nomeController.clear();
      _idadeController.clear();
      _pesoController.clear();
      _alturaController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insira valores válidos para todos os campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.fitness_center),
            SizedBox(width: 10),
            Text('Calculadora de IMC'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Idade',
              ),
            ),
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateIMC,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _imcList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_imcList[index].toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              IMCDetailsPage(imc: _imcList[index]),
                        ),
                      );
                    },
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
