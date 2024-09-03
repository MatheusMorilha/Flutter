import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cepController = TextEditingController();
  String _resultado = 'Seu endereço aqui';

  void _buscarEndereco() async{
    final String cep = _cepController.text;

    if(cep.isEmpty || cep.length != 8){
      setState(() {
        _resultado = 'Cep Inválido';
      });
      return;
    }

    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(url);

    if (response.statusCode == 200){
      final Map<String, dynamic> dados = json.decode(response.body);
      if (dados.containsKey('erro')){
        setState(() {
          _resultado = 'Cep não encontrado';
        });
      }else{
        setState(() {
          _resultado = 'Endereço: ${dados['logradouro']}, \nBairro: ${dados['bairro']}, \nCidade: ${dados['localidade']}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 123, 186),
        title: const Text('App Via Cep',
        style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Center(
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Digite o CEP',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: _buscarEndereco,
            child: const Text('Buscar'),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            _resultado,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
