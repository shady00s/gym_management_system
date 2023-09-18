"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const xlsx = __importStar(require("xlsx"));
async function getExcelSheets(req, res) {
    const fileName = req.query.fileName;
    const filePath = path_1.default.join(__dirname, '/target_excel/', fileName.toString());
    if (filePath.length !== 0) {
        fs_1.default.readFile(filePath, function (err, file) {
            if (err) {
                res.json(err);
            }
            const sheetNames = xlsx.readFile(filePath).SheetNames;
            const sheetNamesList = [];
            for (let index = 0; index < sheetNames.length; index++) {
                if (sheetNames[index] !== "Sheet1") {
                    sheetNamesList.push({ id: index, name: sheetNames[index] });
                }
            }
            res.json(sheetNamesList);
        });
    }
    else {
        res.json("no path found");
    }
}
exports.default = getExcelSheets;
//# sourceMappingURL=get_excel_sheets.js.map