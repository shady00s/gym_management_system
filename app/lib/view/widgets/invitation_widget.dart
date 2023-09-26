import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/view/widgets/player_widgets/add_new_player.dart';
import 'package:gym_management/view/widgets/player_widgets/player_name_with_image_widget.dart';

import 'package:gym_management/view/widgets/take_new_image_widget.dart';

import '../../database_management/tables/generate_table.dart';

Future showInvitationWidget(context, int playerIndexId) async {
  await showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, animation2) => InvitationWidget(
            playerIndexId: playerIndexId,
          ));
}

GlobalKey<FormState> key = GlobalKey<FormState>();
TextEditingController firstName = TextEditingController();
TextEditingController middleName = TextEditingController();
TextEditingController lastName = TextEditingController();
int phoneNumber = 20;
File? image;
String gender = "Male";
bool isNoImage = false;
bool isPhoneNumberChecked = false;
int guestPhoneNumber = 20;
Player? foundedPlayer;
int age = 0;

class InvitationWidget extends StatelessWidget {
  final int playerIndexId;

  const InvitationWidget({super.key, required this.playerIndexId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 420,
        height: MediaQuery.sizeOf(context).width * 0.9,
        child: Card(
          backgroundColor: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Invitation",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow),
                    ),
                    StatefulBuilder(builder: (context, setState) {
                      return IconButton(
                          icon: const Icon(FluentIcons.cancel),
                          onPressed: () {
                            setState(() {
                              isPhoneNumberChecked = false;
                            });

                            Navigator.pop(context);
                          });
                    })
                  ],
                ),
              ),
              FutureBuilder<GetRemainingInvitationResult>(
                  future:
                      PlayersDatabaseManager().getInvitations(playerIndexId),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Expanded(
                            child: Center(
                          child: ProgressRing(),
                        ));
                      case ConnectionState.done:
                        if (snapshot.data != null) {
                          if (snapshot.data!.invitationAvailable == 0 || snapshot.data!.invitationAvailable == -1) {
                            return Expanded(
                                child: Center(
                                    child: Card(
                                        backgroundColor: Colors.red,
                                        child: const Text(
                                            "This player has no invitations left"))));
                          }
                          return Expanded(
                            child: Column(
                              children: [
                                // gym player invitation id
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                            "Player available invitations:"),
                                        Text(
                                          snapshot.data!.invitationAvailable
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return !isPhoneNumberChecked
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "Guest phone number checking",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 19),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 8),
                                                child: NumberFormBox(
                                                  value: guestPhoneNumber,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      guestPhoneNumber = val!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              FilledButton(
                                                  child: const Text("search"),
                                                  onPressed: () async {
                                                    await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          Future.delayed(
                                                              Duration.zero,
                                                              () async {
                                                            await PlayersDatabaseManager()
                                                                .searchForInvitation(
                                                                    guestPhoneNumber)
                                                                .then((value) {
                                                              if (value ==
                                                                  null) {
                                                                setState(() {
                                                                  isPhoneNumberChecked =
                                                                      true;
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              } else {
                                                                setState(() {
                                                                  foundedPlayer =
                                                                      value;
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            });
                                                          });
                                                          return const ContentDialog(
                                                            content:
                                                                ProgressBar(),
                                                          );
                                                        });
                                                  }),
                                              if (foundedPlayer != null && foundedPlayer?.playerIndexId != playerIndexId)
                                                Column(
                                                  children: [
                                                    const SizedBox(height: 30,),
                                                    const Text("Found player in database",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                                    const SizedBox(height: 20,),
                                                    PlayerNameWithImage(
                                                        playerName: foundedPlayer!
                                                            .playerName,
                                                        playerId:
                                                            foundedPlayer!.playerId,
                                                        imagePath: foundedPlayer!
                                                            .imagePath,
                                                        playerIndexId:
                                                            foundedPlayer!
                                                                .playerIndexId),
                                                    FilledButton(
                                                        style:ButtonStyle(backgroundColor: ButtonState.all(Colors.yellow.darker) ),
                                                        child: const Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 3),
                                                      child: Text("Invite"),
                                                    ), onPressed: () async{
                                                          PlayersDatabaseManager().checkForInvitationValidation(foundedPlayer!.playerIndexId,playerIndexId,snapshot.data!.teamId,context);
                                                    })
                                                  ],
                                                ),

                                              if( foundedPlayer?.playerIndexId == playerIndexId)
                                                Column(
                                                  mainAxisAlignment:MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(height: 20,),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("You cannot invite your self",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                                                  )
                                                ],)
                                            ],
                                          )
                                        : AddNewPlayerWithInvitation(teamId:snapshot.data!.teamId,donorId: playerIndexId,);
                                  },
                                )
                              ],
                            ),
                          );
                        }

                        return const Center(
                          child: Text("Error occured"),
                        );
                      default:
                        return const Center(
                          child: ProgressRing(),
                        );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewPlayerWithInvitation extends StatefulWidget {
  final int teamId;
  final int donorId;
  const AddNewPlayerWithInvitation({super.key,required this.teamId,required this.donorId});

  @override
  State<AddNewPlayerWithInvitation> createState() =>
      _AddNewPlayerWithInvitationState();
}

