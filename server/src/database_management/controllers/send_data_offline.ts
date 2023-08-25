import IExcelDataModel from "../../excel_management/excel_data_model";
import { Request, Response } from 'express';

export default function sendDataOffline(req:Request,res:Response){
    let results: IExcelDataModel[] = req.session.playerList

    let processedPlayer = new Set();
    const resultData = []
    let playerData = {};
    let playerId; 
    for (const player of results) {
         playerId = player.id;
         

        

            if (playerData[playerId]) {
                if ((playerData[playerId].name === player.name && playerData[playerId].id === player.id) ) {
                    let playerTeam = [];
                    playerTeam.push(playerData[playerId].team,player.team)
                    playerData[playerId].team = playerTeam;

                    playerData[playerId].subscriptions.push(...player.subscriptions);
                    for(var e of playerData[playerId].subscriptions){
                        e.playerSubscriptionId = playerData[playerId].playerIndexId
                    }
                }if((playerData[playerId].name === player.name  && playerData[playerId].id === player.id && playerData[playerId].team === player.team) ){
                    let playerTeam = [];
                    playerTeam.push(playerData[playerId].team,player.team)
                    playerData[playerId].subscriptions.push(...player.subscriptions);

                    for(var e of playerData[playerId].subscriptions){
                        e.playerSubscriptionId = playerData[playerId].playerIndexId
                    }
                } if (!processedPlayer.has(playerId)) {

                    resultData.push(playerData[playerId]);
                    processedPlayer.add(playerId);
                }
                



            } else {
                playerData[playerId] = player;
                if ((playerData[playerId].name === player.name && playerData[playerId].id === player.id) ) {
                    let playerTeam = [];
                    playerTeam.push(playerData[playerId].team,player.team)
                    playerData[playerId].subscriptions.push(...player.subscriptions);

                    for(var e of playerData[playerId].subscriptions){
                        e.playerSubscriptionId = playerData[playerId].playerIndexId
                    }
                }if((playerData[playerId].name === player.name  && playerData[playerId].id === player.id && playerData[playerId].team === player.team) ){
                    let playerTeam = [];
                    playerTeam.push(playerData[playerId].team,player.team)

                    playerData[playerId].subscriptions.push(...player.subscriptions);

                    for(var e of playerData[playerId].subscriptions){
                        e.playerSubscriptionId = playerData[playerId].playerIndexId
                    }   
                } if (!processedPlayer.has(playerId)) {

                    resultData.push(playerData[playerId]);
                    processedPlayer.add(playerId);
                }
}
}
res.json({message:"succssess",resultData})
}  

