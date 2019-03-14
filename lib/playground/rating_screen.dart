import 'package:flutter/material.dart';

Widget _avatarStack() => Stack(
  alignment: const Alignment(0.6, 0.6),
  children: [
    CircleAvatar(
      backgroundImage: AssetImage('assets/images/my_avatar.jpg'),
      radius: 100,
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.black45,
      ),
      child: Text(
        'Hung Pham',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ],
);

final stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star,color: Colors.green[500]),
    Icon(Icons.star,color: Colors.green[500]),
    Icon(Icons.star,color: Colors.green[500]),
    Icon(Icons.star,color: Colors.blueGrey[100]),
    Icon(Icons.star,color: Colors.blueGrey[100])
  ],
);

final ratings = Container(
  padding: EdgeInsets.all(20.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      stars,
      Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      )
    ],
  ),
);

final descTextStyle = TextStyle(
  color: Colors.black,
);

final iconList = DefaultTextStyle.merge(
  style: descTextStyle,
  child: Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.kitchen),
            Text('PREP'),
            Text('25 mins'),
          ],
        ),
        Column(
          children: [
          Icon(Icons.timer),
          Text('PREP'),
          Text('25 mins'),
          ],
        ),
        Column(
          children: [
          Icon(Icons.restaurant),
          Text('PREP'),
          Text('25 mins'),
          ],
        ),
      ],
    ),
  ),
);

Widget _buildCard() => SizedBox(
  height: 210,
  child: Card(
    child: Column(
      children: [
        ListTile(
          title: Text('1625 Main Street',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
          subtitle: Text('My City, CA 99984'),
          leading: Icon(
            Icons.restaurant_menu,
            color: Colors.blue[500],
          ),
        ),
        Divider(),
        ListTile(
          title: Text('(408) 555-1212',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
          leading: Icon(
            Icons.contact_phone,
            color: Colors.blue[500],
          ),
        ),
        ListTile(
          title: Text('costa@example.com', style: TextStyle(color: Colors.black)),
          leading: Icon(
            Icons.contact_mail,
            color: Colors.blue[500],
          ),
        ),
      ],
    ),
  ),
);


final mainPage = Container(
  child: Column(
    children: [
      _avatarStack(),
      ratings,
      iconList,
      _buildCard()
    ],
  )
);