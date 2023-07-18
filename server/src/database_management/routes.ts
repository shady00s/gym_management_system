import express from "express"
import sendDataToDBController from './controllers/send_data_to_db_controller';

const database_router = express.Router()

database_router.get("/send_json_to_db",sendDataToDBController)

export default database_router