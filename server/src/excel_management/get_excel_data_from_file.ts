import { Response,Request } from "express";
import formidable from "formidable";
import fs from "fs";
import path from "path";
import { Req } from "./data_from_excel_handeling_logic";
const form = formidable({})
async function getExcelDataFromFile(req:Req,res:Response){

    let form =  formidable({});
    
    form.parse(req,function(err,feilds,file){
      if(err){
          res.json({message:"there is an error please try again"})
      }

      const fileName:string = file.file[0].originalFilename
      const newPath = path.join(__dirname,"/target_excel/",fileName)


       if(fs.existsSync(fileName)){
        fs.unlink(newPath,function(err){
          if(err){
            console.log(err);
            res.json(err)
          }
            res.redirect(`/get_excel_file`)})
        
       }else{
        fs.copyFile(file.file[0].filepath,newPath,(err)=>{
          if(err){
              console.log(err);
          }    
          console.log("done");
            res.redirect(`/get_excel_sheets?fileName=${fileName}`)
        })
       }

          
    })
  }

  export default getExcelDataFromFile