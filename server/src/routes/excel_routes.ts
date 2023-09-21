
import express from "express";

import { saveXlsxFileData, } from "../excel_management/data_from_excel_handeling_logic";
import getExcelSheets from "../excel_management/get_excel_sheets";
import getExcelDataFromFile from "../excel_management/get_excel_data_from_file";
import sendDataOffline from "../excel_management/send_data_offline";
const excelRouter = express.Router();

excelRouter.post("/get_excel_file",getExcelDataFromFile)

excelRouter.get("/get_excel_sheets",getExcelSheets)
excelRouter.get("/get_excel_data_offline",sendDataOffline)
excelRouter.post("/get_data_form_excel",saveXlsxFileData)



export default excelRouter