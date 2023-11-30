import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();
  String eventName = '';
  DateTime selectedDate = DateTime.now();
  List<String> orga = [];
  List<String> guests = [];
  bool showOrgaInput = false;
  bool showGuestInput = false;
  final orgaController = TextEditingController();
  final guestController = TextEditingController();

  @override
  void dispose() {
    orgaController.dispose();
    guestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Event'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter Event name'),
              onChanged: (value) {
                setState(() {
                  eventName = value;
                });
              },
            ),
            ListTile(
              title: Text('Date: ${selectedDate.toLocal().toString().split(' ')[0]}'), // Remove time from date
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
            ),
            Center(child: Text('Orga')),
            if (showOrgaInput)
              TextFormField(
                controller: orgaController,
                decoration: InputDecoration(labelText: 'Enter Orga name'),
                onFieldSubmitted: (value) {
                  setState(() {
                    orga.add(value);
                    orgaController.clear();
                    showOrgaInput = false;
                  });
                },
              ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  showOrgaInput = true;
                });
              },
            ),
            ...orga.map((String orgaName) => GestureDetector(
              onTap: () async {
                final newName = await showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Edit name'),
                    content: TextFormField(
                      initialValue: orgaName,
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(context).pop(orgaController.text),
                      ),
                    ],
                  ),
                );
                if (newName != null) {
                  setState(() {
                    orga[orga.indexOf(orgaName)] = newName;
                  });
                }
              },
              child: ListTile(title: Text(orgaName)),
            )),
            Center(child: Text('Guests')),
            if (showGuestInput)
              TextFormField(
                controller: guestController,
                decoration: InputDecoration(labelText: 'Enter Guest name'),
                onFieldSubmitted: (value) {
                  setState(() {
                    guests.add(value);
                    guestController.clear();
                    showGuestInput = false;
                  });
                },
              ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  showGuestInput = true;
                });
              },
            ),
            ...guests.map((String guestName) => GestureDetector(
              onTap: () async {
                final newName = await showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Edit name'),
                    content: TextFormField(
                      initialValue: guestName,
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(context).pop(guestController.text),
                      ),
                    ],
                  ),
                );
                if (newName != null) {
                  setState(() {
                    guests[guests.indexOf(guestName)] = newName;
                  });
                }
              },
              child: ListTile(title: Text(guestName)),
            )),
          ],
        ),
      ),
    );
  }
}