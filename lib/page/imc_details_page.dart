import 'package:flutter/material.dart';
import 'package:imc_calculadora/model/imc.dart';
import 'package:imc_calculadora/repositories/imc_calculator_repository.dart';

class IMCDetailsPage extends StatefulWidget {
  final IMC imc;

  const IMCDetailsPage({Key? key, required this.imc}) : super(key: key);

  @override
  State<IMCDetailsPage> createState() => _IMCDetailsPageState();
}

class _IMCDetailsPageState extends State<IMCDetailsPage> {
  late TextEditingController nomeController;
  late TextEditingController idadeController;
  late TextEditingController pesoController;
  late TextEditingController alturaController;
  final IMCRepository imcRepository = IMCRepository();

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.imc.nome);
    idadeController = TextEditingController(text: widget.imc.idade.toString());
    pesoController = TextEditingController(text: widget.imc.peso.toString());
    alturaController =
        TextEditingController(text: widget.imc.altura.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do IMC'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await imcRepository.remover(widget.imc.id);
              Navigator.pop(context);
            },
          ),
        ],
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
              onPressed: () async {
                final updatedIMC = IMC(
                  id: widget.imc.id,
                  nome: nomeController.text,
                  idade: int.tryParse(idadeController.text) ?? 0,
                  peso: double.tryParse(pesoController.text) ?? 0.0,
                  altura: double.tryParse(alturaController.text) ?? 0.0,
                );

                await imcRepository.atualizar(updatedIMC);
                Navigator.pop(context);
              },
              child: Text('Atualizar IMC'),
            ),
          ],
        ),
      ),
    );
  }
}
