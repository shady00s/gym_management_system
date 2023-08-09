
import { Request,Response, json } from "express";
import express from "express";

import { jsonModifier, saveXlsxFileData, } from "../excel_management/data_from_excel_handeling_logic";
import getExcelSheets from "../excel_management/get_excel_sheets";
import getExcelDataFromFile from "../excel_management/get_excel_data_from_file";
const excelRouter = express.Router();

excelRouter.post("/get_excel_file",getExcelDataFromFile)

excelRouter.get("/get_excel_sheets",getExcelSheets)

excelRouter.get("/get_data_form_excel",saveXlsxFileData)

excelRouter.get("/modified_data",jsonModifier)

export default excelRouter