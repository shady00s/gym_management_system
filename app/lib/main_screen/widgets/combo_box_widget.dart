import 'package:fluent_ui/fluent_ui.dart';

class ComboBoxWidget extends StatefulWidget {
  final List<dynamic> items;
  final String filterTitle;
  final Function onChanged;

  const ComboBoxWidget({super.key,required this.items,required this.filterTitle,required this.onChanged});

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
    return selectedValue == null? const Center(child: ProgressRing(),):  Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        Text(widget.filterTitle),
        ComboBox(
            value: selectedValue,
            onChanged: (value){
              setState(() {
                selectedValue = value!;
              });
              widget.onChanged(value);
            },
            items:
             widget.items.map((e) => ComboBoxItem(value: e,child: Text(e.title),)).toList()
            )
      ],
    );
  }
}
