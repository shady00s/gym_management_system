"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const formidable_1 = __importDefault(require("formidable"));
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const form = (0, formidable_1.default)({});
async function getExcelDataFromFile(req, res) {
    let form = (0, formidable_1.default)({});
    req.session.fileData = req.session.fileData || { fileName: "", filePath: "" };
    form.parse(req, function (err, feilds, file) {
        if (err) {
            res.json({ message: "there is an error please try again" });
        }
        const fileName = file.file[0].originalFilename;
        const newPath = path_1.default.join(__dirname, "/target_excel/", fileName);
        req.session.fileData.fileName = fileName;
        req.session.fileData.filePath = newPath;
        if (fs_1.default.existsSync(fileName)) {
            fs_1.default.unlink(newPath, function (err) {
                if (err) {
                    console.log(err);
                    res.json(err);
                }
                fs_1.default.copyFile(file.file[0].filepath, newPath, (err) => {
                    if (err) {
                        console.log(err);
                    }
                    res.status(302).redirect(`/get_excel_sheets?fileName=${fileName}`);
                });
            });
        }
        else {
            fs_1.default.copyFile(file.file[0].filepath, newPath, (err) => {
                if (err) {
                    console.log(err);
                }
                res.status(302).redirect(`/get_excel_sheets?fileName=${fileName}`);
            });
        }
    });
}
exports.default = getExcelDataFromFile;
//# sourceMappingURL=get_excel_data_from_file.js.map