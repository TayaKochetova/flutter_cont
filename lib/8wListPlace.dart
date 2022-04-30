import 'package:flutter/material.dart';

import 'secondScreen.dart';
import 'naturalImage.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<NaturalImage> _naturals = <NaturalImage>[
    NaturalImage(
        'Тибет',
        'Горный регион Центральной Азии, расположенный в юго-западной части Китая и занимающий восьмую часть площади этого государства. Формально Тибетом считается автономный район со столицей Лхаса. В культурно-географическом отношении он гораздо больше и охватывает все Цинхай-Тибетское нагорье, хотя оно не везде имеет четкие границы; кроме того, тибетцы населяют также Западную Сычуань, Южную Ганьсу и Северную Юньнань. В этническом, языковом и религиозном отношении население Тибета принципиально отличается от жителей других китайских территорий.',
        'https://avatars.mds.yandex.net/get-zen_doc/100325/pub_5bed90070d576b00a9fd1055_5bed9617f16f6c00aa3c6789/scale_1200'),
    NaturalImage(
        'Мертвое море',
        'Это уникальный подарок природы, который помогает людям оздоровиться и обрести долгие годы жизни, поэтому лечебные туры на Мертвом море пользуются особым спросом у туристов со всего мира. Исцеляющий водоем расположен на самой низшей точке земного шара. Соль, полезные минералы, кислород и чистая вода благоприятно способствуют на человеческий организм и способны избавить от многих заболеваний. В составе воды также есть грязь, которую в медицине используют для создания кремов и масок по уходу за кожей. Лечение грязью помогает укрепить иммунитет, снять стресс, избавиться от боли в суставах и прогреть организм полностью.',
        'https://avatars.mds.yandex.net/get-zen_doc/1704908/pub_5e061ebd5ba2b500aebf69b1_5e06394b2beb4900af3bad9e/scale_1200'),
    NaturalImage(
        'Озеро Байкал',
        'Озеро Байкал, расположенное на юге Восточной Сибири, на границе Иркутской области и Республики Бурятия, относится к числу самых древних водоемов нашей планеты. Но больше всего оно известно тем, что является самым глубоким озером на Земле и одновременно крупнейшим естественным резервуаром пресной воды – 19% всех мировых запасов. И сам Байкал, и прибрежные территории отличает неповторимая в своем разнообразии флора и фауна, что делает эти места поистине уникальными, неизменно привлекающими к себе внимание научных умов и многочисленных любителей путешествий и настоящих искателей приключений.',
        'https://placepic.ru/wp-content/uploads/2018/10/9b69c1feaf7dabb48ca1dd3bda133b2e.jpg'),
    NaturalImage(
        'Мачу-Пикчу',
        'Легендарный город, который укрыт в сердце Анд на высоте 2400 м. Это древнее поселение инков между двумя горными пиками и по сей день хранит свои тайны. При взгляде на руины города Мачу-Пикчу, эффектно проступающие среди покрытых джунглями горных пиков и крутых склонов и террасами спускающиеся в долину, у туристов перехватывает дыхание.',
        'https://spanishlove.ru/wp-content/uploads/2019/10/machu-pichu.jpg'),
    NaturalImage(
        'Остров Бали',
        'Настоящая сказка наяву, прекрасный остров, покрытый террасами изумрудных рисовых полей и лесами из гвоздичных и коричных деревьев, усыпанных ароматными цветами. Удивительные, поистине волшебные музыка, живопись и танцы, причудливые храмы, ласковый шепот теплых океанских волн. Но самое ценное сокровище острова — его люди, невероятно красивые и умелые, с успехом сочетающие в своей жизни реалии XXI века с его мотоциклами и интернет-кафе и традиции предков. ',
        'https://toursbali.ru/wp-content/uploads/2022/01/Skazochnyy-ostrov-bogov-Hram-Tanah-Lot.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Un-Named Routes"),
        centerTitle: true,
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(5),
          itemCount: _naturals.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  title: Text(_naturals[index].name,
                      style: TextStyle(fontSize: 18)),
                  leading: ClipOval(
                    child: Image.network(
                      _naturals[index].largeImage,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  subtitle: Text(
                      "${_naturals[index].description.substring(0, 30)}..."),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondScreen(
                                natural: _naturals[index],
                              )),
                    );
                  },
                ),
              ],
            );
          }),
    );
  }
}
