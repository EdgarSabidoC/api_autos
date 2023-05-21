const { check } = require("express-validator");
const validateResults = require("../utils/handleValidator");

/**
 * Validador de creación de elemento.
 * @param {Object} req - Objeto de solicitud.
 * @param {Object} res - Objeto de respuesta.
 * @param {Function} next - Función de siguiente middleware.
 * @returns {void}
 */
const createItemValidator = [
	check("name").exists().notEmpty().isString().isLength({ max: 75 }),
	check("year").optional().notEmpty().isInt(),
	check("factory_price")
		.optional()
		.notEmpty()
		.isDecimal({ decimal_digits: "1,4" }),
	check("transmission").exists().notEmpty().isInt(),
	check("color").exists().notEmpty().isInt(),
	check("category").exists().notEmpty().isInt(),
	check("maker").exists().notEmpty().isInt(),
	(req, res, next) => {
		return validateResults(req, res, next);
	},
];

/**
 * Validador de obtención de un elemento.
 * @param {Object} req - Objeto de solicitud.
 * @param {Object} res - Objeto de respuesta.
 * @param {Function} next - Función de siguiente middleware.
 * @returns {void}
 */
const getItemValidator = [
	check("carModelIdOrName").exists().notEmpty(),
	(req, res, next) => {
		return validateResults(req, res, next);
	},
];

module.exports = { createItemValidator, getItemValidator };
