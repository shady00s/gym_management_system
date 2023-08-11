import { Response,Request } from "express";
import path from "path";
import * as xlsx from "xlsx"
import fs from "fs"
import IExcelDataModel from "./excel_data_model";
import formidable from "formidable";



async function saveXlsxFileData(req:Request, res: Response) {
    let form =  formidable({multiples:false});
    form.parse(req,function(err,fields){

        if(err){
            res.json(err)
        }
  if(fields.selectedSheet !== undefined){
    const selectedSheets = JSON.parse(fields.selectedSheet[0]);
    req.session.fileData = req.session.fileData || {fileName:"",filePath:""}; 
    const fileData = xlsx.readFile(req.session.fileData.filePath)
    const playersMap: IExcelDataModel[] = []
  let currentListLength = 0
   while (currentListLength < selectedSheets.length) {
       
        let  fileJsonData = xlsx.utils.sheet_to_json(fileData.Sheets[ selectedSheets[currentListLength].name])
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

            let id =
            fileJsonData[x]["GYM PLAYER 2023"] != undefined ?
            fileJsonData[x]["GYM PLAYER 2023"] : 
            fileJsonData[x]["swimmming players2023"] != undefined ?
            fileJsonData[x]["swimmming players2023"]:
            fileJsonData[x]["ك/بكرMMA"] != undefined ?
            fileJsonData[x]["ك/بكرMMA"] : fileJsonData[x]["ك/مهيمن ديكان  بوكس(عمولات)"] != undefined ?
            fileJsonData[x]["ك/مهيمن ديكان  بوكس(عمولات)"]: fileJsonData[x]["ك/اسراء -مدربه بنات بريفت-2023"] !== undefined ?
            fileJsonData[x]["ك/اسراء -مدربه بنات بريفت-2023"]:null;
            let playerId =
            fileJsonData[x]["GYM PLAYER 2023"] != undefined ?
            fileJsonData[x]["GYM PLAYER 2023"] +666: fileJsonData[x]["swimmming players2023"] != undefined ?
            fileJsonData[x]["swimmming players2023"] +111:
             fileJsonData[x]["ك/بكرMMA"] != undefined ?
            fileJsonData[x]["ك/بكرMMA"] +222: fileJsonData[x]["ك/مهيمن ديكان  بوكس(عمولات)"] != undefined ?
            fileJsonData[x]["ك/مهيمن ديكان  بوكس(عمولات)"] +333: fileJsonData[x]["ك/اسراء -مدربه بنات بريفت-2023"] !== undefined ?
            fileJsonData[x]["ك/اسراء -مدربه بنات بريفت-2023"] +444:null;
            let name = fileJsonData[x]["__EMPTY"]
            let team: string = fileJsonData[x]["GYM PLAYER 2023"] != undefined ? "gym" : fileJsonData[x]["swimmming players2023"] != undefined ? "swimming" : fileJsonData[x]["ك/بكرMMA"] != undefined ? 'ك/بكرMMA' : fileJsonData[x]["ك/مهيمن ديكان  بوكس(عمولات)"] != undefined ? "ك/مهيمن ديكان" : fileJsonData[x]["ك/اسراء -مدربه بنات بريفت-2023"] !== undefined ? "ك/اسراء" :fileJsonData[x]["ك/اسلام"]!== undefined?  "ك/اسلام":undefined;

            let subscriptionValue = fileJsonData[x]["__EMPTY_6"] == null ? -1 : fileJsonData[x]["__EMPTY_6"]
            let beginDate = `${begday + "/" + begmonth + "/" + begyear}` == "NaN/NaN/NaN" ? "1990-01-01 00:00:00" : `${begyear + "-" + begmonth + "-" + begday + " " + begHour + ":" + begminuite + ":00"}`
            let finishDate = `${day + "/" + month + "/" + year}` == "NaN/NaN/NaN" ? "1990-01-01 00:00:00" : `${year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":00"}`

            let billId = fileJsonData[x]["__EMPTY_4"] == null ? -1 : fileJsonData[x]["__EMPTY_4"]

            let subscriptionDuration: number = fileJsonData[x]["__EMPTY_1"] === "شهر" ? 1 : fileJsonData[x]["__EMPTY_1"] === "شهرين" ? 2 : fileJsonData[x]["__EMPTY_1"] === "3شهور" ? 3 : fileJsonData[x]["__EMPTY_1"] === "6شهور" ? 6 : fileJsonData[x]["__EMPTY_1"] === "حصة" ? 11 : -1
            if(id ==="*"){
                id = Math.round(Math.random() * (99000 - 88800))
             }
            if (name !== "  "
                && name !== " "
                && id !== "-"
                 && id !=="الا"
                && id !== "  "
                && id !== "لاغى"
                && id !== "ID"
                && id !== null
                && name !== null
                && name !== "ديسمبر"
                && name !== "نوفمبر"
                && name !== "اكتوبر"
                && name !== "سبتمبر"
                && name !== "اغسطس"
                && name !== "يوليو"
                && name !== "يونيه"
                && name !== "مايو"
                && name !== "ابريل"
                && name !== "مارس"
                && name !== "فبراير"
                && name !== "يناير"
            ) {
               
                playersMap.push({ playerId, id: id, team: team, name, subscriptions: [{ subscriptionValue: subscriptionValue, beginDate: beginDate, finishDate: finishDate, billId: billId, subscriptionDuration: subscriptionDuration }] })

            } 

        }
        currentListLength ++;

    }


    let processedPlayer = new Set();
    const result = []
    let playerData = {};
    let playerId;
    for (const player of playersMap) {
         playerId = player.playerId;
    
        if (player.id !== undefined) {
     

            if (playerData[playerId]) {
                if (playerData[playerId].name === player.name && playerData[playerId].team === player.team) {


                    if (!player.subscriptions?.every(e => playerData[playerId].subscriptions.every(
                        f => e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue))) {
                        playerData[playerId].subscriptions.push(...player.subscriptions);

                    }
                    if (!processedPlayer.has(playerId) && parseInt(playerId) !== undefined) {

                        result.push(playerData[playerId]);
                        processedPlayer.add(playerId);
                    }

                }


            } else {
                playerData[playerId] = player;
                if (playerData[playerId].name == player.name && playerData[playerId].team === player.team) {

                    if (playerData[playerId].subscriptions.length !== 0 && playerData[playerId].subscriptions !== undefined) {

                        if (!player.subscriptions?.every(e => playerData[playerId].subscriptions.every(
                            f => e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue))) {
                            playerData[playerId].subscriptions.push(...player.subscriptions);

                        }

                    }


                    if (!processedPlayer.has(playerId) && parseInt(playerId) !== undefined) {

                        result.push(playerData[playerId]);
                        processedPlayer.add(playerId);
                    }
                }

            }
        }

    }

    req.session.playerList = result;

    res.redirect('/send_json_to_db')
  }else{
       res.json("no sheets added") 
  }
       


    })
    

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