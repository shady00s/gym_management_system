import 'package:flutter/material.dart' as material;
import 'package:fluent_ui/fluent_ui.dart';
<<<<<<< HEAD
import 'package:postgres/postgres.dart';
=======
>>>>>>> dfe21ebe445093fe750dd1a645359e867aec6151
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}


Future<void> connectToPostgres() async{
    var connection = PostgreSQLConnection(
      "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope"
    , 5432,
      "gym_database_8ope",
      username: "shady",
      password: "gTxyDyzytUOEfRL080FX0epSmDnN0uXr",
        useSSL: true,

    );

    await connection.open().then((_){
        connection.query("SELECT * FROM PLAYERS").then((value) => print(value));
    }).catchError((err){
      print(err);
    });
    
}
class _SearchBarWidgetState extends State<SearchBarWidget> {
   final TextEditingController _controller = TextEditingController();
    bool changed = false;
    bool showHint = false;
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return FutureBuilder(
        future: connectToPostgres(),

        builder: (context,snapshot){

      switch (snapshot.connectionState){
        case ConnectionState.waiting:
          return const Center(child: ProgressRing(),);

        case ConnectionState.done:
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextBox(
                      onTap: (){
                        setState(() {
                          showHint = true;
                        });
                      },
                      onTapOutside: (event){
                        setState(() {
                          showHint = false;
                        });
                      },
                      onChanged: (val){
                        val.isNotEmpty || val !="" ? setState((){changed = true;}):setState((){changed = false;});
                      },
                      suffix: changed?IconButton(onPressed:(){
                        setState(() {
                          _controller.text = "";
                          changed = false;
                        });
                      },icon:const Icon(FluentIcons.cancel,color: Colors.grey,)):null,
                      placeholder:  "Search here",
                      controller: _controller,

                  ),
                ),
                IconButton(onPressed: (){}, icon: const Icon(FluentIcons.search))
              ],
            ),
          );
        default:
          return const Center(child: ProgressRing(),);
      }

    })
    ;
=======
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextBox(
              onTap: (){
                setState(() {
                  showHint = true;
                });
              },
                onTapOutside: (event){
                  setState(() {
                    showHint = false;
                  });
                },
              onChanged: (val){
                val.isNotEmpty || val !="" ? setState((){changed = true;}):setState((){changed = false;});
              },
              controller: _controller,

                    placeholder: "Search here",
                  suffix: changed?IconButton(onPressed:(){
                    setState(() {
                      _controller.text = "";
                      changed = false;
                    });
                  },icon:const Icon(material.Icons.close,color: Colors.grey,)):null
                )
            ),

          IconButton(onPressed: (){}, icon: const Icon(FluentIcons.search))
        ],
      ),
    );
>>>>>>> dfe21ebe445093fe750dd1a645359e867aec6151
  }
}
