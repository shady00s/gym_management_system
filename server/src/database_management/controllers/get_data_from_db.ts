import { Request,Response } from "express";
import { client, pool } from "./send_data_to_db_controller";


export default async function getPlayerDataFromDB(req:Request,res:Response){
  
  let result =  await pool.query("SELECT * FROM PLAYERS")
  let subResults = await pool.query("SELECT * FROM SUBSCRIPTIONSDB")

    res.json({message:"succssess",data:{players:result.rows,subscriptions:subResults.rows}})
}