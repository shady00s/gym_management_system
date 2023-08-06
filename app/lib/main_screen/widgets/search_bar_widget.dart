import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/search_result_widget.dart';
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
              placeholder: "Search here with player name or id or phone number.",
              controller: _controller,

            ),
          ),
          Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var changeName =  ref.read(searchInput.notifier);

            return IconButton(onPressed: () async{
              changeName.state = _controller.text;


              await showDialog(context: context, builder: (context)=> ContentDialog(

                title:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Search"),
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    },
                      icon:const Icon(FluentIcons.cancel),
                    ),
                  ],
                ) ,

                content: const SearchResultWidget(),));
            }, icon: const Icon(FluentIcons.search));
          },)

        ],
      ),
    );
  }
}
