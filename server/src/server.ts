import express from "express";
import excelRouter from "./routes/excel_routes";
import database_router from "./database_management/routes";
import session from 'express-session';
import IExcelDataModel from "./excel_management/excel_data_model";
import IselectedTeams from "./excel_management/selected_team_model";

const app = express();
app.use(express.urlencoded({extended:true}));
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", '*');
  res.header("Access-Control-Allow-Credentials", "true");
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  next();
});
declare module "express-session" {
  interface SessionData {
    fileData:{
      fileName:string,
      filePath:string
    },
    selected_teams_list:IselectedTeams[]
    playerList:IExcelDataModel[]
  }
}
app.use(session({

    secret:"test",
    resave: false,
  saveUninitialized: true,
  cookie: {sameSite:"strict", maxAge: 60000, secure:false}
}))

app.use('/',excelRouter)
app.use('/',database_router)


app.listen(3000,()=>{
    console.log("connected");
})