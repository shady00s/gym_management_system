"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const data_from_excel_handeling_logic_1 = require("../excel_management/data_from_excel_handeling_logic");
const get_excel_sheets_1 = __importDefault(require("../excel_management/get_excel_sheets"));
const get_excel_data_from_file_1 = __importDefault(require("../excel_management/get_excel_data_from_file"));
const excelRouter = express_1.default.Router();
excelRouter.post("/get_excel_file", get_excel_data_from_file_1.default);
excelRouter.get("/get_excel_sheets", get_excel_sheets_1.default);
excelRouter.post("/get_data_form_excel", data_from_excel_handeling_logic_1.saveXlsxFileData);
exports.default = excelRouter;
//# sourceMappingURL=excel_routes.js.map