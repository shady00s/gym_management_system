import { Request,Response } from "express";
import { client, pool } from "./send_data_to_db_controller";


export default async function getPlayerDataFromDB(req:Request,res:Response){
  
  let result =  await pool.query("SELECT * FROM PLAYERS")
  
    res.json({message:"succssess",data:result.rows})
}