import 'package:flutter/material.dart';

class FormSubmission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            'Форма успешно отправлена!',
            textAlign: TextAlign.center,
          ),
          Image.network(
              'https://elitepremix.kz/wp-content/uploads/2021/02/shutterstock_690150508.jpg',
              width: 400,
              height: 200),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Закрыть'),
        ),
      ],
    );
  }
}
