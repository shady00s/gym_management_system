import { pool } from "./send_data_to_db_controller";

export default async function createTeamsTable(){

    await pool.query(`
            CREATE TABLE IF NOT EXISTS Teams(
                id INT PRIMARY KEY AUTOINCREMENT,
                team_name TEXT NOT NULL,
                team_captain_id INT NOT NULL,
            );
    `)
}