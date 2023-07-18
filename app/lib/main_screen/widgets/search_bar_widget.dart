import 'package:flutter/material.dart';

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
            child: TextFormField(
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
                decoration: InputDecoration(
                    hintText: "Search here",
                    helperText:showHint?"Search for players by name, ID or phone number":"",
                  suffix: changed?IconButton(onPressed:(){
                    setState(() {
                      _controller.text = "";
                      changed = false;
                    });
                  },icon:const Icon(Icons.close,color: Colors.grey,)):null
                )
            ),
          ),
          IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}