class _AddNewPlayerWithInvitationState
    extends State<AddNewPlayerWithInvitation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // guest information
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Guest information",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
        ),
        Form(
          key: key,
          child: SizedBox(
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // select player image
                  const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Player image",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      )),
                  TakeNewImageWidget(
                    path: 'players_images',
                    state: playerImageProvider,
                  ),
                  if (isNoImage)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'please add profile image',
                        style: TextStyle(
                            color: Colors.red.lighter,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  const Divider(),
                  const SizedBox(
                    height: 12,
                  ),
                  // player name
                  const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Player name",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19),
                      )),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormBox(
                        placeholder: "first name",
                        controller: firstName,
                        validator: (val) {
                          if (val == "") {
                            return "please add first name";
                          } else {
                            return null;
                          }
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextFormBox(
                        placeholder: "middle name",
                        controller: middleName,
                        validator: (val) {
                          if (val == "") {
                            return "please add middle name";
                          } else {
                            return null;
                          }
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextFormBox(
                        placeholder: "last name",
                        controller: lastName,
                        validator: (val) {
                          if (val == "") {
                            return "please add last name";
                          } else {
                            return null;
                          }
                        },
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //phone number
                  const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Phone number",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NumberFormBox(
                      placeholder: "phone number",
                      value: phoneNumber,
                      onChanged: (val){
                        setState(() {
                          phoneNumber = val!;
                        });
                      },
                      validator: (val) {
                        if (val == null || phoneNumber.toString().length < 12) {
                          return "please add phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 12,
                  ),

                  // player age
                  const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Player Age",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NumberFormBox(
                      value: age,
                      onChanged: (val) {
                        setState(() {
                          age = val!;
                        });
                      },
                    ),
                  ),
                  const Divider(),

                  // player gender
                  const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Player gender",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19),
                      )),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ComboBox(
                        value: gender,
                        onChanged: (data) {
                          setState(() {
                            gender = data!;
                          });
                        },
                        items: const [
                          ComboBoxItem(value: "Male", child: Text("Male")),
                          ComboBoxItem(value: "Female", child: Text("Female"))
                        ]),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 12,
                  ),

                  const SizedBox(
                    height: 21,
                  ),
                  Center(
                    child: Consumer(builder: (context, ref, child) {
                      var imagePath = ref.watch(playerImageProvider);
                      var setImagePath = ref.read(playerImageProvider.notifier);
                      return FilledButton(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Submit invitation"),
                          ),
                          onPressed: ()
                          async {
                            if (imagePath == null) {
                              setState(() {
                                isNoImage = true;
                              });
                            }
                            if (key.currentState!.validate() && imagePath != null) {
                              setState(() {
                                isNoImage = false;
                              });
                              await PlayersDatabaseManager().createPlayerId().then((playerId) async{
                                await showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(
                                      Duration.zero,
                                          () async {
                                        int indexId = int.parse(
                                            phoneNumber.toString().substring(3, 11));
                                        PlayersCompanion player = PlayersCompanion.insert(
                                            playerIndexId: indexId,
                                            playerId: playerId,
                                            playerName:"${firstName.text} ${middleName.text} ${lastName.text}",
                                            playerPhoneNumber:phoneNumber, imagePath: imagePath,
                                            playerAge: age,
                                            playerFirstJoinDate: DateTime.now(), playerGender: gender,
                                            subscriptionId: indexId);

                                        await PlayersDatabaseManager().addNewPlayerFromInvitation(player,widget.teamId,widget.donorId,context).then((value) async{
                                          if(value == 200){
                                            await displayInfoBar(context, builder: (context,close)=>const InfoBar(title: Text("Player added successfully")));


                                        WidgetsBinding.instance.addPostFrameCallback((_){
                                          Navigator.pop(context);
                                          setImagePath.state = null;
                                        });
                                          }
                                        });
                                      });

                                  return const ContentDialog(
                                    content:
                                    ProgressBar(),
                                  );
                                }).then((value) => Navigator.pop(context));
                              });




                            }
                          });
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
