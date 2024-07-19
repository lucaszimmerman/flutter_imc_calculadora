import 'package:imc_calculadora/model/imc.dart';
import 'package:imc_calculadora/repositories/database.dart';

class IMCRepository {
  Future<List<IMC>> obterDados() async {
    List<IMC> imcs = [];
    var db = await IMCDataBase().obterDatabase();
    var result = await db.rawQuery(
        'SELECT id, nome, idade, peso, altura, imc, classificacao FROM imc');
    for (var element in result) {
      imcs.add(IMC(
        id: element["id"] as int,
        nome: element["nome"] as String,
        idade: element["idade"] as int,
        peso: element["peso"] as double,
        altura: element["altura"] as double,
      ));
    }
    return imcs;
  }

  Future<void> salvar(IMC imc) async {
    var db = await IMCDataBase().obterDatabase();
    await db.rawInsert(
      'INSERT INTO imc (nome, idade, peso, altura, imc, classificacao) VALUES (?, ?, ?, ?, ?, ?)',
      [imc.nome, imc.idade, imc.peso, imc.altura, imc.imc, imc.classificacao],
    );
  }

  Future<void> atualizar(IMC imc) async {
    var db = await IMCDataBase().obterDatabase();
    await db.rawUpdate(
      'UPDATE imc SET nome = ?, idade = ?, peso = ?, altura = ?, imc = ?, classificacao = ? WHERE id = ?',
      [
        imc.nome,
        imc.idade,
        imc.peso,
        imc.altura,
        imc.imc,
        imc.classificacao,
        imc.id
      ],
    );
  }

  Future<void> remover(int id) async {
    var db = await IMCDataBase().obterDatabase();
    await db.rawDelete('DELETE FROM imc WHERE id = ?', [id]);
  }
}
