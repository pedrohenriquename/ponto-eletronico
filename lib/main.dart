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
  // Lista simples que guarda os textos dos pontos batidos
  List<String> listaDePontos = [];

  // Nomes das batidas do dia na ordem
  List<String> tiposDePonto = [
    'Entrada',
    'Saída Almoço',
    'Volta Almoço',
    'Saída Final',
  ];

  // Função chamada quando aperta o botão
  void baterPonto() {
    // Pega a data e hora atual do celular/PC
    DateTime agora = DateTime.now();

    // Formata manualmente para ficar bonito (ex: 09:05)
    String hora = agora.hour.toString().padLeft(2, '0');
    String minuto = agora.minute.toString().padLeft(2, '0');
    String horarioFormatado = '$hora:$minuto';

    // Descobre qual é o tipo da batida atual
    String tipoAtual = tiposDePonto[listaDePontos.length];

    // Atualiza a tela adicionando o novo registro na lista
    setState(() {
      listaDePontos.add('$tipoAtual - $horarioFormatado');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se já bateu os 4 pontos do dia
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
            const SizedBox(height: 20),

            // Botão principal
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                // Se já bateu 4 vezes, desativa o botão (null)
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

            // Lista na tela mostrando os pontos batidos
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
