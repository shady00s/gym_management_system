class TeamsDataModel{

  final String bestTeamName;
  final String worstTeamName;
  final int bestTeamTotalPlayer;
  final int worstTeamTotalPlayer;
  final int bestTeamRevenue;
  final int worstTeamRevenue;

  TeamsDataModel(
      { required this.bestTeamName,
       required this.bestTeamTotalPlayer,
       required this.worstTeamTotalPlayer,
        required this.worstTeamName,
        required this.bestTeamRevenue,
        required this.worstTeamRevenue});

}

class TeamDate {
   final String teamName;
   final int playersNumber;
   final int revenue;

  TeamDate({required this.teamName,required this.playersNumber,required this.revenue});

}