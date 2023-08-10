import express from "express";
import excelRouter from "./routes/excel_routes";
import database_router from "./database_management/routes";
import session from 'express-session';
import IExcelDataModel from "./excel_management/excel_data_model";

const app = express();
app.use(express.urlencoded({extended:true}));

declare module "express-session" {
  interface SessionData {
    fileData:{
      fileName:string,
      filePath:string
    },

    playerList:IExcelDataModel[]
  }
}
app.use(session({

    secret:"test",
    resave: true,
  saveUninitialized: true,
  cookie: {sameSite:"lax", maxAge: 60000, secure:false}
}))

app.use('/',excelRouter)
app.use('/',database_router)


app.listen(3000,()=>{
    console.log("connected");
})