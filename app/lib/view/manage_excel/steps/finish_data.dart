import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/database_management/models/backup_data_models.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/view/manage_excel/cubit/cubit.dart';
import 'package:gym_management/view/manage_excel/ui_widget.dart';

import '../cubit/state.dart';

class FinishDataWidget extends StatelessWidget {
  const FinishDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExcelFileCubit, ImportExcelState>(
      builder: (BuildContext context, state) {
        int playersListLength =
            ExcelFileCubit.get(context).excelPlayersList.length;



        List<ExcelPlayers> excelPlayers =
            ExcelFileCubit.get(context).excelPlayersList;
        return Card(
            backgroundColor: Colors.black,
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.95,
                height: MediaQuery.sizeOf(context).height * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        backgroundColor: const Color.fromRGBO(21, 47, 34, 1.0),
                        child: SizedBox(
                          width: 540,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                const Text("Success",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                const SizedBox(height: 17),
                                Text("Found $playersListLength players in the excel sheet"),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 130,
                                  width: 500,
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      children: ExcelFileCubit.get(context)
                                          .getNumberOfPlayersInEachTeam()
                                          .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 3),
                                            child: SizedBox(
                                              width: 90,
                                              child: Card(
                                                child: Column(
                                              children: [
                                                Text(e.teamName),
                                                Text(e.playersNumber.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                              ],
                                            ),
                                              ),
                                            ),
                                          ))
                                          .toList(),
                                    ),
                                  ),
                                )



                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // reset players database
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.41,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Reset Players database:",
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Removes every player / subscription from your database",
                                        style: TextStyle(color: Colors.grey[80]),
                                      ),
                                    ),
                                  ]),
                              Button(
                                child: const Text("Reset database"),
                                onPressed: () async {
                                  await loadingDialog(
                                          context,
                                          -1,
                                          PlayersDatabaseManager()
                                              .dropPlayersAndSubscriptionsTable(),
                                          null)
                                      .then((value) => displayInfoBar(context,
                                          builder: (context, close) =>
                                              const InfoBar(
                                                  title: Text(
                                                      "Successfully deleted"))));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    // insert data to current database
                    Align(
                      alignment: AlignmentDirectional.topStart,

                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Insert new Players data:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Add new data to existed database",
                                          style:
                                              TextStyle(color: Colors.grey[80]),
                                        ),
                                      ),
                                    ]),
                                Button(
                                  child: const Text("Insert players"),
                                  onPressed: () async {
                                    await loadingDialog(
                                            context,
                                            -1,
                                            PlayersDatabaseManager()
                                                .insertPlayersFromExcelOffline(
                                                    excelPlayers),
                                            null)
                                        .then((value) => displayInfoBar(context,
                                            builder: (context, close) =>
                                                const InfoBar(
                                                    title: Text(
                                                        "Added successfully to database"))));
                                  },
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                )));
      },
    );
  }
}
