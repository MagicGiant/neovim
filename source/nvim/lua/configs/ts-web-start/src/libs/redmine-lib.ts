/*
	БИБЛИОТЕКА ДЛЯ РАБОТЫ С API Редмайна
	Крылов О.В.

	ПРИМЕРЫ ИСПОЛЬЗОВАНИЯ

	ИНИЦИАЛИЗАЦИЯ:

	const REDMINE = new Redmine(serverURL);
	REDMINE.apiKey = APIKEY;


	СОЗДАНИЕ ЗАДАЧИ:

		const newTask = {
			"issue": {
				"project_id": 59, // ОНТП
				"tracker_id": 2, // улучшение
				"priority_id": 2,
				"assigned_to_id": 255,
				"subject": "тестовая задача 2",
				"description": "Это будет описание новой задачи 2"
			}
		};
		REDMINE.newIssue(newTask)


	ЗАГРУЗКА ИНФОРМАЦИИ О ЗАДАЧЕ:

		const task168643 = REDMINE.getIssue(168643);


	ОБНОВЛЕНИЕ ЗАДАЧИ:

		const newNote = {
			"issue": {
				"notes": "Еще одна новая запись 2"
			}
		};
		REDMINE.updateIssue(168643, newNote);


	ЗАГРУЗКА ВЛОЖЕНИЯ:

		const answer = REDMINE.upload("D:\\21.xml")
		// answ = {"upload":{"token":"278922.2a0b584c750aeaa51798a58a8f551cbe"}}
		const update = {
			"issue": {
				"uploads": [
					{
						"token": answ.upload.token,
						"filename": "test.xml",
						"content_type": "text/xml"
					}
				]
			}
		}
		REDMINE.updateIssue(168643, update);

	СПРАВОЧНЫЕ ДАННЫЕ

	О ПОЛЬЗОВАТЕЛЯХ

		const answer = REDMINE.listUsers()
		выполняет фактически n запросов, где n*100 > все число пользователей

	О ПРОЕКТАХ

		const answer = REDMINE.listProjects()
		выполняет фактически n запросов, где n*100 > все число проектов
*/

import fs from "fs";
import { URL } from "url";

// const serverURL = "http://redmine.dmz/";
// const MAINAPIKEY = "9592e31bdb3a271c153215837161730797f803a6";

export default class Redmine {
	private _url: string;
	private _apiKey: string;
	private _isDebug: boolean;

	constructor(url: string, apiKey: string, isDebug: boolean) {
		this._url = url;
		this._apiKey = apiKey;
		this._isDebug = isDebug;
	}

	set url(url: string) {
		this._url = url;
	}

	get url() {
		return this._url;
	}

	set apiKey(key: string) {
		this._apiKey = key;
	}

	get apiKey() {
		return this._apiKey;
	}

	async newIssue(issueObj: Array<number>) {
		if (this._isDebug) {
			console.log(`Новая задача: ${JSON.stringify(issueObj, null, 2)}`);
			return null;
		}

		const headers = {
			"Content-Type": "application/json",
			"X-Redmine-API-Key": this.apiKey,
		};
		const params = {
			method: "POST",
			body: JSON.stringify(issueObj),
			headers,
		};

		if (!issueObj) throw Error("Redmine.newIssue(obj): не задан obj");

		const url = `${this._url}issues.json`;
		const response = await fetch(url, params);
		const result = await response.text();

		if (response.ok) return JSON.parse(result);

		throw new Error(
			`[Ошибка ${response.status}: ${response.statusText}]; message:'${result}'`,
		);
	}

	async getIssue(id: number) {
		const headers = {
			"Content-Type": "application/json",
			"X-Redmine-API-Key": this.apiKey,
		};
		const params = {
			method: "GET",
			headers,
		};

		if (!id) throw Error("Redmine.getIssue(id): не задан id");

		const url = new URL(`${this._url}issues/${id}.json`);
		url.searchParams.append("include", "attachments");
		url.searchParams.append("include", "journals");
		url.searchParams.append("include", "watchers");

		const response = await fetch(url, params);
		const result = await response.text();

		if (response.ok) return JSON.parse(result);

		throw new Error(
			`[Ошибка ${response.status}: ${response.statusText}]; message:'${result}'`,
		);
	}

