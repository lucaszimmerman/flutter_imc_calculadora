class IMC {
  final String nome;
  final int idade;
  final double peso;
  final double altura; // altura em centímetros
  late double imc;
  late String classificacao;

  IMC(
      {required this.nome,
      required this.idade,
      required this.peso,
      required this.altura}) {
    double alturaEmMetros = altura / 100; // Convertendo altura para metros
    imc = peso / (alturaEmMetros * alturaEmMetros);
    classificacao = _classificarIMC(imc);
    print('IMC calculado: $imc, Classificação: $classificacao');
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

  @override
  String toString() {
    return 'Nome: $nome, Idade: $idade anos, IMC: ${imc.toStringAsFixed(2)} ($classificacao)';
  }
}
