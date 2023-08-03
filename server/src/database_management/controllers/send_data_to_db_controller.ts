
import { Request, Response } from 'express';
import { Req } from '../../excel_management/logic';
import { Client, Pool } from "pg";
import IExcelDataModel from '../../excel_management/excel_data_model';
import format from 'pg-format';
export const client = new Client({
    host: "dpg-cir98s5ph6ev5rae7at0-a",
    ssl: {
        rejectUnauthorized: true
    },
    connectionString: "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope",
    port: 5432,
    database: "gym_database_8ope",
    user: "shady",
    password: "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope"
})

export const pool = new Pool({
    database: "gym_database_8ope",
    password: "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope"
    , ssl: {
        rejectUnauthorized: true
    },
    connectionString: "postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope",

})
export default async function sendDataToDBController(req: Req, res: Response) {
    let results: IExcelDataModel[] = req.session.result
    await client.connect().then(async () => {
        await pool.query("DROP TABLE IF EXISTS SUBSCRIPTIONSDB CASCADE")
        await pool.query("DROP TABLE IF EXISTS PLAYERS CASCADE")
        await pool.query(`
        CREATE TABLE IF NOT EXISTS SUBSCRIPTIONSDB (
          id SERIAL PRIMARY KEY,
          player_subscription_id INT,
          beginning_date TIMESTAMP DEFAULT '2018-01-01 00:00:00' NOT NULL,
          end_date TIMESTAMP DEFAULT '2018-01-01 00:00:00' NOT NULL, 
          billId INT DEFAULT -1 NOT NULL,
          billValue INT DEFAULT -1 NOT NULL,
          duration INT DEFAULT -11 NOT NULL,
          billCollector VARCHAR DEFAULT 'unkown' NOT NULL
                )`)
        await pool.query(`
        CREATE TABLE IF NOT EXISTS PLAYERS (
          player_id INT PRIMARY KEY,
          player_name VARCHAR,
          player_phone_number INT DEFAULT -3,
          image_path VARCHAR DEFAULT 'no-image',
          player_age INT DEFAULT 0 NOT NULL,
          player_first_join_date TIMESTAMP NOT NULL DEFAULT '2018-02-02 00:00:00',
          player_gender VARCHAR DEFAULT 'not-recorded' NOT NULL,
          subscription_id INT NOT NULL
        )
      `);

    let subMap = []
    // sort subscription dates to get first subscription to be added later to player_first join date
    for (let subData of results) {
        
    subData.subscriptions.sort((a,b) =>
             new Date(a.beginDate).getTime() - new Date(b.beginDate).getTime());

        
    } 
    


     let players_map = results.map(e=>[e.id, e.name,e.id, e.subscriptions[0].beginDate])
      for (const data of results) {
                for (const subData of data.subscriptions) {
                            if(typeof subData.subscriptionValue !== "number" ){
                                subData.subscriptionValue = -1
                            } if (subData.billId === null){
                                subData.billId = -1
                            }else{
                                subMap.push([data.id, subData.beginDate, subData.finishDate, subData.billId, subData.subscriptionValue, subData.subscriptionDuration])

                            }

                }
      }

     
      

       pool.query(format('INSERT INTO PLAYERS (player_id, player_name, subscription_id, player_first_join_date) VALUES %L',players_map),[],(err,result)=>{
        if (err){
            console.log(err);
        }else{
            console.log(result.rowCount);

        } 
     })

     pool.query(format('INSERT INTO SUBSCRIPTIONSDB (player_subscription_id, beginning_date, end_date, billId, billValue, duration) VALUES %L',subMap),[],(err,result)=>{
        if (err){
            console.log(err.stack);
            console.log(err.message);
        }else{
            console.log(result.rowCount);

        } 
     })
     


        res.json({ message: "redirect succssessfully", results   })

    });


  //  pool.query("SELECT * FROM SUBSCRIPTIONSDB").then(val => { console.log(val.rows); })

}

