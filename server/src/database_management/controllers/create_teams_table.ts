import { pool } from "./send_data_to_db_controller";

export  async function createTeamsTable(){

    await pool.query(`
            CREATE TABLE IF NOT EXISTS Teams(
                team_id INT PRIMARY KEY,
                team_name TEXT NOT NULL,
                team_captain_id INT NOT NULL,
                FOREIGN KEY (team_captain_id) REFERENCES Employees(employee_id)
            );
    `)
}

export  async function createPlayerTeamTable(){

    await pool.query(`
            CREATE TABLE IF NOT EXISTS PlayersTeams(
                id SERIAL PRIMARY KEY,
                team_id INT NOT NULL,
                team_player_id INT NOT NULL,
                FOREIGN KEY (team_id) REFERENCES Teams(team_id),
                FOREIGN KEY (team_player_id) REFERENCES PLAYERS(player_index_id)
            );
    `)
}