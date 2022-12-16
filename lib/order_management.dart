import 'dart:ffi';

import 'package:angel_espinosa_corrales_btc/controller.dart';
import 'package:angel_espinosa_corrales_btc/model.dart';
import 'package:flutter/material.dart';

class EditarOrderForm extends StatefulWidget {
  EditarOrderForm({Key? key}) : super(key: key);

  final OrderController controlador = OrderController();

  @override
  State<EditarOrderForm> createState() => _EditarOrderFormState();
}

class _EditarOrderFormState extends State<EditarOrderForm> {
  final _clauFormulari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Orden order = Orden();
    String? dropdownValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edició esdeveniment"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: guardar el formulario
          if (_clauFormulari.currentState != null &&
              _clauFormulari.currentState!.validate()) {
            _clauFormulari.currentState!.save();
            widget.controlador.addList(order);
            Navigator.of(context).pop();
          }
        },
        child: Icon(Icons.save),
      ),
      body: Form(
        key: _clauFormulari,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: (order.comision ?? '0').toString(),
                    decoration: const InputDecoration(
                      label: Text("Comision"),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (valor) {
                      if (double.tryParse(valor ?? "") == null) {
                        return "Número invalido";
                      }
                    },
                    onSaved: (valor) =>
                        order.cantidad = double.parse(valor ?? "0"),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: (order.cantidad ?? '0').toString(),
                    decoration: const InputDecoration(
                      label: Text("Cantidad Obtenida"),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (valor) {
                      if (double.tryParse(valor ?? "") == null) {
                        return "Número invalido";
                      }
                    },
                    onSaved: (valor) =>
                        order.cantidad = double.parse(valor ?? "0"),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FormField<DateTime>(
                    onSaved: (valor) => order.fecha = valor!,
                    builder: (formFieldState) {
                      return TextButton(
                          onPressed: () async {
                            DateTime? fecha = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2022),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2022, 12));
                            if (fecha != null) {
                              formFieldState.didChange(fecha);
                              TimeOfDay? hora = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      const TimeOfDay(hour: 0, minute: 0));
                              if (hora != null) {
                                formFieldState.didChange(DateTime(
                                    fecha.year,
                                    fecha.month,
                                    fecha.day,
                                    hora.hour,
                                    hora.minute));
                              }
                            }
                          },
                          child: Text(formFieldState.value == null
                              ? "Prem per definir"
                              : formFieldState.value.toString()));
                    },
                  ),
                ),
                Expanded(
                    child:  DropdownButton<String>(
                            value: order.tipo,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue= value;
                                order.tipo = dropdownValue;
                              });
                            },
                            items: ['Compra', 'Venta'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
