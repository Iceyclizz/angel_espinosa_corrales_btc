import 'package:angel_espinosa_corrales_btc/model.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import 'order_management.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(
    title: "Calendario de Ángel Espinosa",
    ),
        '/order': (context) => EditarOrderForm(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final OrderController _controller = OrderController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _controller.init(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(children: _getItems()
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed("/order");
          setState(() {});
        },
        tooltip: 'Añadir Orden',
        child: const Icon(Icons.add),
      ),
    );});
  }
  List<Widget> _getItems() {
    final List<Widget> orderWidgets = <Widget>[];
    for (Orden orden in _controller.orderList) {
      orderWidgets.add(_buildOrderItem(orden));
    }
    return orderWidgets;
  }
  Widget _buildOrderItem(Orden title) {
    return ListTile(title: Text('${title.cantidad}''\t''${title.comision}''\n''${title.fecha}''\t''${title.tipo}'));
  }
}
