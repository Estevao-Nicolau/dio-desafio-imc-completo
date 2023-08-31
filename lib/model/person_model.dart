class PersonModel {
  final String name;
  final double peso;
  final double altura;

  PersonModel({
    required this.name,
    required this.peso,
    required this.altura,
  });
  // Construtor factory para criar uma instância de PersonModel a partir de um mapa JSON.
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      name: json['name'] ?? '',
      peso: json['peso'] ?? 0.0,
      altura: json['altura'] ?? 0.0,
    );
  }

  // Método toJson para converter uma instância de PersonModel em um mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'peso': peso,
      'altura': altura,
    };
  }
  
  double calculateIMC(double peso, double altura) {
    double imc = peso / (altura * altura);
    return imc;
  }
  String getClassification(double imc) {
  if (imc < 16) {
    return "Magreza grave";
  } else if (imc < 17) {
    return "Magreza moderada";
  } else if (imc < 18.5) {
    return "Magreza leve";
  } else if (imc < 25) {
    return "Saudável";
  } else if (imc < 30) {
    return "Sobrepeso";
  } else if (imc < 35) {
    return "Obesidade Grau 1";
  } else if (imc < 40) {
    return "Obesidade Grau 2";
  } else {
    return "Obesidade Grau 3";
  }
}

}