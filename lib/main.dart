// Integrantes do Grupo:
// 1. Pedro Henrique - RA: 2025103003
// 2.Lucas Pereira - RA: 2025117247
// 3. Joao Victor - RA: 2025118184

import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAppPonto());
}

class MeuAppPonto extends StatelessWidget {
  const MeuAppPonto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaBaterPonto(),
    );
  }
}

class TelaBaterPonto extends StatefulWidget {
  @override
  State<TelaBaterPonto> createState() => _TelaBaterPontoState();
}

class _TelaBaterPontoState extends State<TelaBaterPonto> {
  // Coloque aqui os seus dados
  final String nomeAluno = 'Pedro Henrique';
  final String raAluno = '0000000'; // <-- Substitua pelo seu RA

  List<String> listaDePontos = [];

  List<String> tiposDePonto = [
    'Entrada',
    'Saída Almoço',
    'Volta Almoço',
    'Saída Final',
  ];

  void baterPonto() {
    DateTime agora = DateTime.now();

    String hora = agora.hour.toString().padLeft(2, '0');
    String minuto = agora.minute.toString().padLeft(2, '0');
    String horarioFormatado = '$hora:$minuto';

    String tipoAtual = tiposDePonto[listaDePontos.length];

    setState(() {
      listaDePontos.add('$tipoAtual - $horarioFormatado');
    });
  }

  @override
  Widget build(BuildContext context) {
    bool diaFinalizado = listaDePontos.length >= 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Ponto'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Cartão de identificação com Nome e RA
            Card(
              color: Colors.blue.shade50,
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.blue, size: 32),
                title: Text(
                  nomeAluno,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text('RA: $raAluno'),
              ),
            ),

            const SizedBox(height: 20),

            // Botão principal
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: diaFinalizado ? null : baterPonto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  diaFinalizado ? 'Dia Finalizado!' : 'BATER PONTO',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Registros de Hoje:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: listaDePontos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                        listaDePontos[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
