import 'dart:math';

import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import '../covid_icons.dart';
import 'formulario.dart';

class Item {
  IconData icon;
  Color color;
  Function onTap;
  String titulo;
  Item({this.titulo, this.color, this.icon, this.onTap});
}

Color fondo = Color(0xff144d8b);

List<Item> menu;
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _cardsWidt = 80;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    menu = [
      Item(
        titulo: 'Tu condición',
        color: Colors.redAccent,
        icon: Covid.heartbeat,
        onTap: () {
          print('ok');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioPage();
              },
            ),
          ).then((value) => {});
        },
      ),
      Item(titulo: 'Menu', color: fondo, icon: Icons.map_outlined),
      Item(titulo: 'Menu', color: fondo, icon: Covid.heartbeat),
      Item(titulo: 'Menu', color: fondo, icon: Icons.map_outlined),
      Item(titulo: 'Menu', color: fondo, icon: Covid.heartbeat),
      Item(titulo: 'Menu', color: fondo, icon: Icons.map_outlined),
      Item(titulo: 'Menu', color: fondo, icon: Covid.heartbeat),
      Item(titulo: 'Menu', color: fondo, icon: Icons.map_outlined),
      Item(titulo: 'Menu', color: fondo, icon: Covid.heartbeat),
      Item(titulo: 'Menu', color: Colors.black, icon: Icons.map_outlined)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fondo,
        title: Text('Gimnasio Cerromar'),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              // size: 40,
            ),
          )
        ],
        /* leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ), */
      ),
      body: Center(
        child: Container(
          width: size.width * 0.95,
          child: WaterfallFlow.builder(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: ((size.width ~/ _cardsWidt) == null ||
                      (size.width ~/ _cardsWidt) <= 0)
                  ? 1
                  : (size.width ~/ _cardsWidt),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 30.0,
            ),
            itemBuilder: (BuildContext c, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: getRandomString(5),
                    onPressed: menu[index].onTap,
                    backgroundColor: menu[index].color,
                    child: Icon(
                      menu[index].icon,
                      size: 35,
                    ),
                  ),
                  Text(
                    (menu[index].titulo != 'Menu')
                        ? menu[index].titulo
                        : menu[index].titulo + ' ' + index.toString(),
                    textAlign: TextAlign.center,
                  )
                ],
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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: fondo,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
