class IMC {
  int _id = 0;
  String _nome = "";
  int _idade = 0;
  double _peso = 0.0;
  double _altura = 0.0; // altura em centímetros
  double _imc = 0.0;
  String _classificacao = "";

  IMC({
    int id = 0,
    String nome = "",
    int idade = 0,
    double peso = 0.0,
    double altura = 0.0,
  }) {
    _id = id;
    _nome = nome;
    _idade = idade;
    _peso = peso;
    _altura = altura;

    // Calculando IMC e classificação
    _calcularIMC();
  }

  void _calcularIMC() {
    if (_altura > 0) {
      double alturaEmMetros = _altura / 100; // Convertendo altura para metros
      _imc = _peso / (alturaEmMetros * alturaEmMetros);
      _classificacao = _classificarIMC(_imc);
    }
  }

  String _classificarIMC(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc < 24.9) {
      return 'Peso normal';
    } else if (imc < 29.9) {
      return 'Sobrepeso';
    } else if (imc < 34.9) {
      return 'Obesidade Grau I';
    } else if (imc < 39.9) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  int get idade => _idade;

  set idade(int idade) {
    _idade = idade;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
    _calcularIMC(); // Recalcular IMC quando o peso muda
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
    _calcularIMC(); // Recalcular IMC quando a altura muda
  }

  double get imc => _imc;

  String get classificacao => _classificacao;

  @override
  String toString() {
    return 'Nome: $_nome, Idade: $_idade anos, IMC: ${_imc.toStringAsFixed(2)} ($_classificacao)';
  }
}
