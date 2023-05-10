require("dotenv").config();
const express = require("express");
const cors = require("cors");
const morganBody = require("morgan-body");
const { loggerStream } = require("./utils/handleLogger");
const { dbConnectMariaDB } = require("./config/mariadb");
const session = require("express-session");
const passport = require("passport");

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.static("storage"));

app.use(session({ secret: "cats" }));
app.use(passport.initialize());
app.use(passport.session());

morganBody(app, {
	noColors: true,
	stream: loggerStream,
	skip: function (req, res) {
		return res.statusCode < 400;
	},
});

app.use("/api", require("./routes"));

// Ruta donde estará el botón para iniciar sesión de Google:
app.get("/api", (req, res) => {
	res.send("<a href='/api/auth/google'>Authenticate with Google</a>");
});

app.listen(port, () => {
	console.log(`The app is ready and running on http://localhost:${port}`);
});

if (process.env.ENGINE_DB === "mariadb") dbConnectMariaDB();
