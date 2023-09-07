import IExcelDataModel from "../../excel_management/excel_data_model";
import { Request, Response } from 'express';

export default function sendDataOffline(req:Request,res:Response){
    let results: IExcelDataModel[] = req.session.playerList

    const prossedPlayerSet = new Set()
    const resultData = []
    let playerData:IExcelDataModel = {
        notOriginalId:false,
        id: 0,
        playerIndexId: 0,
        playerId: 0,
        team: undefined,
        name: ""
    };
    let playerId; 

    let prossedPlayerId;

    for (const player of results) {
         playerId = player.name;
        
         prossedPlayerId = player.name;

        
               if(playerData[playerId]){
                if((playerData[playerId].name === player.name) ){      
    
                    if (!(playerData[playerId].subscriptions!.every(e => player.subscriptions.every(
                                f =>e.team === f.team && e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue)))) {
                                playerData[playerId].subscriptions.push(...player.subscriptions);
        
                            }
                            
                            for(var e of playerData[playerId].subscriptions){
                                e.playerSubscriptionId = playerData[playerId].playerIndexId
                            }

                        }  
                        let teamId = new Set()
                        for (const iterator of playerData[playerId].subscriptions) {
                            if(!teamId.has(iterator.team)){
                                teamId.add(iterator.team)
                            }
                            playerData[playerId].team = Array.from(teamId)
                    }
                        
                        if(!prossedPlayerSet.has(playerId))
                        {
                            prossedPlayerSet.add(playerId)
                            resultData.push(playerData[playerId]);
                        }
               }else{
                playerData[playerId] = player;
                for(var e of playerData[playerId].subscriptions){
                    e.playerSubscriptionId = playerData[playerId].playerIndexId
                }
                        if(!prossedPlayerSet.has(playerId))
                        {
                            prossedPlayerSet.add(playerId)
                            resultData.push(playerData[playerId]);
                        }
               }
}
res.json({message:"succssess",resultData})
}  

