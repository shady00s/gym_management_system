import 'dart:io';
import 'package:drift/drift.dart' as d;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/view/widgets/take_new_image_widget.dart';
import 'package:gym_management/view/manage_excel/ui_widget.dart';
import 'package:intl/intl.dart';

import '../../../database_management/tables/subscriptions/subscriptions_information_manager.dart';

class AddNewPlayerWidget extends StatefulWidget {
  const AddNewPlayerWidget({super.key});

  @override
  State<AddNewPlayerWidget> createState() => _AddNewPlayerWidgetState();
}

var playerImageProvider = StateProvider<String?>((ref) => null);
var billImageProvider = StateProvider<String?>((ref) => null);
var subscriptionProvider =
    StateProvider<SubscriptionsInfoTableData?>((ref) => null);
var getSubscriptionsProvider = FutureProvider<List<SubscriptionsInfoTableData>>(
  (ref) => SubscriptionInformationManager().getAllSubscriptions(),
);

class PlayerData {
  final int indexId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String gender;
  final String imagePath;
  final int age;
  final int phoneNumber;

  PlayerData(
      {required this.indexId,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.gender,
      required this.imagePath,
      required this.age,
      required this.phoneNumber});
}

class SubscriptionData {
  final String imagePath;
  final String collectorId;
  final int billId;

  final DateTime customDate;

  SubscriptionData(
      {required this.imagePath,
      required this.collectorId,
      required this.billId,
      required this.customDate});
}

Future createNewPlayer(PlayerData player,
    SubscriptionsInfoTableData? subInfoData, SubscriptionData subData) async {
  int id = await PlayersDatabaseManager().createPlayerId();

  PlayersCompanion playerData = PlayersCompanion.insert(
      playerIndexId: player.indexId,
      playerId: id,
      playerName: "${player.firstName} ${player.middleName} ${player.lastName}",
      playerPhoneNumber: player.phoneNumber,
      imagePath: player.imagePath,
      playerAge: player.age,
      playerFirstJoinDate: DateTime.now(),
      playerGender: player.gender,
      subscriptionId: player.indexId);

  PlayersSubscriptionsCompanion subscription =
      PlayersSubscriptionsCompanion.insert(
          billImagePath: d.Value(subData.imagePath),
          teamId: subInfoData!.teamId,
          freezeAvailable: subInfoData.subscriptionFreezeLimit,
          invitationAvailable: subInfoData.subscriptionInvitationLimit,
          subscriptionPayDate: DateTime.now(),
          playerSubscriptionId: player.indexId,
          beginningDate: subData.customDate,
          endDate: DateTime.now()
              .add(Duration(days: subInfoData.subscriptionDuration)),
          billId: subData.billId,
          billValue: subInfoData.subscriptionValue,
          duration: subInfoData.subscriptionDuration,
          billCollector: subData.collectorId,
          subscriptionInfoId: subInfoData.id!);
  return await PlayersDatabaseManager().addNewPlayer(playerData, subscription);
}

class _AddNewPlayerWidgetState extends State<AddNewPlayerWidget> {
  SubscriptionsInfoTableData? test;
  String? billCollector;
  File? playerImage;
  File? billImage;
  String gender = "Male";
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String collectorId = "";
  final TextEditingController _beginDateController = TextEditingController();
  int phoneNumber = 20;
  int age = 0;
  DateTime? customDate;
  bool isNoImage = false;
  int? billId;
  submitFunction() {
    setState(() {
      _beginDateController.text = DateFormat.yMMMEd().format(customDate!);
    });
    Navigator.pop(context);
  }

