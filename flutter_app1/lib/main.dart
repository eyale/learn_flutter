import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserPanel(),
    ));

class UserPanel extends StatefulWidget {
  const UserPanel({Key? key}) : super(key: key);

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
          title: const Text('Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          centerTitle: true,
          backgroundColor: Colors.black12),
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Padding(padding: EdgeInsets.only(top: 50)),
            const CircleAvatar(
                backgroundImage: AssetImage('assets/super-man.webp'),
                radius: 50),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Text('Bradley Cooper',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(children: const [
              Icon(Icons.email, color: Colors.white, size: 20),
              Padding(padding: EdgeInsets.only(right: 5)),
              Text('bradley.cooper@gmail.com',
                  style: TextStyle(color: Colors.white, fontFamily: 'Nunito')),
            ]),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Text('Counter = $_counter',
                style:
                    const TextStyle(color: Colors.white, fontFamily: 'Nunito')),
          ])
        ],
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          child: const Icon(Icons.plus_one),
          onPressed: () {
            setState(() {
              _counter += 1;
            });
          }),
    );
  }
}
