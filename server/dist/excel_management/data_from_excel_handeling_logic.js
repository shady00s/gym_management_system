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
exports.saveXlsxFileData = void 0;
const xlsx = __importStar(require("xlsx"));
const formidable_1 = __importDefault(require("formidable"));
const generate_unique_id_1 = __importDefault(require("generate-unique-id"));
async function saveXlsxFileData(req, res) {
    let form = (0, formidable_1.default)({ multiples: false });
    form.parse(req, async function (err, fields) {
        if (err) {
            res.json(err);
        }
        if (fields.selectedSheet !== undefined) {
            const selectedSheets = JSON.parse(fields.selectedSheet[0]);
            req.session.selected_teams_list = selectedSheets;
            req.session.fileData = req.session.fileData || { fileName: "", filePath: "" };
            const playersMap = [];
            let currentListLength = 0;
            if (req.session.fileData.filePath !== "") {
                const fileData = xlsx.readFile(req.session.fileData.filePath);
                while (currentListLength < selectedSheets.length) {
                    let fileJsonData = xlsx.utils.sheet_to_json(fileData.Sheets[selectedSheets[currentListLength].name]);
                    for (let x = 0; x < fileJsonData.length; x++) {
                        let id = fileJsonData[x][selectedSheets[currentListLength].name];
                        let team;
                        if (id !== undefined && team === undefined) {
                            let index = selectedSheets.findIndex(e => (e.name === Object.keys(fileJsonData[x])[0])
                                || ((e.name === Object.keys(fileJsonData[x])[1])) ||
                                ((e.name === Object.keys(fileJsonData[x])[2])));
                            if (index !== -1) {
                                team = selectedSheets[index].id;
                            }
                        }
                        else if (id == undefined) {
                            team = -1;
                        }
                        else
                            team = team;
                        let playerId = Math.floor(fileJsonData[x][selectedSheets[currentListLength].name] + fileJsonData.length + selectedSheets[currentListLength].id);
                        let notOriginalId = id === "*";
                        if (id === "*") {
                            let num = fileJsonData.length + Math.round(Math.random() * (300 - 50));
                            playerId = (fileJsonData.length + selectedSheets[currentListLength].id) + num * selectedSheets[currentListLength].id;
                            id = num;
                        }
                        let playerIndexId = parseInt((0, generate_unique_id_1.default)({ useLetters: false, useNumbers: true, length: 8, includeSymbols: [] }));
                        // get begin date and end date
                        let finishdateVal = new Date((fileJsonData[x]["__EMPTY_3"] - 25569) * 86400 * 1000);
                        let year = finishdateVal.getFullYear();
                        let month = finishdateVal.getMonth() + 1;
                        let day = finishdateVal.getDate();
                        let hours = finishdateVal.getHours();
                        let minutes = finishdateVal.getMinutes();
                        let begdateVal = new Date((fileJsonData[x]["__EMPTY_2"] - 25569) * 86400 * 1000);
                        let begyear = begdateVal.getFullYear();
                        let begmonth = begdateVal.getMonth() + 1;
                        let begday = begdateVal.getDate();
                        let begHour = begdateVal.getHours();
                        let begminuite = begdateVal.getMinutes();
                        // subscription collecting date
                        let subscriptionCollectingDate = new Date((fileJsonData[x]['__EMPTY_5'] - 25569) * 86400 * 1000);
                        let subyear = subscriptionCollectingDate.getFullYear();
                        let submonth = subscriptionCollectingDate.getMonth() + 1;
                        let subday = subscriptionCollectingDate.getDate();
                        let subhours = subscriptionCollectingDate.getHours();
                        let subminutes = subscriptionCollectingDate.getMinutes();
                        let name = fileJsonData[x]["__EMPTY"] ? fileJsonData[x]["__EMPTY"].replace(/^\s+|\s+$/g, '') : fileJsonData[x]["__EMPTY"];
                        let subscriptionValue = fileJsonData[x]["__EMPTY_6"] == null ? -1 : fileJsonData[x]["__EMPTY_6"];
                        let subscriptionCollectionDate = `${subday + "/" + submonth + "/" + subyear}` == "NaN/NaN/NaN" ? "1990-01-01 00:00:00" : `${subyear + "-" + (submonth < 10 ? `0${submonth}` : submonth) + "-" + (subday < 10 ? `0${subday}` : subday) + " " + "0" + subhours + ":" + "0" + subminutes + ":00"}`;
                        let beginDate = `${begday + "/" + begmonth + "/" + begyear}` == "NaN/NaN/NaN" ? "1990-01-01 00:00:00" : `${begyear + "-" + (begmonth < 10 ? `0${begmonth}` : begmonth) + "-" + (begday < 10 ? `0${begday}` : begday) + " " + "0" + begHour + ":" + "0" + begminuite + ":00"}`;
                        let finishDate = `${day + "/" + month + "/" + year}` == "NaN/NaN/NaN" ? "1990-01-01 00:00:00" : `${year + "-" + (month < 10 ? `0${month}` : month) + "-" + (day < 10 ? `0${day}` : day) + " " + "0" + hours + ":" + "0" + minutes + ":00"}`;
                        let billId = fileJsonData[x]["__EMPTY_4"] == null || typeof fileJsonData[x]["__EMPTY_4"] === "string" ? -1 : fileJsonData[x]["__EMPTY_4"];
                        let subscriptionDuration = fileJsonData[x]["__EMPTY_1"] === "شهر" ? 1 : fileJsonData[x]["__EMPTY_1"] === "شهرين" ? 2 : fileJsonData[x]["__EMPTY_1"] === "3شهور" ? 3 : fileJsonData[x]["__EMPTY_1"] === "6شهور" ? 6 : fileJsonData[x]["__EMPTY_1"] === "سنة" ? 12 : fileJsonData[x]["__EMPTY_1"] === "حصة" ? 11 : -1;
                        const invalidNames = /^(?! *$|^ *$|^ديسمبر$|^نوفمبر$|^اكتوبر$|^سبتمبر$|^اغسطس$|^يوليو$|^يونيه$|^مايو$|^ابريل$|^مارس$|^فبراير$|^يناير$).*/;
                        const invalidIds = /^(?! *$|^ *$|^-$|^الا$|^لاغى$|^ID$).*$/;
                        if (invalidNames.test(name) && invalidIds.test(id) && typeof name !== "number" && typeof subscriptionValue !== "string" && typeof billId !== "string") {
                            playersMap.push({ notOriginalId: notOriginalId, playerIndexId, playerId, id: id, team, name, subscriptions: [{ subscriptionCollectionDate: subscriptionCollectionDate, playerSubscriptionId: playerIndexId, team: team, subscriptionValue: subscriptionValue, beginDate: beginDate, finishDate: finishDate, billId: billId, subscriptionDuration: subscriptionDuration }] });
                        }
                    }
                    currentListLength++;
                }
                let processedPlayer = new Set();
                let playerData = {};
                const results = [];
                for (const player of playersMap) {
                    let playerObjId = player.playerIndexId;
                    if (player.name !== undefined && player.id !== undefined && player.id !== null && player.name !== null) {
                        if (playerData[playerObjId]) {
                            if (playerData[playerObjId].name === player.name) {
                                playerData[playerObjId].playerIndexId = player.playerIndexId;
                                if (playerData[playerObjId].notOriginalId) {
                                    playerData[playerObjId].id = player.id;
                                }
                                if (!player.subscriptions?.every(e => playerData[playerObjId].subscriptions.every(f => e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue))) {
                                    playerData[playerObjId].subscriptions.push(...player.subscriptions);
                                }
                            }
                            if (!processedPlayer.has(playerObjId)) {
                                results.push(playerData[playerObjId]);
                                processedPlayer.add(playerObjId);
                            }
                        }
                        else {
                            playerData[playerObjId] = player;
                            if (playerData[playerObjId].name === player.name) {
                                playerData[playerObjId].playerIndexId = player.playerIndexId;
                                if (playerData[playerObjId].notOriginalId) {
                                    playerData[playerObjId].id = player.id;
                                }
                                if (playerData[playerObjId].subscriptions.length !== 0 && playerData[playerObjId].subscriptions) {
                                    if (!player.subscriptions?.every(e => playerData[playerObjId].subscriptions.every(f => e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue))) {
                                        playerData[playerObjId].subscriptions.push(...player.subscriptions);
                                    }
                                }
                            }
                            if (!processedPlayer.has(playerObjId)) {
                                results.push(playerData[playerObjId]);
                                processedPlayer.add(playerObjId);
                            }
                        }
                    }
                }
                playerData = {};
                processedPlayer.clear();
                req.session.playerList = results;
                req.session.selected_teams_list = selectedSheets;
                res.redirect('/get_excel_data_offline');
                //res.json(playersMap)
            }
            else {
                res.json("no sheets added");
            }
        }
        else {
            res.status(400).json("There is no file");
        }
    });
}
exports.saveXlsxFileData = saveXlsxFileData;
//# sourceMappingURL=data_from_excel_handeling_logic.js.map