import { pool } from "./send_data_to_db_controller";
import { Response, Request } from "express";
export default async function getPlayerInformationData(req:Request,res:Response){
    const playerId= req.query.playerId;

    let playerInfo = {
                player_name:"",
                player_id:"",
                subscriptions:[]
    }
   let result = await pool.query(`
        SELECT PLAYERS.*, SUBSCRIPTIONSDB.*
        from PLAYERS 
        JOIN SUBSCRIPTIONSDB
        ON PLAYERS.player_id =  SUBSCRIPTIONSDB.player_subscription_id
        WHERE PLAYERS.player_id = ${playerId}
    `)
    for (let data of result.rows) {
        if(playerInfo){
            playerInfo["player_name"] = data.player_name
            playerInfo["player_id"] = data.player_id
            playerInfo.subscriptions.push({
                player_subscription_id:data.player_subscription_id,
                billid:data.billid,
                beginning_date:data.beginning_date,
                end_date:data.end_date,
                billValue:data.billValue,
                duration:data.duration,
                billCollector:data.billCollector
            })
        }else{
            playerInfo = {
                player_name:data.player_name,
                player_id:data.player_id,
                subscriptions:[]}
        }
        
    }
    res.json({message:"succssess",data:playerInfo})
}