
import { Request, Response } from 'express';
import { Req } from '../../excel_management/logic';
import { Client, Pool } from "pg";
import IExcelDataModel from '../../excel_management/excel_data_model';
const client = new Client({
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

const pool = new Pool({
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
          player_subscription_id INT,
          beginning_date VARCHAR,
          end_date VARCHAR, billId INT,
          billValue INT,
          duration INT,
          billCollector VARCHAR DEFAULT 'unkown'
                )`)
        await pool.query(`
        CREATE TABLE IF NOT EXISTS PLAYERS (
          player_id INT PRIMARY KEY,
          player_name VARCHAR,
          discount_code VARCHAR DEFAULT 'no-code' NOT NULL,
          player_age INT DEFAULT 0 NOT NULL,
          player_gender VARCHAR DEFAULT 'not-recorded' NOT NULL,
          subscription_id INT
        )
      `);
        for (let data of results) {
            if(data.id!==" "&& typeof data.id ==="number" ){
                await pool.query({text:'INSERT INTO PLAYERS (player_id, player_name,subscription_id) VALUES ($1, $2, $3)',values:[data.id,data.name,data.id]}).catch(err=>console.log(err))

                for (let subdata of data.subscriptions) {
                    await pool.query({
                        text: "INSERT INTO SUBSCRIPTIONSDB (player_subscription_id, beginning_date, end_date, billId, duration, billValue) VALUES ($1, $2, $3, $4, $5, $6)",
                        values: [data.id, subdata.beginDate, subdata.finishDate, subdata.billId, subdata.subscriptionDuration, subdata.subscriptionValue]
                    })
                }
            }
       

            //await pool.query({text:'INSERT INTO PLAYERS (player_id, player_name,subscription_id) VALUES ($1, $2, $3)',values:[data.id,data.name,data.id]}).catch(err=>console.log(err))
        }



    });


    pool.query("SELECT * FROM SUBSCRIPTIONSDB").then(val => { console.log(val.rows); })



    res.json({ message: "redirect succssessfully", results })
}