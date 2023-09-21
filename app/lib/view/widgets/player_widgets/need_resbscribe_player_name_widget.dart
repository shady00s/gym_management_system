import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/view/widgets/invitation_widget.dart';
import 'package:gym_management/view/widgets/player_widgets/player_card_information.dart';
import 'package:gym_management/view/widgets/player_widgets/player_name_widget.dart';

import '../freeze_widget.dart';
import '../re-subscription/re_subscription_widget.dart';

class NeedToResubscribePlayerNameWidget extends StatelessWidget {
  final String playerName;
  final int playerId;
  final int playerIndexId;
  final DateTime endDate;
  NeedToResubscribePlayerNameWidget(
      {super.key,
      required this.playerName,
      required this.playerId,
      required this.endDate,
      required this.playerIndexId});
  final menuController = FlyoutController();
  @override
  Widget build(BuildContext context) {
    int date = DateTime.now().difference(endDate).inDays;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button(
          onPressed: () async {
            await showGeneralDialog(
                context: context,
                pageBuilder: (_, __, ___) => Card(
                    backgroundColor: const Color.fromRGBO(12, 2, 3, 0.3),
                    child: Center(
                        child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.85,
                            height: MediaQuery.sizeOf(context).height * 0.8,
                            child: Card(
                                backgroundColor: Colors.black,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Player Information",
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(FluentIcons.cancel),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                        child: PlayerCardInformationWidget(
                                      playerId: playerIndexId,
                                    )),
                                    Row(
                                      children: [
                                        Button(
                                          child: const Text("Re-new"),
                                          onPressed: () async {
                                            await showReSubscriptionWidget(
                                                context, playerIndexId);
                                          },
                                        ),
                                        Button(
                                          child: const Text("Invitation"),
                                          onPressed: () async {
                                            await showInvitationWidget(
                                                context, playerIndexId);
                                          },
                                        ),
                                        Button(
                                          child: const Text("Freeze"),
                                          onPressed: () async {
                                            await showFreezeWidget(
                                                context, playerIndexId);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ))))));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlyoutTarget(
                controller: menuController,
                child: Column(
                  children: [
                    Row(
                      children: [
                        OptionsMenu(menuController, playerIndexId),
                        const Spacer(),
                        Text(playerName),
                        Text(
                          " - $playerId ",
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Text(
                      "Subscription ended ${date == 0 ? "today" : date == 1 ? "yesterday" : ' $date days ago'} ",
                      style: const TextStyle(
                          color:
                              Color.fromRGBO(255, 166, 0, 0.7019607843137254)),
                    )
                  ],
                )),
          ),
        ));
  }
}
