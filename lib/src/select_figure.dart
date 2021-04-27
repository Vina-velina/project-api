import 'package:api_tugas/src/app.dart';
import 'package:flutter/material.dart';
import 'about.dart';
// disini akan nambah lingkaran dan segitiga
class SelectFigure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGE-GYM'),
        centerTitle: true,
        leading: Icon(
          Icons.favorite,
          color: Colors.pink,
          size: 30,
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height:100),
            Picture(),
            SizedBox(height:50),
            FigureOne(),
          ],
        ),
      ),
    );
  }
}

class FigureOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.cyan[50],
                blurRadius: 8.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          width: 150,
          margin: const EdgeInsets.only(top: 20.0),
          child: InkWell(
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => App()),
              );
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.supervised_user_circle,
                      size: 70,
                      color: Colors.cyan,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.cyan[50],
                blurRadius: 8.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          width: 150,
          margin: const EdgeInsets.only(top: 20.0),
          child: InkWell(
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Developer()),
              );
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.info_rounded,
                      size: 70,
                      color: Colors.cyan,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}


class Picture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset("assets/select.png", width: 250.0, fit: BoxFit.cover),
    );
  }
}
