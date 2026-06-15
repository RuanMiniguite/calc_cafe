class Calculate {
  Calculate._();

  static Map<String, dynamic> calcularSacas(double peso) {
    int quantidadeSacas = (peso / 60).floor();
    double kgRestante = peso % 60;

    return {"quantidadeSacas": quantidadeSacas, "kgRestante": kgRestante};
  }

  static double rendimento(int qtdSaco, double pesoTotal, double tara) {
    return qtdSaco / ((pesoTotal - tara) / 60);
  }

  static double valorPilagem1kg(double valorPilagem) {
    return valorPilagem / 60;
  }

  static double valor1kgcafe(double precoCafe) {
    return precoCafe / 60;
  }

  static double calcularValorPilagem(
    double pesoLiq,
    double valorPilagem,
  ) {

    return pesoLiq * valorPilagem1kg(valorPilagem);
  }

  static double pesoTotalLiq(double pesoTotal, double tara) {
    return pesoTotal - tara;
  }
}
