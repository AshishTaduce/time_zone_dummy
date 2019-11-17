import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter/services.dart';
import 'package:timezone/standalone.dart';
import 'Location_Select.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var byteData =
  await rootBundle.load('packages/timezone/data/$tzDataDefaultFilename');
  initializeDatabase(byteData.buffer.asUint8List());
  runApp(TimeZone());
}

class TimeZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final String location;
  HomePage({this.location = 'Asia/Kolkata'});
  @override
  _HomePageState createState() => _HomePageState();
}

List listOfLocations = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    initializeTimeZone();
    timeZoneDatabase.locations.keys.forEach((x) => listOfLocations.add(x));
    super.initState();
  }

  Future<void> initializeTimeZone() async {
    await initializeTimeZone();
  }

  String getTimeZone(String location) {
    String sign =
    TZDateTime.now(getLocation(location)).timeZoneOffset.isNegative
        ? '-'
        : '+';

    int hours =
    TZDateTime.now(getLocation(location)).timeZoneOffset.inHours.abs();

    int minutes =
        TZDateTime.now(getLocation(location)).timeZoneOffset.inMinutes;

    return '$sign' + ' ' + '$hours' + ':' + '${minutes % 60}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          primary: false,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 8, 8),
            child: Text('Select time zone'),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert, color: Colors.white)),
            ),
          ],
        ),
        body: Center(
          child: Container(
            color: Colors.black87,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 4, 4, 4),
                    child: Text('Region', style: TextStyle(color: Colors.white),),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 4, 4, 4),
                    child: Text(
                        '${widget.location}  ${getTimeZone(widget.location)}', style: TextStyle(color: Colors.white)),
                  ),
                  onTap: () {
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) =>
                                SelectLocation(listOfLocations)));
                  },
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 4, 4, 4),
                    child: Text(
                      'Time Zone',
                      style: TextStyle(color: Colors.grey.withAlpha(150)),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 4, 4, 4),
                    child: Text(
                      'Kolkata  (GMT +05:30)',
                      style: TextStyle(color: Colors.grey.withAlpha(150)),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) =>
                                SelectLocation(listOfLocations)));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocationsSearch extends SearchDelegate<String> {
  final List<dynamic> cities;

  LocationsSearch(this.cities);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close)),
      IconButton(onPressed: () {}, icon: Icon(Icons.clear_all)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.keyboard_backspace),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List results = listOfLocations
        .where((cityName) => cityName.toLowerCase().contains(query))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            query = results[index];
          },
          dense: true,
          title: Center(
            child: Text(
              results[index],
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List results = listOfLocations
        .where((cityName) => cityName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            query = results[index];
//            Navigator.push(
//                (context),
//                MaterialPageRoute(
//                    builder: (context) => MyHomePage(
//                          location: listOfLocations[index],
//                        )));
          },
          dense: true,
          title: Center(
            child: Text(results[index]),
          ),
        );
      },
    );
  }
}
