const express = require("express");
const router = express.Router();
const {
	createItemValidator,
	getItemValidator,
} = require("../../validators/car_condition"); // Middlewares para validar.
const {
	getItems,
	getItem,
	createItem,
	updateItem,
	deleteItem,
} = require("../../controllers/car_condition"); // Controladores

// Middlewares:
const customHeader = require("../../middleware/customHeader"); // Middleware para requerir una API_KEY.
const { recordLog } = require("../../middleware/logRecord"); // Middleware para grabar en la bitácora.
const { authMiddleware } = require("../../middleware/session"); // Middleware de autenticación.
const { checkRole } = require("../../middleware/role"); // Middleware de verificación de rol.

/* Obtiene una lista de elementos */
router.get("/", recordLog, getItems);

/* Obtiene un elemento */
router.get("/:conditionIdOrType", recordLog, getItemValidator, getItem);

/* Crea un elemento en el registro */
router.post(
	"/",
	authMiddleware,
	checkRole(["admin", "capturist"]),
	recordLog,
	createItemValidator,
	createItem
);

/* Actualiza un elemento del registro */
router.put(
	"/:conditionIdOrType",
	authMiddleware,
	checkRole(["admin", "capturist"]),
	recordLog,
	getItemValidator,
	updateItem
);

/* Elimina un elemento del registro */
router.delete(
	"/:conditionIdOrType",
	authMiddleware,
	checkRole(["admin"]),
	recordLog,
	getItemValidator,
	deleteItem
);

module.exports = router;
