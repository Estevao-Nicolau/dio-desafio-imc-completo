import 'package:flutter/material.dart';
class CustomCardImc extends StatelessWidget {
  final String name;
  final double imc;
  final String classification;

  const CustomCardImc({super.key, 
    required this.name,
    required this.imc,
    required this.classification,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('IMC: $imc'),
        trailing: Text(classification),
      ),
    );
  }
}
