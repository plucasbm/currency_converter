import 'package:currency_converter/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uri url = Uri.parse("https://api.hgbrasil.com/finance?key=96303dfa");

  Future<Map> getData() async {
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final _realController = TextEditingController();
    final _dolarController = TextEditingController();
    final _euroController = TextEditingController();

    double? dolar;
    double? euro;

    void _clearAll(){
      _dolarController.text = "";
      _realController.text = "";
      _euroController.text = "";
    }

    void _realChanged(String text){
      
      if(text.isEmpty){
        _clearAll();
        return;
      }
        double real = double.parse(text);
        _dolarController.text = (real/dolar!).toStringAsFixed(2);
        _euroController.text = (real/euro!).toStringAsFixed(2);
    }

    void _dolarChanged(String text){
      
      if(text.isEmpty){
        _clearAll();
        return;
      } 
        double dolarC = double.parse(text);
        _realController.text = (dolarC * dolar!).toStringAsFixed(2);
        _euroController.text = ((dolarC * dolar!)/euro!).toStringAsFixed(2);
    }

    void _euroChanged(String text){
      
      if(text.isEmpty){
        _clearAll();
        return;
      }
        double euroC = double.parse(text);
        _realController.text = (euroC * euro!).toStringAsFixed(2);
        _dolarController.text = ((euroC * euro!)/dolar!).toStringAsFixed(2);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("\$ Conversor de Moedas \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Erro ao carregar os dados...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.amber,
                        size: 150,
                      ),
                      const Divider(),
                      CustomTextField(
                        label: 'Reais',
                        prefix: 'R\$ ',
                        controller: _realController,
                        onChanged: _realChanged,
                      ),
                      const Divider(),
                      CustomTextField(
                        label: 'Dólares',
                        prefix: 'US\$ ',
                        controller: _dolarController,
                        onChanged: _dolarChanged,
                      ),
                      const Divider(),
                      CustomTextField(
                        label: 'Euros',
                        prefix: '€ ',
                        controller: _euroController,
                        onChanged: _euroChanged,
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
