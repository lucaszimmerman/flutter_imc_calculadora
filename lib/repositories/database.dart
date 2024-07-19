import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

Map<int, String> scripts = {
  1: ''' CREATE TABLE imc (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         nome TEXT,
         idade INTEGER,  
         peso DOUBLE,      
         altura DOUBLE,    
         imc DOUBLE,       
         classificacao TEXT
         );'''
};

class IMCDataBase {
  static Database? _db;

  // Método para obter a instância do banco de dados
  Future<Database> obterDatabase() async {
    if (_db == null) {
      _db = await iniciarBancoDeDados();
    }
    return _db!;
  }

  // Método para iniciar o banco de dados
  Future<Database> iniciarBancoDeDados() async {
    final dbPath = path.join(await getDatabasesPath(), 'database.db');

    // Abre ou cria o banco de dados
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        // Executa os scripts de criação de tabelas
        for (var i = 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          debugPrint('Criando tabela com script: ${scripts[i]!}');
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // Atualiza o banco de dados se a versão mudar
        for (var i = oldVersion + 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          debugPrint('Atualizando banco de dados com script: ${scripts[i]!}');
        }
      },
    );
  }
}
