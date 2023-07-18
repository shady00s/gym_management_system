import { Request, Response } from "express";
import path from "path";
import * as xlsx from "xlsx"
import fs from "fs"




async function saveXlsxFileData(req: Request, res: Response) {
    const filepath = path.join(__dirname, "./target_excel/players_2023.xlsx")
    const fileData = xlsx.readFile(filepath)
    const fileJsonData = xlsx.utils.sheet_to_json(fileData.Sheets[fileData.SheetNames[0]])


    const playersMap = []



    for (let x = 0; x < fileJsonData.length; x++) {
        // get begin date and end date
        let finishdateVal = new Date((fileJsonData[x]["__EMPTY_3"] - 25569) * 86400 * 1000)
        let year = finishdateVal.getFullYear();
        let month = finishdateVal.getMonth() + 1;
        let day = finishdateVal.getDate();
        let begdateVal = new Date((fileJsonData[x]["__EMPTY_2"] - 25569) * 86400 * 1000)
        let begyear = begdateVal.getFullYear();
        let begmonth = begdateVal.getMonth() + 1;
        let begday = begdateVal.getDate();

        let id = fileJsonData[x]["GYM PLAYER 2023"]
        //  console.log(id != '*');
        let name = fileJsonData[x]["__EMPTY"]
        let subscriptionValue = fileJsonData[x]["__EMPTY_6"]
        let beginDate = `${begday + "/" + begmonth + "/" + begyear}`
        let finishDate = `${day + "/" + month + "/" + year}`
        let billId = fileJsonData[x]["__EMPTY_4"]

        let subscriptionDuration:number = fileJsonData[x]["__EMPTY_1"] ==="شهر"? 1 : fileJsonData[x]["__EMPTY_1"] ==="شهرين"? 2 :  fileJsonData[x]["__EMPTY_1"] === "3شهور"? 3 :  fileJsonData[x]["__EMPTY_1"] === "6شهور" ? 6 : fileJsonData[x]["__EMPTY_1"] ==="حصة" ? 0.1 : -1 
        if (id != '*' && id != '-' && id != undefined && typeof id !== "string") {

            playersMap.push({ id: id, name, subscriptions: [{ subscriptionValue:subscriptionValue, beginDate:beginDate, finishDate:finishDate, billId:billId,subscriptionDuration:subscriptionDuration }] })

        }


    }
    fs.writeFile(path.join(__dirname, "result.json"), JSON.stringify(playersMap), function (err) {
        if (err) {
            console.log(err);
        }
    })

    const result = [];
    const playerData = {};

    for (const player of playersMap) {
        const playerId = player.id;

        if (playerData[playerId]) {
            if (playerData[playerId].id === player.id) {
                playerData[playerId].subscriptions.push(...player.subscriptions);
                result.push(playerData[playerId]);
            }else{
                result.push(playerData[playerId]);

            }
        } else {
            playerData[playerId] = player;

        }
    }

    res.json(result)
}
   // res.json({ message: "successfully conveted to json" })



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
                    if (playerData[playerId].id === player.id) {
                        playerData[playerId].subscriptions.push(...player.subscriptions);
                        result.push(playerData[playerId]);
                    }else{
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