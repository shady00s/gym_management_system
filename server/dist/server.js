"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const excel_routes_1 = __importDefault(require("./routes/excel_routes"));
const routes_1 = __importDefault(require("./database_management/routes"));
const express_session_1 = __importDefault(require("express-session"));
const app = (0, express_1.default)();
app.use(express_1.default.urlencoded({ extended: true }));
app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", '*');
    res.header("Access-Control-Allow-Credentials", "true");
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
    next();
});
app.use((0, express_session_1.default)({
    secret: "test",
    resave: false,
    saveUninitialized: true,
    cookie: { sameSite: "strict", maxAge: 60000, secure: false }
}));
app.use('/', excel_routes_1.default);
app.use('/', routes_1.default);
app.listen(3000, () => {
    console.log("connected");
});
//# sourceMappingURL=server.js.map