
import { Request,Response, json } from "express";
import express from "express";
import formidable from "formidable";
import fs from "fs";
import path from "path";
import { jsonModifier, saveXlsxFileData, } from "../excel_management/logic";
const excelRouter = express.Router();

excelRouter.post("/excel_file",(req:Request,res:Response)=>{

  let form =  formidable({});
  
  form.parse(req,function(err,feilds,file){
    if(err){
        res.json({message:"there is an error please try again"})
    }
    const fileName:string = file.file[0].originalFilename
    const type:string = file.file[0].mimetype
    const newPath = path.join(__dirname,"../../excel_management/target_excel/",fileName)
   console.log(file.file[0]);

   fs.rename(file.file[0].filepath,newPath,(err)=>{
    if(err){console.log( );

        console.log(err);
    }
    console.log("done");
   })
    //file.PersistentFile[0].originalFilename;
    //console.log( file.file[0]);

  })
})

excelRouter.get("/convert_to_json",saveXlsxFileData)

excelRouter.get("/modified_data",jsonModifier)

export default excelRouter