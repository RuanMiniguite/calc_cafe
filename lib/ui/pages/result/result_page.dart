import 'package:calc_cafe/model/pilagem_model.dart';
import 'package:calc_cafe/ui/components/widgets/info_row.dart';
import 'package:calc_cafe/ui/components/widgets/info_row_saca.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultadoPage extends StatefulWidget {
  final PilagemModel pilagem;

  const ResultadoPage({super.key, required this.pilagem});

  @override
  State<ResultadoPage> createState() => _ResultadoPageState();
}

class _ResultadoPageState extends State<ResultadoPage> {
  PilagemModel get dados => widget.pilagem;

  @override
  Widget build(BuildContext context) {
    final valorTotalPilagem = calcularValorPilagem(
      dados.pesoTotal,
      dados.taraBeg,
      dados.valorPilagem,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EC),

      appBar: AppBar(
        titleSpacing: 0,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calculate_outlined, color: Colors.white),
            SizedBox(width: 5),
            Text("Cálculo da Pilagem"),
          ],
        ),
        backgroundColor: const Color.fromARGB(200, 175, 135, 100),
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // =========================
          // CARD VALORES DO DIA
          // =========================
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.analytics, size: 70, color: Colors.brown),

                  const SizedBox(height: 5),

                  const Text(
                    "Valores do dia",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 20),

                  InfoRow(
                    title: "Data do Dia",
                    value:  DateFormat('dd/MM/yyyy').format(DateTime.now()),
                  ),

                  InfoRow(
                    title: "Preço do Café",
                    value: "R\$ ${dados.precoCafe.toStringAsFixed(2)}",
                  ),

                  InfoRow(
                    title: "Valor 1kg café",
                    value: "R\$ ${valor1kgcafe(dados.precoCafe).toStringAsFixed(2)}",
                  ),

                  InfoRow(
                    title: "Valor da Pilagem 1kg",
                    value: "R\$ ${valorPilagem1kg(dados.valorPilagem).toStringAsFixed(2)}",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // =========================
          // CARD RESUMO
          // =========================
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Resumo",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  InfoRow(
                    title: "Quantidade de Sacos",
                    value: "${dados.quantidadeSacos} sc",
                  ),

                  InfoRow(
                    title: "Rendimento",
                    value: rendimento(
                      dados.quantidadeSacos,
                      dados.pesoTotal,
                      dados.taraBeg,
                    ).toStringAsFixed(2),
                  ),

                  InfoRow(
                    title: "Valor da Pilagem",
                    value: "R\$ ${dados.valorPilagem.toStringAsFixed(2)}",
                  ),

                  InfoRow(
                    title: "Peso Total bruto",
                    value: "${dados.pesoTotal.toStringAsFixed(0)} kg",
                  ),

                  InfoRow(
                    title: "Tara Total do Beg",
                    value: "${dados.taraBeg.toStringAsFixed(0)} kg",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // =========================
          // CARD PILAGEM
          // =========================
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pilagem",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  InfoRowSaca(
                    title:  "Quantidade de Sacas (Liq)",
                    value: "${calcularSacas(dados.pesoTotal - dados.taraBeg)["quantidadeSacas"]} Sc",
                    value2: "${calcularSacas(dados.pesoTotal - dados.taraBeg)["kgRestante"].toStringAsFixed(0)} kg",
                  ),

                  InfoRow(
                    title: "Valor Total da Pilagem",
                    value: "R\$ ${valorTotalPilagem.toStringAsFixed(2)}",
                  ),

                  InfoRowSaca(
                    title: "Peso Total da Pilagem",
                    value: "${calcularSacas(valorTotalPilagem / valor1kgcafe(dados.precoCafe))["quantidadeSacas"]} Sc",
                    value2: "${calcularSacas(valorTotalPilagem / valor1kgcafe(dados.precoCafe))["kgRestante"].toStringAsFixed(0)} kg",
                  ),

                  InfoRowSaca(
                    title: "Quantidade Encostado (Liq)",
                    value: "${calcularSacas((dados.pesoTotal - dados.taraBeg) - (valorTotalPilagem / valor1kgcafe(dados.precoCafe)))["quantidadeSacas"]} Sc",
                    value2: "${calcularSacas((dados.pesoTotal - dados.taraBeg) - (valorTotalPilagem / valor1kgcafe(dados.precoCafe)))["kgRestante"].toStringAsFixed(0)} kg",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // =========================
          // CLIENTE
          // =========================
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "% Peso da Pilagem",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  InfoRow(
                    title: "Valor da divisão %",
                    value: "${dados.percentualColono.toStringAsFixed(0)}%",
                  ),

                  InfoRowSaca(
                    title:  "Sacas ${dados.percentualColono.toInt()}%",
                    value: "${calcularSacas(((dados.pesoTotal - dados.taraBeg) - (valorTotalPilagem / valor1kgcafe(dados.precoCafe))) * (dados.percentualColono / 100))["quantidadeSacas"]} Sc",
                    value2: "${calcularSacas(((dados.pesoTotal - dados.taraBeg) - (valorTotalPilagem / valor1kgcafe(dados.precoCafe))) * (dados.percentualColono / 100))["kgRestante"].toStringAsFixed(0)} kg",
                  ),

                  InfoRowSaca(
                    title:  "Sacas ${100 - dados.percentualColono.toInt()}%",
                    value: "${calcularSacas(((dados.pesoTotal - dados.taraBeg) - (valorTotalPilagem / valor1kgcafe(dados.precoCafe))) * ((100 - dados.percentualColono) / 100))["quantidadeSacas"]} Sc",
                    value2: "${calcularSacas(((dados.pesoTotal - dados.taraBeg) - (valorTotalPilagem / valor1kgcafe(dados.precoCafe))) * ((100 - dados.percentualColono) / 100))["kgRestante"].toStringAsFixed(0)} kg",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> calcularSacas(double peso) {
    int quantidadeSacas = (peso / 60).floor();
    double kgrestante = peso % 60;

    return {"quantidadeSacas": quantidadeSacas, "kgRestante": kgrestante};
  }

  double rendimento(int qtdSaco, double pesoTotal, double tara) {
    return qtdSaco / ((pesoTotal - tara) / 60);
  }

  double valorPilagem1kg(double valorPilagem) => valorPilagem / 60;

  double valor1kgcafe(double precoCafe) => precoCafe / 60;

  double calcularValorPilagem(
    double pesoTotal,
    double tara,
    double valorPilagem,
  ) {
    double pesoLiquido = pesoTotal - tara;
    return pesoLiquido * valorPilagem1kg(valorPilagem);
  }
}