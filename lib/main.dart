import 'package:flutter/material.dart';
import 'package:project_uas/DBHelper.dart';
import 'package:project_uas/Listnote.dart';
import 'package:project_uas/subpage.dart';
import 'package:project_uas/tab_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'BeritaKu',
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = new DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(
        //     Icons.edit,
        //     color: Colors.white,
        //   ),
        //   backgroundColor: Colors.purple,
        //   onPressed: () => Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => new NotePage(null, true),
        //     ),
        //   ),
        // ),
        appBar: AppBar(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: Image.asset("img/news.png"),
          ),
          title: Text(
            'BeritaKu',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        backgroundColor: Colors.grey[200],
        body: FutureBuilder(
            future: db.getNote(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              var data = snapshot.data;

              return snapshot.hasData
                  ? new NoteList(data)
                  : Center(
                      child: Text("No Data"),
                    );
            }),
        bottomNavigationBar: FancyTabBar());
  }
}

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5)),
      boxShadow: [
        BoxShadow(
//          color: Colors.grey.withOpacity(0.5),
//          spreadRadius: 1,
//          blurRadius: 2,
//          offset: Offset(0, 1), // changes position of shadow
            ),
      ],
    );
  }

  Expanded getExpanded(String imageName, String mainText, String subText) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'images/main/$imageName.png',
                    height: 80.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  mainText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  subText,
                  style: TextStyle(
//                              fontWeight: FontWeight.,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
          margin:
              EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
          decoration: getBoxDecoration(),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyHomePage()));
        },
      ),
    );
  }

  BottomNavigationBarItem getBottomNavigationItem(
      String title, IconData IconName) {
    return BottomNavigationBarItem(
      icon: Icon(
        IconName,
        size: 35.0,
      ),
      title: Text(
        '$title',
        style: TextStyle(
          fontSize: 10.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "BeritaKu",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded('notes', 'Artikel', ''),
                  getExpanded('technology', 'Teknologi', ''),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded('running', 'Olahraga', ''),
                  getExpanded('tracking', 'SDA', ''),
                ],
              ),
            ),
            // Expanded(
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       getExpanded('dining', 'Fast Food', ''),
            //       getExpanded('fast-food', 'Featured Foods', ''),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
