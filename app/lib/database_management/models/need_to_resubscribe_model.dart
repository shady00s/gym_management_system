
class NeedToReSubscribeModel{

  final DateTime endedSub;
  final int playerId;
  final int playerIndexId;
  final String playerName;
  final int playerPhoneNumber;
  final String imagePath;
  final int playerAge;
  final DateTime playerFirstJoinDate;
  final String playerGender;
  final int subscriptionId;

  NeedToReSubscribeModel( { required this.playerId, required this.playerName, required this.playerPhoneNumber, required this.imagePath, required this.playerAge, required this.playerFirstJoinDate, required this.playerGender, required this.subscriptionId,required this.endedSub,required this.playerIndexId,});
}