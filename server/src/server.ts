import express from "express";
import excelRouter from "./routes/excel_routes";

const app = express();
app.use(express.urlencoded({extended:true}));
app.use('/',excelRouter)

app.listen(3000,()=>{
    console.log("connected");
})