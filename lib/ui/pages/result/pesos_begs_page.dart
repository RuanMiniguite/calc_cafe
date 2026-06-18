import 'package:flutter/material.dart';
import 'package:calc_cafe/model/pilagem_model.dart';

class PesosBegsPage extends StatefulWidget {
  final PilagemModel pilagem;

  const PesosBegsPage({super.key, required this.pilagem});

  @override
  State<PesosBegsPage> createState() => _PesosBegsPageState();
}

class _PesosBegsPageState extends State<PesosBegsPage> {
  late List<double> pesosBegs;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    pesosBegs = List<double>.from(widget.pilagem.pesosBeg);

    controllers = pesosBegs
        .map((peso) => TextEditingController(text: peso.toStringAsFixed(0)))
        .toList();
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double get pesoLiquido {
    return widget.pilagem.pesoTotal - widget.pilagem.taraBeg;
  }

  double get totalBegs {
    if (pesosBegs.length <= 1) return 0;

    return pesosBegs.skip(1).fold(0.0, (soma, peso) => soma + peso);
  }

  double get diferenca {
    return totalBegs - pesoEncostado - widget.pilagem.taraBeg;
  }

  double get pesoEncostado {
    final valorPilagemKg = widget.pilagem.valorPilagem / 60;
    final valorCafeKg = widget.pilagem.precoCafe / 60;

    if (valorCafeKg == 0) return 0;

    final valorTotalPilagem = pesoLiquido * valorPilagemKg;

    return pesoLiquido - (valorTotalPilagem / valorCafeKg);
  }

  void _removerBeg(int index) {
    setState(() {
      controllers[index].dispose();
      controllers.removeAt(index);
      pesosBegs.removeAt(index);
    });
  }

  void _apagarTodos() {
    setState(() {
      for (final controller in controllers) {
        controller.dispose();
      }

      controllers.clear();
      pesosBegs.clear();
    });
  }

  void _adicionarBeg() {
    setState(() {
      pesosBegs.add(0);

      controllers.add(TextEditingController(text: "0"));
    });
  }

  Color get colorBorder {
  return diferenca.round() == 0
      ? Colors.green
      : Colors.red;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: Color.fromARGB(200, 175, 135, 100),
                width: 1,
              ),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color.fromARGB(
                            200,
                            175,
                            135,
                            100,
                          ),
                        ),
                        onPressed: _adicionarBeg,
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text("Adicionar"),
                      ),

                      const SizedBox(width: 8),

                      if (pesosBegs.isNotEmpty)
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: const Color.fromARGB(
                              200,
                              175,
                              135,
                              100,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: const Color(0xFFF5F1EC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                    color: Color.fromARGB(200, 175, 135, 100),
                                  ),
                                ),
                                title: const Text(
                                  "Apagar Todos",
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text(
                                  "Deseja remover todos os Begs?",
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.brown,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancelar"),
                                  ),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                        200,
                                        175,
                                        135,
                                        100,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _apagarTodos();
                                    },
                                    child: const Text("Apagar"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete_sweep),
                          label: const Text("Apagar Todos"),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  if (pesosBegs.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Nenhum peso informado."),
                    ),

                  ...List.generate(
                    pesosBegs.length > 1 ? pesosBegs.length - 1 : 0,
                    (i) {
                      final index = i + 1; // começa no segundo Beg

                      final peso = pesosBegs[index];

                      final taraPorBeg = (pesosBegs.length - 1) > 0
                          ? widget.pilagem.taraBeg / (pesosBegs.length - 1)
                          : 0;

                      final pesoLiquidoBeg = peso - taraPorBeg;

                      final sacas = (pesoLiquidoBeg / 60).floor();
                      final kg = pesoLiquidoBeg % 60;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color.fromARGB(80, 175, 135, 100),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: const Color.fromARGB(
                                      200,
                                      175,
                                      135,
                                      100,
                                    ),
                                    child: Text(
                                      "$index",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Text(
                                      "Beg $index",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    tooltip: 'Excluir Beg',
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          backgroundColor: const Color(
                                            0xFFF5F1EC,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            side: const BorderSide(
                                              color: Color.fromARGB(
                                                200,
                                                175,
                                                135,
                                                100,
                                              ),
                                            ),
                                          ),
                                          title: const Text(
                                            "Excluir Beg",
                                            style: TextStyle(
                                              color: Colors.brown,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: Text(
                                            "Deseja remover o Beg ${index + 1}?",
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.brown,
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Cancelar"),
                                            ),
                                            FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                      200,
                                                      175,
                                                      135,
                                                      100,
                                                    ),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _removerBeg(index);
                                              },
                                              child: const Text("Excluir"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              TextFormField(
                                controller: controllers[index],
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                decoration: const InputDecoration(
                                  labelText: "Peso Bruto do Beg",
                                  suffixText: "kg",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    pesosBegs[index] =
                                        double.tryParse(
                                          value.replaceAll(',', '.'),
                                        ) ??
                                        0;
                                  });
                                },
                              ),

                              const SizedBox(height: 10),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      30,
                                      175,
                                      135,
                                      100,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "$sacas Sc ${kg.toStringAsFixed(0)} kg",
                                    style: const TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: colorBorder, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  _infoRow(
                    "Peso Liquido dos Begs",
                    "${(totalBegs - widget.pilagem.taraBeg).toStringAsFixed(0)} kg",
                  ),

                  _infoRow(
                    "Peso Liquido Encostado",
                    "${pesoEncostado.toStringAsFixed(0)} kg",
                  ),

                  const Divider(),
                
                  _infoRow("Diferença", "${diferenca.toStringAsFixed(0)} kg"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
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
}
