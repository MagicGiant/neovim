import dotenv from "dotenv";
import { version } from "../package.json";

dotenv.config();

export const config = Object.freeze({
	PORT: process.env.PORT || 3000,
	VERSION: version || "unknown",

	TESTS: {
		HOST: process.env.HOST || "http://localhost",
	},
});

export function getServiceUrl() {
	return `${config.TESTS.HOST}:${config.PORT}/`;
}
