import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum BatmanType { Bruce, Batman }

BatmanType batManKey = BatmanType.Bruce;

Map<BatmanType, Transformation> _batMans = {
  BatmanType.Bruce: Transformation('assets/images/bale.jpg', 'Брюс Уейн',
      'Один из самых умных людей на Земле, его блестящий ум позволяет ему разбираться в технологиях пришельцев и даже в технологиях из будущего.'),
  BatmanType.Batman: Transformation(
      'assets/images/batMan.jpg', 'Бэтмен', 'Супергерой, защитник Готэм-Сити'),
};

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InheritedWidget"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/images/dol.jpeg'),
                height: 40,
                width: 40,
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;

                    if (batManKey == BatmanType.Bruce) {
                      batManKey = BatmanType.Batman;
                    } else if (batManKey == BatmanType.Batman) {
                      batManKey = BatmanType.Bruce;
                    }
                    ;
                  });
                },
              ),
              Image(
                image: const AssetImage('assets/images/BatLogo.png'),
                height: 35,
                width: 35,
              ),
            ],
          ),
          SwitchReplaceInherited(
            batManKey: batManKey,
            child: const _Batman(),
          )
        ],
      ),
    );
  }
}

class _Batman extends StatelessWidget {
  const _Batman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    batManKey = context
            .dependOnInheritedWidgetOfExactType<SwitchReplaceInherited>()
            ?.batManKey ??
        0;
    return Stack(
      children: [
        Image.asset(_batMans[batManKey]!.foto,
            width: double.infinity, height: 600, fit: BoxFit.cover),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            width: 300,
            color: Colors.black54,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  _batMans[batManKey]!.name,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  _batMans[batManKey]!.description,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Transformation {
  String foto;
  String name;
  String description;

  Transformation(this.foto, this.name, this.description);

  void display() {
    print("$foto $description");
  }
}

class SwitchReplaceInherited extends InheritedWidget {
  final batManKey;

  const SwitchReplaceInherited({
    Key? key,
    required this.batManKey,
    required this.child,
  }) : super(key: key, child: child);

  final Widget child;

  @override
  bool updateShouldNotify(SwitchReplaceInherited oldWidget) {
    return BatmanType != oldWidget.batManKey;
  }
}
