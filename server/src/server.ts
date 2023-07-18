import express from "express";
import excelRouter from "./routes/excel_routes";
import database_router from "./database_management/routes";
import session from 'express-session';

const app = express();
app.use(express.urlencoded({extended:true}));

app.use(session({
    secret:"test",
    resave: false,
  saveUninitialized: true
}))

app.use('/',excelRouter)
app.use('/',database_router)


app.listen(3000,()=>{
    console.log("connected");
})