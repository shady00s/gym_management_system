import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';

class OnBoardPlayers extends StatelessWidget {
  final String title;
   OnBoardPlayers({super.key,required this.title});

  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: MediaQuery.sizeOf(context).height * 0.9,
      child:  Card(child:
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  Text("22"),
                ],
              ),
              const SizedBox(height: 40,),
              Expanded(child:Scrollbar(
                controller: _firstController,
                  thumbVisibility: true,
                  child: ListView.builder(
                      controller: _firstController,
                    itemCount: 40,
                  shrinkWrap: false,
                  itemBuilder: (context,index)=>PlayerNameWidget("",0))))
            ],
          ),
        ),),
    );
  }
}
