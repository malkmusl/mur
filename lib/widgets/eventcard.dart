import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String date;
  final String time;
  final String imageUrl;
  final double balance; // Example double value for color shifting

  EventCard({
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth;
        double cardHeight = cardWidth * 9 / 16; // 16:9 aspect ratio
        double fontSizeBig = cardWidth * 0.06; // Adjust font size based on screen width
        double fontSizeMedium = cardWidth * 0.05;
        double fontSizeSmall = cardWidth * 0.04;

        // Define a custom green color
        Color customGreenColor = Color.fromRGBO(0, 255, 0, 1.0); // Adjust RGB values as needed

        return Container(
          width: cardWidth,
          height: cardHeight,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(date, style: TextStyle(fontSize: fontSizeBig, color: Colors.white, shadows: [BoxShadow(color: Colors.black, blurRadius: 5)])),
                      Text(time, style: TextStyle(fontSize: fontSizeMedium, color: Colors.white, shadows: [BoxShadow(color: Colors.black, blurRadius: 5)])),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8.0,
                  right: 8.0,
                  child: Text(
                    '${balance.toStringAsFixed(2)}€',
                    style: TextStyle(
                      fontSize: fontSizeSmall,
                      color: balance < 0 ? Colors.red : customGreenColor,
                      shadows: [BoxShadow(color: Colors.black, blurRadius: 5)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



class AddEventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth;
        double cardHeight = cardWidth * 9 / 16; // 16:9 aspect ratio

        return Container(
          width: cardWidth,
          height: cardHeight,
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 2.0,
              ),
            ),
            child: Center(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
