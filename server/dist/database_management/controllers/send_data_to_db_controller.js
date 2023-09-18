"use strict";
// import { Request, Response } from 'express';
// import { Client, Pool } from "pg";
// import IExcelDataModel from '../../excel_management/excel_data_model';
// import format from 'pg-format';
// import createEmployeesTable from './create_employees_table';
// import { createPlayerTeamTable, createTeamsTable } from './create_teams_table';
// export const client = new Client({
//     host: "dpg-cir98s5ph6ev5rae7at0-a",
//     ssl: {
//         rejectUnauthorized: true
//     },
//     connectionString: "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope",
//     port: 5432,
//     database: "gym_database_8ope",
//     user: "shady",
//     password: "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope"
// })
Object.defineProperty(exports, "__esModule", { value: true });
// export const pool = new Pool({
//     database: "gym_database_8ope",
//     password: "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope"
//     , ssl: {
//         rejectUnauthorized: true
//     },
//     connectionString: "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope",
// })
// export default async function sendDataToDBController(req: Request, res: Response) {
//     let results: IExcelDataModel[] = req.session.playerList
//     await client.connect().then(async () => {
//         await pool.query("DROP TABLE IF EXISTS Employees CASCADE")
//         await pool.query("DROP TABLE IF EXISTS SUBSCRIPTIONSDB CASCADE")
//         await pool.query("DROP TABLE IF EXISTS PLAYERS CASCADE")
//         await pool.query("DROP TABLE IF EXISTS PlayersTeams CASCADE")
//         await pool.query("DROP TABLE IF EXISTS Teams CASCADE")
//         await createEmployeesTable();
//         await createTeamsTable();
//         await pool.query(`
//         CREATE TABLE IF NOT EXISTS SUBSCRIPTIONSDB (
//           id SERIAL PRIMARY KEY,
//           player_subscription_id INT,
//           beginning_date TIMESTAMP DEFAULT '2018-01-01 00:00:00' NOT NULL,
//           end_date TIMESTAMP DEFAULT '2018-01-01 00:00:00' NOT NULL, 
//           billId INT DEFAULT -1 NOT NULL,
//           billValue INT DEFAULT -1 NOT NULL,
//           duration INT DEFAULT -11 NOT NULL,
//           billCollector VARCHAR DEFAULT 'unkown' NOT NULL
//                 )`)
//         await pool.query(`
//         CREATE TABLE IF NOT EXISTS PLAYERS (
//           player_index_id INT NOT NULL PRIMARY KEY,
//           player_id INT NOT NULL,
//           player_name VARCHAR NOT NULL,
//           player_phone_number INT DEFAULT -3,
//           image_path VARCHAR DEFAULT 'no-image',
//           player_age INT DEFAULT 0 NOT NULL,
//           player_first_join_date TIMESTAMP NOT NULL DEFAULT '2018-02-02 00:00:00',
//           player_gender VARCHAR DEFAULT 'not-recorded' NOT NULL,
//           subscription_id INT NOT NULL
//         )
//       `);
//       await createPlayerTeamTable()
//     //set players data 
//      let players_map = results.map(e=>[e.id,e.playerIndexId, e.name, e.playerIndexId, e.subscriptions[0].beginDate])
//        pool.query(format('INSERT INTO PLAYERS (player_id,player_index_id, player_name, subscription_id, player_first_join_date) VALUES %L',players_map),[],(err,result)=>{
//         if (err){
//             console.log(err);
//         }else{
//             console.log(result.rowCount);
//         } 
//      })
//      let subMap = []
//      //insert subscription data to subMap
//      for (const data of results) {
//          for (const subData of data.subscriptions) {
//                      if(typeof subData.subscriptionValue !== "number" ){
//                          subData.subscriptionValue = -1
//                      } if (subData.billId === null){
//                          subData.billId = -1
//                      }else{
//                          subMap.push([data.playerIndexId, subData.beginDate, subData.finishDate, subData.billId, subData.subscriptionValue, subData.subscriptionDuration])
//                      }
//          }
//  }
//      pool.query(format('INSERT INTO SUBSCRIPTIONSDB (player_subscription_id, beginning_date, end_date, billId, billValue, duration) VALUES %L',subMap),[],(err,result)=>{
//         if (err){
//             console.log(err.stack);
//             console.log(err.message);
//         }else{
//             console.log(result.rowCount);
//         } 
//      })
//      let captains = [
//         {id:0,name:"ك/حمودة",phoneNumber:-1,specialization:"Bodybuilding captain", position:"onboard",salary:2.200,address:"cairo"},
//         {id:1,name:"ك/حسام",phoneNumber:-1,specialization:"Swimming Fitness captain", position:"Freelance",salary:-1.1,address:"cairo"},
//         {id:3,name:"ك/مهيمن",phoneNumber:-1,specialization:"Box captain", position:"Freelance",salary:1.100,address:"cairo"},
//         {id:2,name:"ك/اسراء",phoneNumber:-1,specialization:"Girs Fitness captain", position:"Freelance",salary:-1.1,address:"cairo"},
//         {id:4,name:"ك/بكر",phoneNumber:-1,specialization:"KickBoxing captain", position:"Freelance",salary:2.100,address:"cairo"},
//     ]
//     let captains_map = captains.map((e)=>[e.id,e.name,e.phoneNumber,e.specialization,e.position,e.salary,e.address])
// // insert employees
//          pool.query(format('INSERT INTO Employees (employee_id, employee_name, employee_phone_number, employee_specialization, employee_position, employee_salary, employee_address) VALUES %L',captains_map),[],(err,result)=>{
//             if (err){
//                 console.log("Employees"+ err.stack);
//                 console.log(err.message);
//             }else{
//                 console.log("Employees"+ result.rowCount);
//                         // insert teams
//                         let teams_map = req.session.selected_teams_list.map(e=>[e.id,e.name,e.id])
//                         console.log(teams_map);
//                         pool.query(format('INSERT INTO Teams (team_id, team_name, team_captain_id) VALUES %L',teams_map),[],(err,result)=>{
//                         if (err){
//                             console.log(err.stack);
//                             console.log("Teams"+ err.message);
//                         }else{
//                             console.log("Teams"+ result.rowCount);
//                             // insert players to playerTeam table
//                             let playersTeam_map = results.map((e)=>[e.playerIndexId,e.team])
//                             pool.query(format('INSERT INTO PlayersTeams (team_player_id, team_id) VALUES %L',playersTeam_map),[],(err,result)=>{
//                                 if (err){
//                                     console.log("PlayersTeams"+err.stack);
//                                     console.log(err.message);
//                                 }else{
//                                     console.log("PlayersTeams"+result.rowCount);
//                                 } 
//                             })
//                         } 
//                         })
//             } 
//          })
//         res.json({ message: "redirect succssessfully", results   })
//     }).catch(e=>res.json(e));
// }
//# sourceMappingURL=send_data_to_db_controller.js.map