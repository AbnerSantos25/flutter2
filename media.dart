import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Media extends StatefulWidget {
  const Media({super.key});

  @override
  State<Media> createState() => _MediaState();
}

// theme: ThemeData(),
// darkTheme: ThemeData.dark())

class _MediaState extends State<Media> {
  final TextEditingController _controlaNome = TextEditingController();
  final TextEditingController _controlaNota1 = TextEditingController();
  final TextEditingController _controlaNota2 = TextEditingController();
  final TextEditingController _controlaNota3 = TextEditingController();
  final TextEditingController _controlaNota4 = TextEditingController();
  List<String> _list = [];

  String _resultado = '';

  _calcula() {
    double total = 0.0;
    var digitada = _controlaNota1.text.replaceAll(',', '.');
    total += double.parse(digitada);
    digitada = _controlaNota2.text.replaceAll(',', '.');
    total += double.parse(digitada);
    digitada = _controlaNota3.text.replaceAll(',', '.');
    total += double.parse(digitada);
    digitada = _controlaNota4.text.replaceAll(',', '.');
    total += double.parse(digitada);
    double media = total / 4;
    var mediaBR = '$media'.replaceAll('.', ',');
    _resultado = '${_controlaNome.text} obteve a media: $mediaBR';
    notificacao(media);

    setState(() {
      _list.add(_resultado);
    });
  }

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Média: '),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Row(
            children: [
              rotulo('Nome do aluno: '),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _controlaNome,
                ),
              ),
            ],
          ),
          linhaNota("Primeira Nota: ", _controlaNota1),
          linhaNota("Segunda nota Nota: ", _controlaNota2),
          linhaNota("Terceira Nota: ", _controlaNota3),
          linhaNota("Quarta Nota: ", _controlaNota4),
          botao("Calcular"),
          Flexible(
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_list[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton botao(String texto) =>
      ElevatedButton(onPressed: _calcula, child: Text(texto));

  Row linhaNota(String rotulo, TextEditingController controlador) {
    return Row(
      children: [
        Text(rotulo),
        SizedBox(
          width: 100,
          child: TextField(
            controller: controlador,
          ),
        ),
      ],
    );
  }

  Text rotulo(String texto) => Text(texto);

  notificacao(double media) {
    if (media <= 6) {
      const snackBar = SnackBar(
        content: Text('reprovado!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text('Aprovado!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
