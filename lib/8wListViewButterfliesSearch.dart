import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: UsersList(),
  ));
}

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  int? _selectedIndex;
  final butterfliesMap = {
    "Крапивница":
        "Одна из первых весенних бабочек и одна из самых ярких и красочных представительниц дневных бабочек. Такое название бабочка получила от того, что гусеница крапивницы любит питаться крапивой.",
    "Павлиний глаз":
        "Бабочка «Павлиний глаз» является одним из видов дневных бабочек. Своё название она получила благодаря четырём характерным пятнам с голубыми точками «глазками» на внешней стороне крыльев.",
    "Капустница":
        "Капустница или белянка капустная — дневная бабочка из семейства белянок (Pieridae). Видовой эпитет происходит от лат. Brassica — капуста, одно из кормовых растений гусениц.",
    "Голубянка аргус":
        "Голубянка – дневная бабочка, поэтому её активность приходиться на светлое время суток, любят жару и яркое солнышко, на ночевку прячутся в укромное, тихое место. Эта маленькая, миловидная порода бабочек имеет довольно крепкий характер.",
    "Траурница":
        "Траурницей бабочку назвали потому, что крылья всех разновидностей этого насекомого окрашены в темные цвета. Траурницы – довольно крупные бабочки шоколадного или темно-вишневого цвета.",
  };

  List<Butterfly> butterflies = [
    Butterfly('Крапивница',
        'Одна из первых весенних бабочек и одна из самых ярких и красочных представительниц дневных бабочек. Такое название бабочка получила от того, что гусеница крапивницы любит питаться крапивой.'),
    Butterfly('Павлиний глаз',
        'Бабочка «Павлиний глаз» является одним из видов дневных бабочек. Своё название она получила благодаря четырём характерным пятнам с голубыми точками «глазками» на внешней стороне крыльев.'),
    Butterfly('Капустница',
        'Капустница или белянка капустная — дневная бабочка из семейства белянок (Pieridae). Видовой эпитет происходит от лат. Brassica — капуста, одно из кормовых растений гусениц.'),
    Butterfly('Голубянка аргус',
        'Голубянка – дневная бабочка, поэтому её активность приходиться на светлое время суток, любят жару и яркое солнышко, на ночевку прячутся в укромное, тихое место. Эта маленькая, миловидная порода бабочек имеет довольно крепкий характер.'),
    Butterfly('Траурница',
        'Траурницей бабочку назвали потому, что крылья всех разновидностей этого насекомого окрашены в темные цвета. Траурницы – довольно крупные бабочки шоколадного или темно-вишневого цвета.')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Каталог бабочек"),
        centerTitle: true,
      ),
      body: Column(children: [
        _buildSearchForm(),
        _button(),
        _buildHorizontalList(),
        _buildText()
      ]),
    );
  }

  var _controller = TextEditingController();
  Widget _buildSearchForm() {
    final _formKey = GlobalKey<FormState>();

    return Container(
      height: 100,
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Поиск',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: 'Название бабочки',
            suffixIcon: IconButton(
              onPressed: _controller.clear,
              icon: Icon(Icons.clear),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) return 'Введите имя бабочки';
          },
          /*onChanged: (value) {
            setState(() {
              for (int i = 0; i < butterflies.length; i++) {
                String nameButterfly = butterflies.elementAt(i).name;
                if (nameButterfly.startsWith(value)) {}
              }
            });
          },*/
        ),
      ),
    );
  }

  Widget _button() {
    final _globalKey = GlobalKey<FormState>();
    bool flag = true;

    return Container(
      margin: EdgeInsets.all(20),
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 153, 207, 252), Colors.blue],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),
      ),
      child: Form(
        key: _globalKey,
        child: TextButton(
          onPressed: () {
            setState(() {});
            if (_globalKey.currentState!.validate()) {
              //Color color = Colors.red;
              //String text;

              for (int i = 0; i < butterflies.length; i++) {
                String nameButterfly = butterflies.elementAt(i).name;
                if (nameButterfly.startsWith(_controller.value.text)) {
                  flag = false;
                  _selectedIndex = i;
                }
              }
              if (flag) {
                _selectedIndex = null;

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Такой бабочки "${_controller.value.text}" нет в списке'),
                  backgroundColor: Colors.red,
                ));
              }
            }
          },
          child: Text(
            'Найти',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalList() {
    return Container(
      height: 120,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemCount: butterflies.length,
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 235, 235, 235),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 3,
                color: _selectedIndex == index
                    ? Colors.blue
                    : Color.fromARGB(255, 235, 235, 235)),
          ),
          margin: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(children: [
                Image(
                  image: AssetImage('assets/images/butterfly.png'),
                  height: 15,
                  width: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  butterflies.elementAt(index).info(),
                  style: const TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Text(
          _selectedIndex == null
              ? ('')
              : butterflies.elementAt(_selectedIndex!).description,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.blue,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Butterfly {
  String name;
  String description;

  Butterfly(this.name, this.description);

  String info() {
    return name;
  }
}
