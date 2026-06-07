class PilagemModel {
  final double pesoTotal;
  final double valorPilagem;
  final double precoCafe;
  final int quantidadeSacos;
  final double taraBeg;
  final List<double> pesosBeg;
  final double percentualColono;

  const PilagemModel({
    required this.pesoTotal,
    required this.valorPilagem,
    required this.precoCafe,
    required this.quantidadeSacos,
    required this.taraBeg,
    required this.pesosBeg,
    required this.percentualColono,
  });
}