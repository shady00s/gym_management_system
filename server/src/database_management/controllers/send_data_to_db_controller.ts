
import {Request,Response } from 'express';
import { Req } from '../../excel_management/logic';
import {Pool} from "pg";
const client = new Pool({
    host:"postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope",
    port:5432,
    database:"gym_database_8ope",
    user:"shady",
    password:"postgres://shady:gTxyDyzytUOEfRL080FX0epSmDnN0uXr@dpg-cir98s5ph6ev5rae7at0-a.oregon-postgres.render.com/gym_database_8ope"
})
export default async function sendDataToDBController(req:Req,res:Response){

    await client.connect().then(()=>{console.log("working");}).catch(err=>{console.log(err);})

   let results = req.session.result

                res.json({message:"redirect succssessfully",results})
}