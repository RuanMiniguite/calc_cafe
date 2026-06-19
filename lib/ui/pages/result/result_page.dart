 import 'package:calc_cafe/model/pilagem_model.dart';
import 'package:calc_cafe/ui/components/widgets/info_row.dart';
import 'package:calc_cafe/ui/components/widgets/info_row_saca.dart';
import 'package:calc_cafe/ui/pages/result/pesos_begs_page.dart';
import 'package:calc_cafe/utils/calculate.dart';
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
  
    return Scaffold(
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

      body: PageView(
        children: [
          _paginaResultado(),

          PesosBegsPage(pilagem: dados),
        ],
      ),
    );
  }

  Widget _paginaResultado() {
    final pesoTotalLiq = Calculate.pesoTotalLiq(dados.pesoTotal, dados.taraBeg);
    final valorTotalPilagem = Calculate.calcularValorPilagem(
      pesoTotalLiq,
      dados.valorPilagem,
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // =========================
        // CARD VALORES DO DIA
        // =========================
        Card(
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
                  value: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                ),

                InfoRow(
                  title: "Valor da Saca de Café",
                  value: "R\$ ${dados.precoCafe.toStringAsFixed(2)}",
                ),

                InfoRow(
                  title: "Valor de 1kg Café",
                  value:
                      "R\$ ${Calculate.valor1kgcafe(dados.precoCafe).toStringAsFixed(2)}",
                ),

                InfoRow(
                  title: "Valor da Pilagem",
                  value: "R\$ ${dados.valorPilagem.toStringAsFixed(2)}",
                ),

                InfoRow(
                  title: "Valor da Pilagem 1kg",
                  value:
                      "R\$ ${Calculate.valorPilagem1kg(dados.valorPilagem).toStringAsFixed(2)}",
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
                  value: Calculate.rendimento(
                    dados.quantidadeSacos,
                    dados.pesoTotal,
                    dados.taraBeg,
                  ).toStringAsFixed(2),
                ),

                InfoRow(
                  title: "Peso Total (Bruto)",
                  value: "${dados.pesoTotal.toStringAsFixed(0)} kg",
                ),

                InfoRow(
                  title: "Tara Total dos Begs",
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
                  title: "Total de Sacas (Liq)",
                  value:
                      "${Calculate.calcularSacas(pesoTotalLiq)["quantidadeSacas"]} Sc",
                  value2:
                      "${Calculate.calcularSacas(pesoTotalLiq)["kgRestante"].toStringAsFixed(0)} kg",
                ),

                InfoRow(
                  title: "Valor Total da Pilagem",
                  value: "R\$ ${valorTotalPilagem.toStringAsFixed(2)}",
                ),

                InfoRowSaca(
                  title: "Peso Total da Pilagem",
                  value:
                      "${Calculate.calcularSacas(valorTotalPilagem / Calculate.valor1kgcafe(dados.precoCafe))["quantidadeSacas"]} Sc",
                  value2:
                      "${Calculate.calcularSacas(valorTotalPilagem / Calculate.valor1kgcafe(dados.precoCafe))["kgRestante"].toStringAsFixed(0)} kg",
                ),

                InfoRowSaca(
                  title: "Total de Sacas Encostado (Liq)",
                  value:
                      "${Calculate.calcularSacas((pesoTotalLiq) - (valorTotalPilagem / Calculate.valor1kgcafe(dados.precoCafe)))["quantidadeSacas"]} Sc",
                  value2:
                      "${Calculate.calcularSacas((pesoTotalLiq) - (valorTotalPilagem / Calculate.valor1kgcafe(dados.precoCafe)))["kgRestante"].toStringAsFixed(0)} kg",
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // =========================
        // DIVISÃO DA PILAGEM
        // =========================
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Divisão da Pilagem",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                InfoRow(
                  title: "Valor da divisão %",
                  value: "${dados.percentualColono.toStringAsFixed(0)}%",
                ),

                InfoRowSaca(
                  title: "Sacas ${dados.percentualColono.toInt()}%",
                  value:
                      "${Calculate.calcularSacas(((pesoTotalLiq) - (valorTotalPilagem / Calculate.valor1kgcafe(dados.precoCafe))) * (dados.percentualColono / 100))["quantidadeSacas"]} Sc",
                  value2:
                      "${Calculate.calcularSacas(((pesoTotalLiq) - (valorTotalPilagem / Calculate.valor1kgcafe(dados.precoCafe))) * (dados.percentualColono / 100))["kgRestante"].toStringAsFixed(2)} kg",
                ),

                InfoRowSaca(
                  title: "Sacas ${100 - dados.percentualColono.toInt()}%",
                  value:
                      "${Calculate.calcularSacas(((pesoTotalLiq) - (valorTotalPilagem / Calculate.valor1kgcafe(dados.precoCafe))) * ((100 - dados.percentualColono) / 100))["quantidadeSacas"]} Sc",
                  value2:
                      "${Calculate.calcularSacas(((pesoTotalLiq) - (valorTotalPilagem / Calculate.valor1kgcafe(dados.precoCafe))) * ((100 - dados.percentualColono) / 100))["kgRestante"].toStringAsFixed(2)} kg",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
