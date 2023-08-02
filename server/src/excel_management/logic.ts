import { Request, Response } from "express";
import path from "path";
import * as xlsx from "xlsx"
import fs from "fs"
import IExcelDataModel from "./excel_data_model";

import session from 'express-session';
export interface Req extends Request{
    session:any
}
async function saveXlsxFileData(req: Req, res: Response) {
    const filepath = path.join(__dirname, "./target_excel/players_2023.xlsx")
    const fileData = xlsx.readFile(filepath)
    const fileJsonData = xlsx.utils.sheet_to_json(fileData.Sheets[fileData.SheetNames[0]])


    const playersMap:IExcelDataModel[] = []



    for (let x = 0; x < fileJsonData.length; x++) {
        // get begin date and end date
        let finishdateVal = new Date((fileJsonData[x]["__EMPTY_3"] - 25569) * 86400 * 1000)
        let year = finishdateVal.getFullYear();
        let month = finishdateVal.getMonth() + 1;
        let day = finishdateVal.getDate();
        let hours = finishdateVal.getHours();
        let minutes = finishdateVal.getMinutes();
        let begdateVal = new Date((fileJsonData[x]["__EMPTY_2"] - 25569) * 86400 * 1000)
        let begyear = begdateVal.getFullYear();
        let begmonth = begdateVal.getMonth() + 1;
        let begday = begdateVal.getDate();
        let begHour = begdateVal.getHours();
        let begminuite = begdateVal.getMinutes();

        let id:string = fileJsonData[x]["GYM PLAYER 2023"]
        let name = fileJsonData[x]["__EMPTY"]
        let subscriptionValue = fileJsonData[x]["__EMPTY_6"] == null? -1 :fileJsonData[x]["__EMPTY_6"]
        let beginDate = `${begday + "/" + begmonth + "/" + begyear }`== "NaN/NaN/NaN" ? "1990-01-01 00:00:00": `${ begyear + "-" + begmonth + "-" + begday+" "+ begHour+":"+begminuite+":00"}`
        let finishDate = `${day + "/" + month + "/" + year }` == "NaN/NaN/NaN" ? "1990-01-01 00:00:00":`${ year  + "-" + month + "-" + day +" "+ hours+":"+minutes+":00"}` 
        
        let billId = fileJsonData[x]["__EMPTY_4"]== null? -1 : fileJsonData[x]["__EMPTY_4"]

        let subscriptionDuration:number = fileJsonData[x]["__EMPTY_1"] ==="شهر"? 1 : fileJsonData[x]["__EMPTY_1"] ==="شهرين"? 2 :  fileJsonData[x]["__EMPTY_1"] === "3شهور"? 3 :  fileJsonData[x]["__EMPTY_1"] === "6شهور" ? 6 : fileJsonData[x]["__EMPTY_1"] ==="حصة" ? 11 : -1 
                if( name !=="  "&& name !==" " && id !=="ID" && id !==null && name !== null ){
                    playersMap.push({ id: id, name, subscriptions: [{ subscriptionValue:subscriptionValue, beginDate:beginDate, finishDate:finishDate, billId:billId,subscriptionDuration:subscriptionDuration }] })

                }

        


    }
 
    let processedPlayer = new Set();
    const result = []
    let playerData = {};

    for (const player of playersMap) {
        const playerId = player.id;
        if(playerId !== undefined && playerId !=="" && playerId !== "  "){
            if (playerData[playerId]) {
                if (playerData[playerId].name === player.name && typeof player.name !=="number" ) {
                    
    
                        if(!player.subscriptions?.every(e=> playerData[playerId].subscriptions.every(
                            f=> e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue)))
                        {
                            playerData[playerId].subscriptions.push(...player.subscriptions);
        
                        
                    
                    
                }
                    if (!processedPlayer.has(playerId) && typeof playerId !== "string" ) {
                        
                        result.push(playerData[playerId]);
                        processedPlayer.add(playerId);
                      }
    
                }
            
        
    
                
            } else {
                playerData[playerId] = player;
                if(playerData[playerId].name == player.name && typeof player.name !=="number" && playerData[playerId].id !== null && player.id !==null){
                   
                    if(playerData[playerId].subscriptions.length !== 0 && playerData[playerId].subscriptions !==undefined){
    
                        if(!player.subscriptions?.every(e=> playerData[playerId].subscriptions.every(
                            f=> e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue)))
                        {
                            playerData[playerId].subscriptions.push(...player.subscriptions);
        
                        }
                    
                }
        
                        
                    
    
                    if (!processedPlayer.has(playerId) && typeof playerId !== "string" ) {
                        
                        result.push(playerData[playerId]);
                        processedPlayer.add(playerId);
                      }
                }
                
            }
        }
       
    }

   
    
    req.session.result = result;

   res.redirect('/send_json_to_db')
    //res.json(result)
}


    
//}

function jsonModifier(req: Request, res: Response) {
    fs.readFile(path.join(__dirname, "result.json"), function (err, data) {
        if (err) {
            res.json("file contains error")
        } else {
            const list = JSON.parse(data.toString())
          


            const result = [];
            const playerData = {};

            for (const player of list) {
                const playerId = player.id;

                if (playerData[playerId]) {
                    if (playerData[playerId].id === player.id && playerId) {
                        playerData[playerId].subscriptions.push(...player.subscriptions);
                        result.push(playerData[playerId]);
                    }
                } else {
                    playerData[playerId] = player;

                }
            }

            res.json(result)
        }
    })
}

export {
    saveXlsxFileData, jsonModifier
}