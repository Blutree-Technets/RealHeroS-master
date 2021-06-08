import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "About us",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB71C1C),
                      Color(0xFFD50000),
                      Color(0xFFC62828),
                      Color(0xFFE65100),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  // padding: EdgeInsets.symmetric(
                  // ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      _blutree(),
                      _durga(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _blutree() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          new Column(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.fromLTRB(20, 0, 175, 0),
                height: 160,
                width: 160,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
              ),
              Center(
                child: new Container(
                  // height: 65.0,
                  // width: 300.0,
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue[200],
                      child: Column(
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(
                              'Contact',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      onTap: () => launch("tel://7020174440"),
                    ),
                  ),
                ),
              ),
              new Container(
                // height: 65.0,
                // width: 300.0,
                margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: InkWell(
                    splashColor: Colors.blue[200],
                    child: Column(
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.alternate_email),
                          title: Text(
                            'Email',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                    onTap: () => launch('mailto:blutree.tech@gmail.com'),
                  ),
                ),
              ),
              new Container(
                // height: 65.0,
                // width: 300.0,
                margin: EdgeInsets.fromLTRB(20, 15, 20, 30),
                child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue[200],
                      child: Column(
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.language),
                            title: Text(
                              'Website',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          )
                        ],
                      ),
                      onTap: _launchURL1,
                    )),
              ),
            ],
          ),
        ]);
  }

  Widget _durga() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          new Column(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.fromLTRB(20, 0, 175, 0),
                height: 160,
                width: 160,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/durga-india.jpg'),
                ),
              ),
              new Container(
                // height: 65.0,
                // width: 300.0,
                margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: InkWell(
                    splashColor: Colors.red[300],
                    child: Column(
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(
                            'Contact',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                    onTap: () => launch("tel://7020174440"),
                  ),
                ),
              ),
              new Container(
                // height: 65.0,
                // width: 300.0,
                margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: InkWell(
                    splashColor: Colors.red[300],
                    child: Column(
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.alternate_email),
                          title: Text(
                            'Email',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                    onTap: () => launch('mailto:contactus@durgaindia.org'),
                  ),
                ),
              ),
              new Container(
                // height: 65.0,
                // width: 300.0,
                margin: EdgeInsets.fromLTRB(20, 15, 20, 30),
                child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: InkWell(
                      splashColor: Colors.red[300],
                      child: Column(
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.language),
                            title: Text(
                              'Website',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          )
                        ],
                      ),
                      onTap: _launchURL2,
                    )),
              ),
            ],
          ),
        ]);
  }
}

_launchURL2() async {
  const url = 'http://durgaindia.org';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL1() async {
  const url = 'https://blutreetechnets.co.in/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
