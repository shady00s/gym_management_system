import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/player_database_manager.dart';
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}



class _SearchBarWidgetState extends State<SearchBarWidget> {
   final TextEditingController _controller = TextEditingController();
    bool changed = false;
    bool showHint = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextBox(
              onTap: () {
                setState(() {
                  showHint = true;
                });
              },
              onTapOutside: (event) {
                setState(() {
                  showHint = false;
                });
              },
              onChanged: (val) {
                val.isNotEmpty || val != "" ? setState(() {
                  changed = true;
                }) : setState(() {
                  changed = false;
                });
              },
              suffix: changed
                  ? IconButton(onPressed: () {
                setState(() {
                  _controller.text = "";
                  changed = false;
                });
              }, icon:  Icon(FluentIcons.cancel, color: Colors.grey[40],))
                  : null,
              placeholder: "Search here",
              controller: _controller,

            ),
          ),
          IconButton(onPressed: () async{

            PlayersDatabaseManager().searchForPlayer(_controller.text);

            await showDialog(context: context, builder: (context)=>ContentDialog(content: Column(children: [

              ],),));
          }, icon: const Icon(FluentIcons.search))
        ],
      ),
    );
  }
}
