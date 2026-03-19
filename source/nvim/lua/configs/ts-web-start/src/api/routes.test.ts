import { runApi } from ".";
import { getServiceUrl } from "../config";

runApi();

test("api checkhealth", async () => {
	const res = await fetch(`${getServiceUrl()}checkhealth`);
	const { status } = await res.json();

	expect(!!status).toBeTruthy();
});
