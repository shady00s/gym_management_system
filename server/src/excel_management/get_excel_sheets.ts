import { Request, Response} from 'express';
 import fs from "fs";
import path from "path";
import * as xlsx from 'xlsx';
export default async function getExcelSheets(req:Request,res:Response){

    const fileName  = req.query.fileName
        const filePath = path.join(__dirname,'/target_excel/',fileName.toString())
        if (filePath.length !==0){
             fs.readFile(filePath,function(err,file){
                if(err){
                    res.json(err)
    
                }
    
              const sheetNames =  xlsx.readFile(filePath).SheetNames
              const sheetNamesList =[]
                    for (let index = 0; index < sheetNames.length; index++) {
                        if(sheetNames[index]!=="Sheet1"){
                            sheetNamesList.push({id:index,name:sheetNames[index]})
    
                        }
                    }
    
              res.json(sheetNamesList)
            })
        }
        else{
            res.json("no path found")
        }
   

}