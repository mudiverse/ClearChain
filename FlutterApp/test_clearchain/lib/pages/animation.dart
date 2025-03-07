// corruption_cards.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart' as carousel;

class CorruptionCards extends StatefulWidget {
  const CorruptionCards({Key? key}) : super(key: key);

  @override
  State<CorruptionCards> createState() => _CorruptionCardsState();
}

class _CorruptionCardsState extends State<CorruptionCards> {
  final carousel.CarouselSliderController _controller = carousel.CarouselSliderController();
  final List<Map<String, String>> corruptionData = const [
    {
      'title': 'Bribery',
      'description': 'Don’t be a target! Report suspicious offers.',
    },
    {
      'title': 'Fraud',
      'description': ' Hidden lies hurt everyone—speak out!',
    },
    {
      'title': 'Power Abuse',
      'description': 'Stay alert and avoid hidden inducements.When leaders cheat, we all lose—demand honesty',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
      items: corruptionData.map((cardData) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8.0,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cardData['title']!,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      cardData['description']!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}