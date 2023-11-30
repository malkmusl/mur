import 'package:flutter/material.dart';
import '../widgets/eventcard.dart';
import 'create_event.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const EventCard(
            date: 'Silvester 2023/2024',
            time: '31.12.2023 - 19:30',
            balance: 20.33,
            imageUrl:
                'https://img.freepik.com/vektoren-premium/gelber-farbhalbton-youtube-thumbnail-hintergrund_562076-95.jpg?w=1380',
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEvent()),
              );
            },
            child: const AddEventCard(),
          ),
        ],
      ),
    );
  }
}
