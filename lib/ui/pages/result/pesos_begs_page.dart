import 'package:calc_cafe/ui/components/widgets/info_row.dart';
import 'package:calc_cafe/ui/components/widgets/info_row_saca.dart';
import 'package:flutter/material.dart';
import 'package:calc_cafe/model/pilagem_model.dart';

class PesosBegsPage extends StatelessWidget {
  final PilagemModel pilagem;

  const PesosBegsPage({super.key, required this.pilagem});

  @override
  Widget build(BuildContext context) {
    final totalPesos = pilagem.pesosBeg.fold(
      0.0,
      (total, peso) => total + peso,
    );

    final pesoLiquido = pilagem.pesoTotal - pilagem.taraBeg;
    final valorPilagemKg = pilagem.valorPilagem / 60;
    final valorCafeKg = pilagem.precoCafe / 60;
    final valorTotalPilagem = pesoLiquido * valorPilagemKg;
    final pesoEncostado = pesoLiquido - (valorTotalPilagem / valorCafeKg);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EC),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Color.fromARGB(200, 175, 135, 100),
                width: 1,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.inventory_2, size: 70, color: Colors.brown),

                  const SizedBox(height: 10),

                  const Text(
                    "Pesos dos Begs",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  if (pilagem.pesosBeg.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Nenhum peso informado."),
                    ),

                  ...pilagem.pesosBeg.asMap().entries.map((entry) {
                    final index = entry.key;
                    final peso = entry.value;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text("Beg ${index + 1}"),
                        trailing: Text(
                          "${peso.toStringAsFixed(0)} kg",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(
                    "Total Encostado (Liq)",
                    _formatarSacas(pesoEncostado),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatarSacas(double peso) {
    final sacas = (peso / 60).floor();
    final kg = peso % 60;

    return "$sacas Sc + ${kg.toStringAsFixed(0)} kg";
  }
}
