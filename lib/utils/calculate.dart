class Calculate {
  Calculate._();

  static Map<String, dynamic> calcularSacas(double peso) {
    int quantidadeSacas = (peso / 60).floor();
    double kgRestante = peso % 60;

    return {
      "quantidadeSacas": quantidadeSacas,
      "kgRestante": kgRestante,
    };
  }

  static double rendimento(
    int qtdSaco,
    double pesoTotal,
    double tara,
  ) {
    return qtdSaco / ((pesoTotal - tara) / 60);
  }

  static double valorPilagem1kg(double valorPilagem) {
    return valorPilagem / 60;
  }

  static double valor1kgcafe(double precoCafe) {
    return precoCafe / 60;
  }

  static double calcularValorPilagem(
    double pesoTotal,
    double tara,
    double valorPilagem,
  ) {
    final pesoLiquido = pesoTotal - tara;

    return pesoLiquido * valorPilagem1kg(valorPilagem);
  }
}