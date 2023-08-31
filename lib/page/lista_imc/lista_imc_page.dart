import 'package:bmi_calculator_complete/page/lista_imc/widgets/card_imc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/person_model.dart';

class CardListPage extends StatelessWidget {
  final List<PersonModel> metricsList;
  const CardListPage({required this.metricsList, Key? key}) : super(key: key);

  // Função para salvar o IMC em SharedPreferences
  Future<void> saveIMC(double imc) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('imc', imc);
  }

  // Função para recuperar o IMC de SharedPreferences
  Future<double?> getSavedIMC() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('imc');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de IMC'),
      ),
      body: ListView.builder(
        itemCount: metricsList.length,
        itemBuilder: (context, index) {
          final metrics = metricsList[index];
          final imc = metrics.calculateIMC(metrics.peso, metrics.altura);
          final classification = metrics.getClassification(imc);

          // Ao criar o CustomCardImc, salve o IMC usando saveIMC
          saveIMC(imc);

          return CustomCardImc(
            name: metrics.name,
            imc: imc,
            classification: classification,
          );
        },
      ),
    );
  }
}