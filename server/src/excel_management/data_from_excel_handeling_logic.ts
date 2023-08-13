import { Response,Request } from "express";
import path from "path";
import * as xlsx from "xlsx"
import fs from "fs"
import IExcelDataModel from "./excel_data_model";
import formidable from "formidable";
import generateUniqueId from "generate-unique-id";
import IselectedTeams from "./selected_team_model";



async function saveXlsxFileData(req:Request, res: Response) {
    let form =  formidable({multiples:false});
    form.parse(req,function(err,fields){

        if(err){
            res.json(err)
        }

  if(fields.selectedSheet !== undefined){
    const selectedSheets:IselectedTeams[] = JSON.parse(fields.selectedSheet[0]);
    req.session.selected_teams_list = selectedSheets;
    req.session.fileData = req.session.fileData || {fileName:"",filePath:""}; 
    const fileData = xlsx.readFile(req.session.fileData.filePath)
    const playersMap: IExcelDataModel[] = []
  let currentListLength = 0
   while (currentListLength < selectedSheets.length) {
       
        let  fileJsonData = xlsx.utils.sheet_to_json(fileData.Sheets[ selectedSheets[currentListLength].name])
        for (let x = 0; x < fileJsonData.length; x++) {

            
            let playerIndexId =parseInt( generateUniqueId({useLetters:false,useNumbers:true,length:8,includeSymbols:[]}));
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
            fileJsonData[x]["ك/بكرMMA"] +888: fileJsonData[x]["ك/مهيمن ديكان  بوكس(عمولات)"] != undefined ?
            fileJsonData[x]["ك/مهيمن ديكان  بوكس(عمولات)"] +333: fileJsonData[x]["ك/اسراء -مدربه بنات بريفت-2023"] !== undefined ?
            fileJsonData[x]["ك/اسراء -مدربه بنات بريفت-2023"] +444:null;
            let name = fileJsonData[x]["__EMPTY"]

            let team:number = fileJsonData[x]["GYM PLAYER 2023"] != undefined ?  
                selectedSheets[selectedSheets.findIndex((e) => e.name === 'gym')].id :
                fileJsonData[x]['swimmming players2023'] != undefined ?
                    selectedSheets[selectedSheets.findIndex((e) => e.name === 'swim')].id :
                    fileJsonData[x]["ك/بكرMMA"] != undefined ?
                    selectedSheets[selectedSheets.findIndex((e) => e.name === "بكرMMA")].id :
                    fileJsonData[x]['ك/مهيمن ديكان  بوكس(عمولات)'] != undefined ?
                    selectedSheets[selectedSheets.findIndex((e) => e.name === 'مهيمنBOX')].id :
                    fileJsonData[x]['ك/اسراء -مدربه بنات بريفت-2023'] !== undefined ?
                    selectedSheets[selectedSheets.findIndex((e) => e.name === 'ك-اسراء')].id : -1;

            let subscriptionValue = fileJsonData[x]["__EMPTY_6"] == null ? -1 : fileJsonData[x]["__EMPTY_6"]
            let beginDate = `${begday + "/" + begmonth + "/" + begyear}` == "NaN/NaN/NaN" ? "1990-01-01 00:00:00" : `${begyear + "-" + begmonth + "-" + begday + " " + begHour + ":" + begminuite + ":00"}`
            let finishDate = `${day + "/" + month + "/" + year}` == "NaN/NaN/NaN" ? "1990-01-01 00:00:00" : `${year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":00"}`

            let billId = fileJsonData[x]["__EMPTY_4"] == null || typeof fileJsonData[x]["__EMPTY_4"] === "string" ? -1 : fileJsonData[x]["__EMPTY_4"]

            let subscriptionDuration: number = fileJsonData[x]["__EMPTY_1"] === "شهر" ? 1 : fileJsonData[x]["__EMPTY_1"] === "شهرين" ? 2 : fileJsonData[x]["__EMPTY_1"] === "3شهور" ? 3 : fileJsonData[x]["__EMPTY_1"] === "6شهور" ? 6 : fileJsonData[x]["__EMPTY_1"] === "حصة" ? 11 : -1
            if(id ==="*"){
                let num =  (Math.round(Math.random() *(3200  - 2200)))
                playerId = num
                id = num
            }
             const invalidNames = /^(?! *$|^ *$|^ديسمبر$|^نوفمبر$|^اكتوبر$|^سبتمبر$|^اغسطس$|^يوليو$|^يونيه$|^مايو$|^ابريل$|^مارس$|^فبراير$|^يناير$).*/;
            const invalidIds = /^(?! *$|^ *$|^-$|^الا$|^لاغى$|^ID$).*$/;
            if (
                invalidNames.test(name) && invalidIds.test(id)
            ) {
               
                playersMap.push({playerIndexId, playerId, id: id, team: team, name, subscriptions: [{ subscriptionValue: subscriptionValue, beginDate: beginDate, finishDate: finishDate, billId: billId, subscriptionDuration: subscriptionDuration }] })

            } 
           
        }
        currentListLength ++;

    }


    let processedPlayer = new Set();
    const result = []
    let playerData = {};
    let playerId;
    for (const player of playersMap) {
         playerId = player.name;
    
        if (player.id !== undefined && player.id !== null && player.name !==null ) {
     

            if (playerData[playerId]) {
                if (player.name!== undefined &&  playerData[playerId].name === player.name && playerData[playerId].team === player.team) {


                    if (!player.subscriptions?.every(e => playerData[playerId].subscriptions.every(
                        f => e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue))) {
                        playerData[playerId].subscriptions.push(...player.subscriptions);

                    }
                    if (!processedPlayer.has(playerId) ) {

                        result.push(playerData[playerId]);
                        processedPlayer.add(playerId);
                    }

                } 
                    

                 
                       
                    

                


            } else {
                playerData[playerId] = player;
                if (player.name !== undefined && playerData[playerId].name == player.name && playerData[playerId].team === player.team) {

                    if (playerData[playerId].subscriptions.length !== 0 && playerData[playerId].subscriptions !== undefined) {

                        if (!player.subscriptions?.every(e => playerData[playerId].subscriptions.every(
                            f => e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue))) {
                            playerData[playerId].subscriptions.push(...player.subscriptions);

                        }

                    }


                    if (!processedPlayer.has(playerId) ) {

                        result.push(playerData[playerId]);
                        processedPlayer.add(playerId);
                    }
                }
                   
                
                   

            }
        }


    }

    req.session.playerList = result;
    req.session.selected_teams_list =  selectedSheets;   

    res.redirect('/send_json_to_db')
  }else{
       res.json("no sheets added") 
  }
       


    })
    

}



//}



export {
    saveXlsxFileData,
}