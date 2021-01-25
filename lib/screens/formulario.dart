import 'dart:math';

import 'package:cerromar/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../covid_icons.dart';

class Pregunta {
  IconData icon;
  Color color;
  Function onTap;
  String texto;
  Widget respuesta;
  Pregunta({this.texto, this.respuesta, this.color, this.icon, this.onTap});
}

class Respuesta {
  bool respuesta;
  String pregunta;
  Respuesta({
    this.respuesta,
    this.pregunta,
  });
  Map toJson() {
    return {
      'respuesta': respuesta,
      'pregunta': pregunta,
    };
  }
}

List<Respuesta> respuestas = [];

Color fondo = Color(0xff144d8b);
List<Pregunta> menu;
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

/* init(){
  menu.forEach((element) { })
} */

class FormularioPage extends StatefulWidget {
  FormularioPage({Key key}) : super(key: key);

  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  double _cardsWidt = 200;
  bool isSwitched = true;
  @override
  void initState() {
    respuestas = [];
    menu = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _cardsWidt = (size.width > 412) ? 400 : 200;
    if (menu.length == 0) {
      menu = [
        Pregunta(
          texto: '¿Tienes dolor de garganta?',
          respuesta: ToggleWidget(
            cornerRadius: 8,
            activeBgColor: fondo,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.blueGrey[100],
            inactiveTextColor: Colors.black87,
            labels: ['SI', 'NO'],
            onToggle: (a) {
              respuestas[0].respuesta = (a == 0) ? true : false;
            },
          ),
          color: Colors.redAccent,
          icon: Covid.heartbeat,
          onTap: () {},
        ),
        Pregunta(
          texto:
              '¿Tienes malestar general o escalofrios que te limite las actividades de la vida diaria?',
          respuesta: ToggleWidget(
            cornerRadius: 8,
            activeBgColor: fondo,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.blueGrey[100],
            inactiveTextColor: Colors.black87,
            labels: ['SI', 'NO'],
            onToggle: (a) {
              respuestas[1].respuesta = (a == 0) ? true : false;
            },
          ),
          color: fondo,
          icon: Icons.map_outlined,
        ),
        Pregunta(
          texto: '¿Tienes dolor muscular o en los huesos?',
          respuesta: ToggleWidget(
            cornerRadius: 8,
            activeBgColor: fondo,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.blueGrey[100],
            inactiveTextColor: Colors.black87,
            labels: ['SI', 'NO'],
            onToggle: (a) {
              respuestas[2].respuesta = (a == 0) ? true : false;
            },
          ),
          color: fondo,
          icon: Covid.heartbeat,
        ),
        Pregunta(
          texto: '¿Tienes fiebre? (mayor a 38°, medida con termómetro)',
          respuesta: ToggleWidget(
            cornerRadius: 8,
            activeBgColor: fondo,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.blueGrey[100],
            inactiveTextColor: Colors.black87,
            labels: ['SI', 'NO'],
            onToggle: (a) {
              respuestas[3].respuesta = (a == 0) ? true : false;
            },
          ),
          color: fondo,
          icon: Icons.map_outlined,
        ),
        Pregunta(
          texto: '¿Tienes tos seca y presidente?',
          respuesta: ToggleWidget(
            cornerRadius: 8,
            activeBgColor: fondo,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.blueGrey[100],
            inactiveTextColor: Colors.black87,
            labels: ['SI', 'NO'],
            onToggle: (a) {
              respuestas[4].respuesta = (a == 0) ? true : false;
            },
          ),
          color: fondo,
          icon: Covid.heartbeat,
        ),
        Pregunta(
          texto:
              '¿Tienes secreciones nasales o congestion nasal? (no relacionadas con procesos alergicos)',
          respuesta: ToggleWidget(
            cornerRadius: 8,
            activeBgColor: fondo,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.blueGrey[100],
            inactiveTextColor: Colors.black87,
            labels: ['SI', 'NO'],
            onToggle: (a) {
              respuestas[5].respuesta = (a == 0) ? true : false;
            },
          ),
          color: fondo,
          icon: Icons.map_outlined,
        ),
        Pregunta(
          texto: '¿Tienes perdida de olfato y/o gusto?',
          respuesta: ToggleWidget(
            cornerRadius: 8,
            activeBgColor: fondo,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.blueGrey[100],
            inactiveTextColor: Colors.black87,
            labels: ['SI', 'NO'],
            onToggle: (a) {
              respuestas[6].respuesta = (a == 0) ? true : false;
            },
          ),
          color: fondo,
          icon: Covid.heartbeat,
        ),
      ];
      respuestas = [];
      menu.forEach((item) {
        respuestas.add(Respuesta(pregunta: item.texto, respuesta: false));
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fondo,
        title: Text('Tu condición'),
        actions: <Widget>[
          TextButton(
            // textColor: Colors.white,
            onPressed: () {
              respuestas.forEach((e) => print(e.toJson()));
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            // shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: size.width * 0.95,
          child: WaterfallFlow.builder(
            padding:
                const EdgeInsets.only(bottom: 30, left: 0, right: 5, top: 15),
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: ((size.width ~/ _cardsWidt) == null ||
                      (size.width ~/ _cardsWidt) <= 0)
                  ? 1
                  : (size.width ~/ _cardsWidt),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 30.0,
            ),
            itemBuilder: (BuildContext c, int index) {
              return ListTile(
                title: Text((menu[index].texto == null)
                    ? ''
                    : (1 + index).toString() + '. ' + menu[index].texto),
                trailing: menu[index].respuesta,
                onTap: () {
                  // print(menu[index].respuesta.toString());
                },
              );
              /* IconButton(
                onPressed: null,
                icon: Icon(
                  menu[index].icon,
                  color: menu[index].color,
                  size: 40,
                ),
              ); */
            },
            itemCount: menu.length,
          ),
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: fondo,
        onPressed: null,
        child: Icon(Icons.qr_code),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: fondo,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 50,
        ),
      ), */
    );
  }
}
