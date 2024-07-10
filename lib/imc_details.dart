import 'package:flutter/material.dart';
import 'model/imc.dart';

class IMCDetailsPage extends StatelessWidget {
  final IMC imc;

  const IMCDetailsPage({Key? key, required this.imc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${imc.nome}', style: TextStyle(fontSize: 18)),
            Text('Idade: ${imc.idade} anos', style: TextStyle(fontSize: 18)),
            Text('Peso: ${imc.peso} kg', style: TextStyle(fontSize: 18)),
            Text('Altura: ${imc.altura / 100} m',
                style: TextStyle(fontSize: 18)),
            Text('IMC: ${imc.imc.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
            Text('Classificação: ${imc.classificacao}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
