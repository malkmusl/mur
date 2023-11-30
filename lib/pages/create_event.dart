// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();
  String eventName = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
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
        title: const Text('Create new Event'),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Enter Event name'),
                      onChanged: (value) {
                        setState(() {
                          eventName = value;
                        });
                      },
                    ),
                    ListTile(
                      title: Text(
                          'Date: ${selectedDate.toLocal().toString().split(' ')[0]}'), // Remove time from date
                      trailing: const Icon(Icons.keyboard_arrow_down),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: Text('Time: ${selectedTime.format(context)}'),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null && picked != selectedTime) {
                          setState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                    ),
                    const Center(child: Text('Orga')),
                    if (showOrgaInput)
                      TextFormField(
                        controller: orgaController,
                        decoration:
                            const InputDecoration(labelText: 'Enter Orga name'),
                        onFieldSubmitted: (value) {
                          setState(() {
                            orga.add(value);
                            orgaController.clear();
                            showOrgaInput = false;
                          });
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.add),
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
                                title: const Text('Edit name'),
                                content: TextFormField(
                                  initialValue: orgaName,
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () => Navigator.of(context)
                                        .pop(orgaController.text),
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
                    const Center(child: Text('Guests')),
                    if (showGuestInput)
                      TextFormField(
                        controller: guestController,
                        decoration: const InputDecoration(
                            labelText: 'Enter Guest name'),
                        onFieldSubmitted: (value) {
                          setState(() {
                            guests.add(value);
                            guestController.clear();
                            showGuestInput = false;
                          });
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.add),
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
                                title: const Text('Edit name'),
                                content: TextFormField(
                                  initialValue: guestName,
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () => Navigator.of(context)
                                        .pop(guestController.text),
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
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  // Save event
                },
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: const Icon(Icons.save),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
