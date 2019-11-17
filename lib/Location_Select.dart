import 'package:flutter/material.dart';

class SelectLocation extends StatefulWidget {
  final List locationList;
  SelectLocation(this.locationList);
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

final myController = TextEditingController();

class _SelectLocationState extends State<SelectLocation> {
  @override
  void initState() {
    myController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextField(
            controller: myController,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: 'Search region (country/region)', fillColor: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.locationList.where((x) => x.contains(myController.text)).toList().length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.black87,
              child: ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                dense: true,
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 4, 4, 4),
                  child: Text(widget.locationList.where((x) => x.contains(myController.text)).toList()[index], textAlign: TextAlign.left,style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}