  cancelFunction() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    setState(() {
      _beginDateController.text = DateFormat.yMMMEd().format(DateTime.now());
      customDate = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.96,
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Card(
            backgroundColor: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add new player",
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Consumer(builder: (context, ref, child) {
                      var image1 = ref.watch(billImageProvider);
                      var image2 = ref.watch(playerImageProvider);

                      return IconButton(
                        onPressed: () async {
                          await Future.delayed(Duration.zero, () async {
                            if (image1 != null) {
                              await File(image1)
                                  .delete(recursive: true)
                                  .then((value) {
                                var imageState =
                                    ref.read(billImageProvider.notifier);

                                imageState.state = null;
                              });
                            }
                            if (image2 != null) {
                              await File(image2)
                                  .delete(recursive: true)
                                  .then((value) {
                                var imageState2 =
                                    ref.read(playerImageProvider.notifier);

                                imageState2.state = null;
                              });
                            }
                          }).then((_) {
                            Navigator.of(context).pop();
                          });
                        },
                        icon: const Icon(FluentIcons.cancel),
                      );
                    })
                  ],
                ),
                Row(
                  children: [
                    // player information
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: key,
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.71,
                            width: 400,
                            child: AspectRatio(
                              aspectRatio: 3 / 2,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Player Info",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),

                                    // select player image
                                    const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          "Player image",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19),
                                        )),
                                    TakeNewImageWidget(
                                      path: 'players_images',
                                      state: playerImageProvider,
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
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19),
                                        )),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: TextFormBox(
                                          placeholder: "first name",
                                          controller: firstName,
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: TextFormBox(
                                          placeholder: "second name",
                                          controller: middleName,
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: TextFormBox(
                                          placeholder: "third name",
                                          controller: lastName,
                                        )),
                                      ],
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    // age
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
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    //phone number
                                    const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          "Phone number",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: NumberFormBox(
                                        value: phoneNumber,
                                        onChanged: (val) {
                                          setState(() {
                                            phoneNumber = val!;
                                          });
                                        },
                                      ),
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            const Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  "Gender",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 19),
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ComboBox(
                                                  value: gender,
                                                  onChanged: (data) {
                                                    setState(() {
                                                      gender = data!;
                                                    });
                                                  },
                                                  items: const [
                                                    ComboBoxItem(
                                                        value: "Male",
                                                        child: Text("Male")),
                                                    ComboBoxItem(
                                                        value: "Female",
                                                        child: Text("Female"))
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 12,
                                        ),

                                        // player subscription
                                        Column(
                                          children: [
                                            const Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  "Subscription",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 19),
                                                )),
                                            Consumer(
                                                builder: (context, ref, child) {
                                              var subscription = ref.read(
                                                  subscriptionProvider
                                                      .notifier);
                                              var getSubscriptions = ref.watch(
                                                  getSubscriptionsProvider);

                                              return getSubscriptions.when(
                                                  data: (snapshot) {
                                                    if (snapshot.isNotEmpty) {
                                                      return ComboBox(
                                                          value: test,
                                                          placeholder: const Text(
                                                              "Select subscription"),
                                                          onChanged:
                                                              (val) async {
                                                            subscription.state =
                                                                val;
                                                            Future.delayed(
                                                                Duration.zero,
                                                                () {
                                                              setState(() {
                                                                test = val;
                                                              });
                                                            });
                                                          },
                                                          items: snapshot
                                                              .map((e) =>
                                                                  ComboBoxItem(
                                                                      value: e,
                                                                      child: Text(
                                                                          e.subscriptionName)))
                                                              .toList());
                                                    }
                                                    return const Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                            "No subscription found"),
                                                      ),
                                                    );
                                                  },
                                                  error: (err, state) =>
                                                      Text(err.toString()),
                                                  loading: () => const Center(
                                                        child: ProgressBar(),
                                                      ));
                                            }),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // player gender
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.77,
                      width: 450,
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Card(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Bill Info",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Enter beginning date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormBox(
                                  showCursor: false,
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                                builder: (context, setState) {
                                              return ContentDialog(
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                        "Select custom date"),
                                                    IconButton(
                                                        icon: const Icon(
                                                            FluentIcons.cancel),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  ],
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                        "NOTE: system cannot accept old date"),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: DatePicker(
                                                        showYear: false,
                                                        startDate:
                                                            DateTime.now(),
                                                        selected: customDate,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            customDate = val;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    if (customDate != null &&
                                                        customDate!
                                                            .difference(
                                                                DateTime.now())
                                                            .inDays
                                                            .isNegative)
                                                      Text(
                                                        "please select date newer  date",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 19),
                                                      ),
                                                  ],
                                                ),
                                                actions: customDate != null &&
                                                        !customDate!
                                                            .difference(
                                                                DateTime.now())
                                                            .inDays
                                                            .isNegative
                                                    ? [
                                                        FilledButton(
                                                            onPressed:
                                                                submitFunction,
                                                            child: const Text(
                                                                "submit")),
                                                        Button(
                                                            onPressed:
                                                                cancelFunction,
                                                            child: const Text(
                                                                "cancel")),
                                                      ]
                                                    : null,
                                              );
                                            }));
                                  },
                                  readOnly: true,
                                  controller: _beginDateController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "pay amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 170,
                                    child: Consumer(
                                        builder: (context, ref, child) {
                                      var subData =
                                          ref.watch(subscriptionProvider);
                                      return NumberFormBox(
                                        value: subData?.subscriptionValue,
                                        initialValue: subData.toString(),
                                      );
                                    })),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "collector id",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormBox(
                                  onChanged: (val) {
                                    setState(() {
                                      collectorId = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please add your ID";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Bill image",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )),
                                SizedBox(
                                    height: 120,
                                    child: TakeNewImageWidget(
                                      path: "re-subscription_images",
                                      state: billImageProvider,
                                    )),
                                if (isNoImage)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'please add bill image',
                                      style: TextStyle(
                                          color: Colors.red.lighter,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Bill ID",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                NumberFormBox(
                                  value: billId,
                                  onChanged: (val) {
                                    setState(() {
                                      billId = val!;
                                    });
                                  },
                                  validator: (val) {
                                    if (val == null) {
                                      return "Please add bill ID";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 21,
                ),
                Center(
                  child: Consumer(builder: (context, ref, child) {
                    var imagePath = ref.watch(playerImageProvider);
                    var imagePath2 = ref.watch(billImageProvider);
                    var setImagePath = ref.read(playerImageProvider.notifier);
                    var setImagePath2 = ref.read(billImageProvider.notifier);
                    var subInfoData = ref.watch(subscriptionProvider);
                    return FilledButton(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Add player"),
                        ),
                        onPressed: () async {
                          if (key.currentState!.validate() &&
                              imagePath != null &&
                              imagePath2 != null) {
                            int indexId = int.parse(
                                phoneNumber.toString().substring(3, 11));

                            PlayerData playerData = PlayerData(
                                indexId: indexId,
                                firstName: firstName.text,
                                middleName: middleName.text,
                                lastName: lastName.text,
                                gender: gender,
                                imagePath: imagePath,
                                age: age,
                                phoneNumber: phoneNumber);
                            SubscriptionData subscriptionData =
                                SubscriptionData(
                                    imagePath: imagePath2,
                                    collectorId: collectorId,
                                    billId: billId!,
                                    customDate: customDate!);

                            await loadingDialog(
                                    context,
                                    -1,
                                    createNewPlayer(playerData, subInfoData,
                                        subscriptionData),
                                    null)
                                .then((value) {
                              setImagePath.state = null;
                              setImagePath2.state = null;
                              Navigator.pop(context);
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
    );
  }
}
