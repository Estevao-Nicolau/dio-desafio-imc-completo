import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/person_model.dart';
import '../lista_imc/lista_imc_page.dart';
import 'widgets/custom_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightsController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  List<PersonModel> metricsList = [];

  late SharedPreferences prefs;
  late String CHAVE_NAME_IMC = "CHAVE_NAME_IMC";
  late String CHAVE_HEIGHT_IMC = "CHAVE_HEIGHT_IMC";
  late String CHAVE_LIST_IMC = "CHAVE_LIST_IMC";

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
  setState(() async {
    prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString(CHAVE_NAME_IMC) ?? '';
    _heightController.text = prefs.getDouble(CHAVE_HEIGHT_IMC)?.toString() ?? '';
    final metricsListJson = prefs.getStringList(CHAVE_LIST_IMC) ?? [];
    metricsList = metricsListJson.map((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return PersonModel.fromJson(json);
    }).toList();
  });
}


  @override
  Widget build(BuildContext context) {
    const title = 'Calculadora IMC';
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: 360,
                  width: deviceSize.width * 0.70,
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            labelText: 'Nome',
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            validator: (name) {
                              if (name == null || name.isEmpty) {
                                return 'Por favor, insira um nome válido.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: 'Peso',
                                  controller: _weightsController,
                                  keyboardType: TextInputType.number,
                                  validator: (weights) {
                                    if (weights == null || weights.isEmpty) {
                                      return 'Por favor, insira um peso válido.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: 'Altura',
                                  controller: _heightController,
                                  keyboardType: TextInputType.number,
                                  validator: (height) {
                                    if (height == null || height.isEmpty) {
                                      return 'Por favor, insira uma altura válida.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final name = _nameController.text;
                                final peso = double.tryParse(_weightsController.text) ?? 0.0;
                                final altura = double.tryParse(_heightController.text) ?? 0.0;
                                if (name.isNotEmpty && peso > 0 && altura > 0) {
                                  final metrics = PersonModel(name: name, peso: peso, altura: altura);
                                  metricsList.add(metrics);
                                  await prefs.setString(CHAVE_NAME_IMC, name);
                                  await prefs.setDouble(CHAVE_HEIGHT_IMC, altura);

                                  final metricsListJson = metricsList.map((metric) => jsonEncode(metric.toJson())).toList();

                                  await prefs.setStringList(CHAVE_LIST_IMC, metricsListJson);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CardListPage(
                                        metricsList: metricsList,
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Calcular',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
