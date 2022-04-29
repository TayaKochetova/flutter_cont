import 'package:flutter/material.dart';

import 'formSubmission.dart';

void main() => runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(
        appBar: new AppBar(title: Center(child: new Text('Форма-опросник'))),
        body: new MyForm())));

enum GenderList { male, female }

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender = GenderList.female;
  bool? _dryFood = false;
  bool? _wetFood = false;
  bool? _naturalFood = false;
  String _errorText = '';

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Text(
                    'Кличка питомца:',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: new TextFormField(validator: (value) {
                      if (value!.isEmpty)
                        return 'Пожалуйста введите кличку котика';
                    }),
                  ),
                  new SizedBox(height: 10.0),
                  new Text(
                    'Имя и фамилия владельца питомца:',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: new TextFormField(validator: (value) {
                      if (value!.isEmpty)
                        return 'Пожалуйста введите свое имя и фамилию';
                    }),
                  ),
                  new SizedBox(height: 10.0),
                  new Text(
                    'Контактный E-mail:',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: new TextFormField(validator: (value) {
                      if (value!.isEmpty)
                        return 'Пожалуйста введите свой E-mail';
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) return 'Это не E-mail';
                    }),
                  ),
                  new SizedBox(height: 10.0),
                  new Text(
                    'Порода питомца:',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: new TextFormField(validator: (value) {
                      if (value!.isEmpty)
                        return 'Пожалуйста введите проду своего питомца';
                    }),
                  ),
                  new SizedBox(height: 10.0),
                  new Text(
                    'Пол питомца:',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  new RadioListTile(
                    title: const Text('Самец'),
                    value: GenderList.male,
                    groupValue: _gender,
                    onChanged: (GenderList? value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  new RadioListTile(
                    title: const Text('Самка'),
                    value: GenderList.female,
                    groupValue: _gender,
                    onChanged: (GenderList? value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  new SizedBox(height: 10.0),
                  new Text(
                    'Чем питается питомец:',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  CheckboxListTile(
                    value: _dryFood,
                    onChanged: (val) {
                      setState(() {
                        _dryFood = val;
                      });
                    },
                    activeColor: Colors.green,
                    title: Text(
                      'Сухой корм',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    value: _wetFood,
                    onChanged: (val) {
                      setState(() {
                        _wetFood = val;
                      });
                    },
                    activeColor: Colors.green,
                    title: Text('Влажный корм'),
                  ),
                  CheckboxListTile(
                    value: _naturalFood,
                    onChanged: (val) {
                      setState(() {
                        _naturalFood = val;
                      });
                    },
                    activeColor: Colors.green,
                    title: Text('Натуральный корм'),
                  ),
                  new SizedBox(height: 10.0),
                  new TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Color color = Colors.red;

                        if (_gender == null)
                          _errorText = 'Выберите пол питомца';
                        else if (_dryFood == false &&
                            _wetFood == false &&
                            _naturalFood == false)
                          _errorText =
                              'Необходимо указать, чем питается питомец';
                        else {
                          _errorText = '';

                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) =>
                                      FormSubmission()));
                        }

                        if (_errorText.isNotEmpty) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(_errorText),
                            backgroundColor: color,
                          ));
                        }
                      }
                    },
                    child: Text('Сохранить'),
                  ),
                ],
              ),
            )));
  }
}
