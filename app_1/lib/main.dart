import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

late String symbol = "ABEV3";
String request =
    "https://api.hgbrasil.com/finance/stock_price?key=303b5c99&symbol="+symbol;

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Color.fromARGB(255, 176, 238, 170), primaryColor: Color.fromARGB(255, 176, 238, 170)),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  late double valor;
  String dropdownValue = "Ambev S.A. - ABEV3";
 
  void _symbolChange(String text) {
    setState(() {
      if(text == "Ambev S.A. - ABEV3"){
      symbol = 'ABEV3';
      request = "https://api.hgbrasil.com/finance/stock_price?key=303b5c99&symbol="+symbol;
      }
      if(text == "Banco do Brasil S.A. - BBAS3"){
      symbol = 'BBAS3';
      request = "https://api.hgbrasil.com/finance/stock_price?key=303b5c99&symbol="+symbol;
      }
      if(text == "Embraer S.A. - EMBR3"){
      symbol = 'EMBR3';
      request = "https://api.hgbrasil.com/finance/stock_price?key=303b5c99&symbol="+symbol;
      }
      if(text == "Intelbras - INTB3"){
      symbol = 'INTB3';
      request = "https://api.hgbrasil.com/finance/stock_price?key=303b5c99&symbol="+symbol;
      }
      if(text == "Vale S.A. - VALE3"){
      symbol = 'VALE3';
      request = "https://api.hgbrasil.com/finance/stock_price?key=303b5c99&symbol="+symbol;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text("Bolsa de Valores"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 176, 238, 170)),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Color.fromARGB(255, 176, 238, 170), fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar dados...",
                      style: TextStyle(color: Color.fromARGB(255, 176, 238, 170), fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                   
                    valor = snapshot.data!["results"][symbol]["price"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.account_balance,
                              size: 75.0, color: Color.fromARGB(255, 176, 238, 170)),                 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[ 
                                    Text(
                                      "Selecione a Ação: ",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 3, 19, 1),
                                        fontSize: 16,
                                        ),
                                    ),
                                    const SizedBox(width: 15),   
                                    DropdownButton<String>(                       
                                      value: dropdownValue,
                                      elevation: 2,
                                      style: const TextStyle(color: Color.fromARGB(255, 3, 19, 1)),                       
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                          
                                        });
                                      },
                                      items: <String>["Ambev S.A. - ABEV3", "Banco do Brasil S.A. - BBAS3", "Embraer S.A. - EMBR3", "Intelbras - INTB3", "Vale S.A. - VALE3"]
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                          onTap: () { _symbolChange(value);},
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 100),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Ação: "+symbol,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 3, 19, 1),
                                      fontSize: 16,
                                      ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    "Preço por Ação: "+'$valor',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 3, 19, 1),
                                      fontSize: 16,
                                      ),
                                  ),
                                ],
                              )   
            ],
          ),
        );
      }
  }
}));
  }
}
