import express from "express";
import { config } from "../config";
import { getRoutes } from "./routes";

export function runApi(): void {
	const app = express();

	app.use(getRoutes());
	app.listen(config.PORT);
	console.log(`Using port ${config.PORT}`);
}
