import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/view/widgets/player_widgets/player_status/player_status_widget.dart';

class CustomBoxData {
  final String title;
  final dynamic id;
  CustomBoxData({required this.title, required this.id});
}

class CustomDateModel {
  final DateTime begDate;
  final DateTime endDate;

  CustomDateModel(this.begDate, this.endDate);
}

Future _showDateRangePicker(BuildContext context, dynamic provider) async {
  DateTime begCurrentDateTime = DateTime.now();
  DateTime endCurrentDateTime = DateTime.now();
  await Navigator.pushReplacement(context,
          m.MaterialPageRoute(builder: (context) => const PlayerStatusWidget()))
      .then((value) async {
    await showDialog(
        context: context,
        builder: (context) => Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              var setFilter = ref.read(provider.notifier);

              return ContentDialog(
                  title: const Text("Select custom date"),
                  content: StatefulBuilder(builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child:
                              Text("Please select beginning date and end date"),
                        ),
                        DatePicker(
                          header: "Beginning date",
                          onChanged: (val) {
                            setState(() => begCurrentDateTime = val);
                          },
                          selected: begCurrentDateTime,
                        ),
                        const SizedBox(
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
                      return Button(
                          child: const Text("Proceed"),
                          onPressed: () {
                            setFilter.setDuration(DurationModel(
                                title: "Custom",
                                value: DurationTime(
                                    begDate: begCurrentDateTime,
                                    endDate: endCurrentDateTime)));

                            Navigator.pop(context);
                          });
                    }),
                    Button(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ]);
            }));
  });
}

class ComboBoxWidget extends StatefulWidget {
  final List<CustomBoxData> items;
  final String filterTitle;
  final Function onChanged;
  final bool allButton;

  const ComboBoxWidget(
      {super.key,
      required this.items,
      required this.filterTitle,
      required this.onChanged,
      required this.allButton});

  @override
  State<ComboBoxWidget> createState() => _ComboBoxWidgetState();
}

class _ComboBoxWidgetState extends State<ComboBoxWidget> {
  dynamic selectedValue;

  @override
  void initState() {
    setState(() {
      selectedValue = widget.allButton ? "null" : widget.items.first;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.items.isEmpty
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
                      if (widget.allButton)
                        const ComboBoxItem(
                          value: "null",
                          child: Text("All"),
                        ),
                      ...widget.items
                          .map((e) => ComboBoxItem(
                                value: e,
                                child: Text(e.title),
                              ))
                          .toList(),
                    ])
              ],
            ),
          );
  }
}

class ComboBoxWidgetForFilter extends StatefulWidget {
  final List<dynamic> items;
  final String filterTitle;
  final Function onChanged;
  final bool allButton;
  final dynamic provider;
  final bool isSubscriptionWithName;
  const ComboBoxWidgetForFilter(
      {super.key,
      required this.items,
      required this.provider,
      required this.filterTitle,
      required this.onChanged,
      required this.allButton,
      required this.isSubscriptionWithName});

  @override
  State<ComboBoxWidgetForFilter> createState() =>
      _ComboBoxWidgetForFilterState();
}

class _ComboBoxWidgetForFilterState extends State<ComboBoxWidgetForFilter> {
  dynamic selectedValue;

  @override
  void initState() {
    setState(() {
      selectedValue = widget.allButton && !widget.isSubscriptionWithName
          ? "null"
          : widget.items.first;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.items.isEmpty
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
                      if (widget.allButton && !widget.isSubscriptionWithName)
                        const ComboBoxItem(
                          value: "null",
                          child: Text("All"),
                        ),
                      ...widget.items
                          .map((e) => ComboBoxItem(
                                value: e,
                                child: Text(e.title),
                              ))
                          .toList(),
                      if (!widget.allButton)
                        ComboBoxItem(
                          value: 0,
                          child: const Text("Custom"),
                          onTap: () async {
                            await _showDateRangePicker(
                                context, widget.provider);
                          },
                        )
                    ])
              ],
            ),
          );
  }
}
