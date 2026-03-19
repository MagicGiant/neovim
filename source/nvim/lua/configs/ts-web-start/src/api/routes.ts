import express from "express";
import { config } from "../config";

export function getRoutes() {
	const router = express.Router();

	router.get("/", (req, res) => {
		res.send("Hello World");
	});

	router.get("/checkhealth", (req, res) => {
		res.setHeader("content-type", "text/plain");
		res.send(
			JSON.stringify({
				version: config.VERSION,
				status: "ok",
			}),
		);
		return;
	});

	return router;
}
