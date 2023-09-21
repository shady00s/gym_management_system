import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_name_with_image_widget.dart';

import '../../../database_management/tables/generate_table.dart';
final searchInput = StateProvider((ref) => "");
final searchResult = FutureProvider<List<Player?>>((ref)async => await PlayersDatabaseManager().searchForPlayer(ref.watch(searchInput)));


class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
          const PopupSearch(),

          Expanded(child: Consumer(builder: (BuildContext context,  ref, Widget? child) {
            AsyncValue<List<Player?>> d  =  ref.watch(searchResult);

            return d.when(data:(val)=> val.isNotEmpty? ListView.builder(
                itemCount: val.length,
                itemBuilder: (context,index)=>FluentTheme(data: FluentThemeData.dark(),
                child: PlayerNameWithImage(playerName: val[index]!.playerName, playerId: val[index]!.playerId, imagePath:val[index]!.imagePath, playerIndexId: val[index]!.playerIndexId,),) )
                :Center(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FluentIcons.search_data,size: 55,color: Colors.grey[100],),
                    const Text("no result"),
                  ],
                )), error: (err,stack)=>Text(err.toString()), loading:()=> const Center(child: ProgressBar(),));
          },))

        ],);

  }
}



class PopupSearch extends StatefulWidget {
  const PopupSearch({super.key});

  @override
  State<PopupSearch> createState() => _PopupSearchState();
}

class _PopupSearchState extends State<PopupSearch> {
  final TextEditingController _controller = TextEditingController();
  bool changed = false;
  bool showHint = false;
  @override
  Widget build(BuildContext context) {
    return  Padding(
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

            }, icon: const Icon(FluentIcons.search));
          },)

        ],
      ),
    );
  }
}
