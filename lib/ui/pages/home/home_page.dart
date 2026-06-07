import 'package:calc_cafe/model/pilagem_model.dart';
import 'package:calc_cafe/ui/components/widgets/integer_field.dart';
import 'package:calc_cafe/ui/components/widgets/weigh_field.dart';
import 'package:calc_cafe/ui/pages/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:calc_cafe/ui/components/widgets/money_field.dart';
import 'package:calc_cafe/ui/components/widgets/title_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final precoController = TextEditingController();
  final valorPilagemController = TextEditingController();
  final quantidadeSacosController = TextEditingController();
  final taraController = TextEditingController();
  final percentualColonoController = TextEditingController();
  final List<TextEditingController> pesosBeg = [];

  @override
  void initState() {
    super.initState();
    percentualColonoController.text = '100';
    carregarCampos();
  }

  @override
  void dispose() {
    precoController.dispose();
    valorPilagemController.dispose();
    quantidadeSacosController.dispose();
    taraController.dispose();
    percentualColonoController.dispose();

    for (var c in pesosBeg) {
      c.dispose();
    }

    super.dispose();
  }
  
  // =========================
  // TELA
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.coffee, color: Colors.white),
            SizedBox(width: 8),
            Text('Pilagem de Café'),
          ],
        ),
        backgroundColor: const Color.fromARGB(200, 175, 135, 100),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TitleCard(title: "Informações da Pilagem"),
            SizedBox(height: 12),
            MoneyField(
              title: "Preço do Café",
              controller: precoController,
              icon: Icons.attach_money,
              onChanged: (_) => salvarCampos(),
            ),
            SizedBox(height: 12),
            MoneyField(
              controller: valorPilagemController,
              title: "Valor da Pilagem",
              icon: Icons.payments,
              onChanged: (_) => salvarCampos(),
            ),
            SizedBox(height: 12),
            IntegerField(
              controller: quantidadeSacosController,
              title: "Quantidade de Sacos",
              icon: Icons.inventory_2,
              onChanged: (_) => salvarCampos(),
            ),
            SizedBox(height: 12),
            WeightField(
              controller: taraController,
              title: "Tara do Beg (kg)",
              icon: Icons.scale,
              onChanged: (_) => salvarCampos(),
            ),
            SizedBox(height: 12),

            TextFormField(
              controller: percentualColonoController,
              onChanged: (_) => salvarCampos(),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: "% do Colono",
                suffixText: '%',
                prefixIcon: const Icon(Icons.percent),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            SizedBox(height: 24),

            TitleCard(title: "Pesos dos Begs"),
            
            SizedBox(height: 8),

             ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pesosBeg.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: WeightField(
                          controller: pesosBeg[index],
                          title: "Peso do Beg ${index + 1}",
                          icon: Icons.scale,
                          onChanged: (_) => salvarCampos(),
                        ),
                      ),
                      IconButton(
                        onPressed: () => removerBeg(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
            OutlinedButton.icon(
              onPressed: adicionarBeg,
              icon: const Icon(Icons.add),
              label: const Text("Adicionar Beg"),
               style: OutlinedButton.styleFrom(
                  foregroundColor: Color.fromARGB(200, 175, 135, 100),
                  side: BorderSide(color: Color.fromARGB(200, 175, 135, 100)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                 ),
              ),
            ),
            

            ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: limparCampos,
                  icon: const Icon(Icons.cleaning_services),
                  label: const Text("Limpar Campos"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: calcularPilagem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(200, 175, 135, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calculate_outlined, color: Colors.white),
                      SizedBox(width: 5),
                      Text("Calcular Pilagem",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ]
                  )
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  // =========================
  // SALVAR CAMPOS
  // =========================
  Future<void> salvarCampos() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('preco', precoController.text);
    await prefs.setString('valorPilagem', valorPilagemController.text);
    await prefs.setString('quantidadeSacos', quantidadeSacosController.text);
    await prefs.setString('tara', taraController.text);
    await prefs.setString('percentual', percentualColonoController.text);

    // SALVAR PESOS DOS BEGS
    List<String> pesos = pesosBeg.map((c) => c.text).toList();
    await prefs.setStringList('pesosBeg', pesos);
  }

  // =========================
  // CARREGAR CAMPOS
  // =========================
  Future<void> carregarCampos() async {
    final prefs = await SharedPreferences.getInstance();
    final percentualSalvo = prefs.getString('percentual');

    precoController.text = prefs.getString('preco') ?? '';
    valorPilagemController.text = prefs.getString('valorPilagem') ?? '';
    quantidadeSacosController.text = prefs.getString('quantidadeSacos') ?? '';
    taraController.text = prefs.getString('tara') ?? '';
    percentualColonoController.text =
        (percentualSalvo == null || percentualSalvo.trim().isEmpty)
        ? '100'
        : percentualSalvo;

    // =========================
    // CARREGAR PESOS
    // =========================
    List<String> pesosSalvos = prefs.getStringList('pesosBeg') ?? [];

    pesosBeg.clear();

    if (pesosSalvos.isEmpty) {
      // inicia com 3 campos padrão
      for (int i = 0; i < 3; i++) {
        pesosBeg.add(TextEditingController());
      }
    } else {
      for (var peso in pesosSalvos) {
        pesosBeg.add(TextEditingController(text: peso));
      }
    }

    setState(() {});
  }

  void adicionarBeg() {
    setState(() {
      pesosBeg.add(TextEditingController());
    });
    salvarCampos();
  }

  void removerBeg(int index) {
    setState(() {
      pesosBeg[index].dispose();
      pesosBeg.removeAt(index);
    });
    salvarCampos();
  }

  void limparCampos() {
    precoController.clear();
    valorPilagemController.clear();
    quantidadeSacosController.clear();
    taraController.clear();
    percentualColonoController.text = '100';
    for (var c in pesosBeg) {
      c.clear();
    }

    salvarCampos();
    setState(() {});
  }

  void calcularPilagem() {
    if (precoController.text.trim().isEmpty ||
        valorPilagemController.text.trim().isEmpty ||
        quantidadeSacosController.text.trim().isEmpty ||
        taraController.text.trim().isEmpty ||
        percentualColonoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    bool existePesoPreenchido = pesosBeg.any((c) => c.text.trim().isNotEmpty);

    if (!existePesoPreenchido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe pelo menos um peso de Beg')),
      );
      return;
    }

    double pesoTotal = 0;

    List<double> pesosConvertidos = pesosBeg.map((c) {
      return double.tryParse(c.text.replaceAll(',', '.')) ?? 0;
    }).toList();

    for (var p in pesosConvertidos) {
      pesoTotal += p;
    }

    final pilagem = PilagemModel(
      pesoTotal: pesoTotal,
      valorPilagem:
          double.tryParse(valorPilagemController.text.replaceAll(',', '.')) ??
          0,
      precoCafe:
          double.tryParse(precoController.text.replaceAll(',', '.')) ?? 0,
      quantidadeSacos: int.tryParse(quantidadeSacosController.text) ?? 0,
      taraBeg: double.tryParse(taraController.text.replaceAll(',', '.')) ?? 0,
      pesosBeg: pesosConvertidos,
      percentualColono:
          double.tryParse(
            percentualColonoController.text.replaceAll(',', '.'),
          ) ??
          0,
    );

    salvarCampos();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultadoPage(pilagem: pilagem)),
    );
  }
}
