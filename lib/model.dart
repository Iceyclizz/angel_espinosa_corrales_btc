
import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Modelo {
  factory Modelo() {
    return _instance;
  }

  Modelo._constructor() {}
  List<Orden> _orderList = <Orden>[];
  static final Modelo _instance = Modelo._constructor();

  List<Orden> get orderList => _orderList;
  set orderList(List<Orden> value) {
    _orderList = value;
  }

  Future<void> initList() async {
    await Hive.initFlutter();
    Hive.registerAdapter(OrderAdapter()); 
    var todobox = await Hive.openBox<List<Orden>>('orderList');
    _orderList = todobox.get('lista') ?? [];
  }

  void addList(Orden orden) async {
    _orderList.add(orden);
    var todobox = await Hive.box<List<Orden>>('orderList');
    todobox.put('lista', _orderList);
  }
}
class Orden{
  Orden(){}
  Orden.lista(List list){
    cantidad=list[0];
    comision=list[1];
    tipo=list[2];
    fecha=list[3];
  }
  DateTime? _fecha;
  String? _tipo;
  double? _cantidad;
  double? _comision;
  DateTime? get fecha => _fecha;
  String? get tipo => _tipo;
  double? get cantidad => _cantidad;
  double? get comision => _comision;
  set fecha(DateTime? value) {
    _fecha = value;
  }
  set tipo(String? value) {
    _tipo = value;
  }
  set cantidad(double? value) {
    _cantidad = value;
  }
  set comision(double? value) {
    _comision = value;
  }
}
class OrderAdapter extends TypeAdapter<Orden> {
  @override
  final typeId = 1410;

  @override
  Orden read(BinaryReader reader) {
    return Orden.lista(reader.read());
  }

  @override
  void write(BinaryWriter writer, Orden obj) {
    writer.write([obj.cantidad,obj.comision,obj.tipo,obj.fecha]);
  }
}