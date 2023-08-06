import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/main_screen/player_status_widget.dart';

class CustomDateModel {
  final DateTime begDate;
  final DateTime endDate;

  CustomDateModel(this.begDate, this.endDate);
}

Future _showDateRangePicker(BuildContext context) async {
  DateTime begCurrentDateTime = DateTime.now();
  DateTime endCurrentDateTime = DateTime.now();
  await Navigator.pushReplacement(context,
          m.MaterialPageRoute(builder: (context) => const PlayerStatusWidget()))
      .then((value) async {
    await showDialog(
        context: context,
        builder: (context) => ContentDialog(
              title: Text("Select custom date"),
              content: StatefulBuilder(builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Please select beginning date and end date"),
                    ),
                    DatePicker(
                      header: "Beginning date",
                      onChanged: (val) {
                        setState(() => begCurrentDateTime = val);
                      },
                      selected: begCurrentDateTime,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    DatePicker(
                        onChanged: (val) {
                          setState(() => endCurrentDateTime = val);
                        },
                        header: "End date",
                        selected: endCurrentDateTime),
                  ],
                );
              }),
              actions: [
                Consumer(builder: (key, ref, child) {
                  var changedCustomDateTime =
                      ref.read(customEndSubscriptionDateProvider.notifier);
                  return Button(
                      child: Text("Proceed"),
                      onPressed: () {
                        changedCustomDateTime.state = CustomDateModel(begCurrentDateTime, endCurrentDateTime);
                        Navigator.pop(context);
                      });
                }),
                Button(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ));
  });
}

class ComboBoxWidget extends StatefulWidget {
  final List<dynamic> items;
  final String filterTitle;
  final Function onChanged;

  const ComboBoxWidget(
      {super.key,
      required this.items,
      required this.filterTitle,
      required this.onChanged});

  @override
  State<ComboBoxWidget> createState() => _ComboBoxWidgetState();
}

class _ComboBoxWidgetState extends State<ComboBoxWidget> {
  dynamic selectedValue;

  @override
  void initState() {
    setState(() {
      selectedValue = widget.items.first;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return selectedValue == null
        ? const Center(
            child: ProgressRing(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.filterTitle),
                ComboBox(
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                      });
                      widget.onChanged(value);
                    },
                    items: [
                      ...widget.items
                          .map((e) => ComboBoxItem(
                                value: e,
                                child: Text(e.title),
                              ))
                          .toList(),
                      ComboBoxItem(
                        value: 0,
                        child: Text("Custom"),
                        onTap: () async {
                          await _showDateRangePicker(context);
                        },
                      )
                    ])
              ],
            ),
          );
  }
}
