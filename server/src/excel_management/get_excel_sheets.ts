import { Request, Response, json } from 'express';
 import fs from "fs";
import path from "path";
import { Req } from './data_from_excel_handeling_logic';
import * as xlsx from 'xlsx';
export default function getExcelSheets(req:Request,res:Response){
    const fileName  = req.query.fileName
        const filePath = path.join(__dirname,'/target_excel/',fileName.toString())
        fs.readFile(filePath,function(err,file){
            if(err){
                res.json(err)

            }

          const sheetNames =  xlsx.readFile(filePath).SheetNames
          const sheetNamesList =[]
                for (let index = 0; index < sheetNames.length; index++) {
                   
                        sheetNamesList.push({id:index,name:sheetNames[index]})
                }
          res.json(sheetNames)
        })

}