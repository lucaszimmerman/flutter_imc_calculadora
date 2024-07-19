import 'package:flutter/material.dart';
import 'package:imc_calculadora/page/imc_details_page.dart';
import 'package:imc_calculadora/model/imc.dart';
import 'package:imc_calculadora/repositories/imc_calculator_repository.dart';

class IMCCalculatorPage extends StatefulWidget {
  const IMCCalculatorPage({Key? key}) : super(key: key);

  @override
  State<IMCCalculatorPage> createState() => _IMCCalculatorPageState();
}

class _IMCCalculatorPageState extends State<IMCCalculatorPage> {
  var nomeController = TextEditingController();
  var idadeController = TextEditingController();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  IMCRepository imcRepository = IMCRepository();
  var _imcList = const <IMC>[];

  @override
  void initState() {
    super.initState();
    obterIMCS();
  }

  void obterIMCS() async {
    _imcList = await imcRepository.obterDados();
    setState(() {});
  }

  void _calculateIMC() async {
    // Obtém os valores dos controllers
    final nome = nomeController.text;
    final idade = int.tryParse(idadeController.text) ?? 0;
    final peso = double.tryParse(pesoController.text) ?? 0.0;
    final altura = double.tryParse(alturaController.text) ?? 0.0;

    // Cria um novo objeto IMC
    final imc = IMC(
      nome: nome,
      idade: idade,
      peso: peso,
      altura: altura,
    );

    // Salva no repositório
    await imcRepository.salvar(imc);

    // Atualiza a lista de IMCs
    obterIMCS();

    // Limpa os campos
    nomeController.clear();
    idadeController.clear();
    pesoController.clear();
    alturaController.clear();
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
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: idadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Idade',
              ),
            ),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            TextField(
              controller: alturaController,
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
                      ).then(
                          (_) => obterIMCS()); // Atualiza a lista após voltar
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
