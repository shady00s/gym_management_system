import { pool } from "./send_data_to_db_controller";

export default async function createEmployeesTable(){
   await pool.query(`
            CREATE TABLE IF NOT EXISTS Employees(
                id INT PRIMARY KEY AUTOINCREMENT,
                employee_name TEXT NOT NULL,
                employee_phone_number TEXT NOT NULL,
                employee_position TEXT,
                employee_salary DOUBLE NOT NULL,
                employee_address TEXT NOT NULL,
            );
        `)
}