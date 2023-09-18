"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
// import sendDataToDBController from './controllers/send_data_to_db_controller';
// import getPlayerDataFromDB from "./controllers/get_data_from_db";
// import getPlayerInformationData from "./controllers/get_player_data";
// import sendDataOffline from "./controllers/send_data_offline";
const database_router = express_1.default.Router();
// database_router.get("/send_json_to_db",sendDataToDBController)
// database_router.get("/get_players_data_from_db",getPlayerDataFromDB)
// database_router.get("/get_one_player_data_from_db",getPlayerInformationData)
// database_router.get("/get_excel_data_offline",sendDataOffline)
exports.default = database_router;
//# sourceMappingURL=routes.js.map