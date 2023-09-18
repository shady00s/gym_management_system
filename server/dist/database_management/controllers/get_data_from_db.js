"use strict";
// import { Request,Response } from "express";
// import { client, pool } from "./send_data_to_db_controller";
Object.defineProperty(exports, "__esModule", { value: true });
// export default async function getPlayerDataFromDB(req:Request,res:Response){
//    pool.connect( async function(err){
//     if(err){
//       res.json(err)
//     }else{
//       let result =  await pool.query("SELECT * FROM PLAYERS")
//       let subResults = await pool.query("SELECT * FROM SUBSCRIPTIONSDB")
//         //playerteam info
//         let playerteam = await pool.query('SELECT * FROM PlayersTeams')
//         let employees = await pool.query('SELECT * FROM Employees')
//         let teams = await pool.query('SELECT * FROM Teams')
//         res.json({message:"succssess",data:{players:result.rows,subscriptions:subResults.rows,playerteam:playerteam.rows,employees:employees.rows,teams:teams.rows}})
//     }
//   })
// }
//# sourceMappingURL=get_data_from_db.js.map