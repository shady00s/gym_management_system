import { Response,Request } from "express";
import formidable from "formidable";
import fs from "fs";
import path from "path";
const form = formidable({})
async function getExcelDataFromFile(req:Request,res:Response){

    let form =  formidable({});
    req.session.fileData = req.session.fileData || {fileName:"",filePath:""};

    form.parse(req,function(err,feilds,file){
      if(err){
          res.json({message:"there is an error please try again"})
      }
      const fileName:string = file.file[0].originalFilename
      const newPath = path.join(__dirname,"/target_excel/",fileName)
       
        req.session.fileData.fileName =  fileName;
        req.session.fileData.filePath = newPath;

       if(fs.existsSync(fileName)){
        fs.unlink(newPath,function(err){
          if(err){
            console.log(err);
            res.json(err)
          }

          
          fs.copyFile(file.file[0].filepath,newPath,(err)=>{
            if(err){
                console.log(err); 
            }    
              
            res.status(302).redirect(`/get_excel_sheets?fileName=${fileName}`)
          })        
        })
        
       }else{
       
        fs.copyFile(file.file[0].filepath,newPath,(err)=>{
          if(err){
              console.log(err); 
          }    
          res.status(302).redirect(`/get_excel_sheets?fileName=${fileName}`)
        })
       }

          
    })
  }

  export default getExcelDataFromFile