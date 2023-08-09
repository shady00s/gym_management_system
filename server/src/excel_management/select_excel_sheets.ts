import { Request, Response } from "express";


export default function selectExcelSheets(req:Request,res:Response){

   const selectedSheets = req.query.selectedSheets

   res.redirect(`/get_data_form_excel?selectedSheets=${selectedSheets}`)
}  