	async updateIssue(id: number, issueObj: object) {
		if (this._isDebug) {
			console.log(`Обновлена задача: ${JSON.stringify(issueObj, null, 2)}`);
			return;
		}
		const headers = {
			"Content-Type": "application/json",
			"X-Redmine-API-Key": this.apiKey,
		};

		const params = {
			method: "PUT",
			body: JSON.stringify(issueObj),
			headers,
		};

		if (!id) throw Error("Redmine.getIssue(id): не задан id");

		const url = `${this._url}issues/${id}.json`;
		const response = await fetch(url, params);
		const result = await response.text();

		if (response.ok) return response.statusText;

		throw new Error(
			`[Ошибка ${response.status}: ${response.statusText}]; message:'${result}'`,
		);
	}

	async upload(filePath: string) {
		if (this._isDebug) {
			console.log(`Загружен файл ${filePath}`);
			return;
		}

		if (!filePath) throw Error("Redmine.upload(filePath): не задан filePath");

		const stats = fs.statSync(filePath);
		const fileSizeInBytes = stats.size;
		let readStream = fs.createReadStream(filePath);

		const headers = {
			"Content-Type": "application/octet-stream",
			"Content-length": fileSizeInBytes,
			"X-Redmine-API-Key": this.apiKey,
		};

		const params = {
			method: "POST",
			body: readStream,
			headers,
		};
		const url = `${this._url}uploads.json`;
		const response = await fetch(url, params);
		const result = await response.text();
		if (response.ok) return JSON.parse(result);

		throw new Error(
			`[Ошибка ${response.status}: ${response.statusText}]; message:'${result}'`,
		);
	}

	/**
	 * Получить список всех пользователнй redmine
	 * Требует админ ключ
	 */

	async listUsers() {
		const headers = {
			"Content-Type": "application/octet-stream",
			"X-Redmine-API-Key": this._apiKey,
		};

		const params = {
			method: "GET",
			headers,
		};
		let endResult = [],
			limit = 100,
			offset = 0;
		let finished = false;
		let total_count = 0;
		while (!finished) {
			let url = new URL(`${this._url}users.json`);
			url.searchParams.append("limit", limit.toString());
			url.searchParams.append("offset", offset.toString());

			let response = await fetch(url, params);
			let result = await response.text();

			if (response.ok) {
				let resultObj = JSON.parse(result);

				if (total_count == 0) total_count = resultObj.total_count;

				endResult = endResult.concat(resultObj.users);
				if (endResult.length >= total_count) finished = true;
				else offset += 100;
			} else
				throw new Error(
					`[Ошибка ${response.status}: ${response.statusText}]; message:'${result}'`,
				);
		}

		return endResult;
	}
	/**
	 * Получить список всех проектов redmine
	 * Требует админ ключ
	 */

	async listProjects() {
		const headers = {
			"Content-Type": "application/octet-stream",
			"X-Redmine-API-Key": this._apiKey,
		};

		const params = {
			method: "GET",
			headers,
		};

		let endResult = [],
			limit = 100,
			offset = 0;
		let finished = false;
		let total_count = 0;
		while (!finished) {
			let url = new URL(`${this._url}projects.json`);
			url.searchParams.append("limit", limit.toString());
			url.searchParams.append("offset", offset.toString());

			let response = await fetch(url, params);
			let result = await response.text();

			if (response.ok) {
				let resultObj = JSON.parse(result);

				if (total_count === 0) total_count = resultObj.total_count;

				endResult = endResult.concat(resultObj.projects);
				if (endResult.length >= total_count) finished = true;
				else offset += 100;
			} else
				throw new Error(
					`[Ошибка ${response.status}: ${response.statusText}]; message:'${result}'`,
				);
		}

		return endResult;
	}
	/**
	 * Получить список всех трекеров redmine
	 */
	async listTrackers() {
		const headers = {
			"Content-Type": "application/octet-stream",
			"X-Redmine-API-Key": this._apiKey,
		};
		const params = {
			method: "GET",
			headers,
		};

		let url = new URL(`${this._url}trackers.json`);
		let response = await fetch(url, params);
		let result = await response.text();

		if (response.ok) return JSON.parse(result);
		else
			throw new Error(
				`[Ошибка ${response.status}: ${response.statusText}]; message:'${result}'`,
			);
	}
}
