import 'model.dart';

class OrderController {
  List<Orden> get orderList => Modelo().orderList;

  void addList(Orden orden) {
    Modelo().addList(orden);
  }
  Future<void> init() async {
    await Modelo().initList();
  }
}
