import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: MyHomeScreen()));
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  var dadosDoDash = null;

  Future<void> pegarDadosDash() async {
    var dadosDaApi = await http.get(Uri.parse("http://72.62.106.7:3000/dados"));

    var retorno = jsonDecode(dadosDaApi.body);

    setState(() {
      dadosDoDash = retorno;
    });
  }

  double calcularTotalVendas(List listVendas) {
    var total = 0.0;

    for (var venda in listVendas) {
      total += venda['valor']; // total = total + X
    }

    return total;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pegarDadosDash();
  }

  @override
  Widget build(BuildContext context) {
    List listVendas = dadosDoDash['vendas_mensais']['dados'];

    return Scaffold(
      //backgroundColor: Colors.black, // Mudar cor do fundo para preto
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: [
                  Icon(Icons.attach_money),
                  Text("Meu total de vendas"),
                  Text("R\$ " + calcularTotalVendas(listVendas).toString()),
                ],
              ),
            ),
          ),

          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.bar_chart),
                      Text("Grafico em barras"),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 250,
                    child: BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (valor, meta) {
                                var indice = valor.toInt();

                                if (indice >= 0 && indice < listVendas.length) {
                                  return Text(listVendas[indice]['mes']);
                                }

                                return Text("");
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (valor, meta) {
                                return Text(valor.toInt().toString());
                              },
                            ),
                          ),
                        ),
                        barGroups: listVendas.asMap().entries.map((venda) {
                          return BarChartGroupData(
                            x: venda.key,
                            barRods: [
                              BarChartRodData(
                                toY: venda.value['valor'],
                                width: 22,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
