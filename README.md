# CS 262 Monopoly Web Service

This is the data service application for the
[CS 262 sample Monopoly project](https://github.com/calvin-cs262-organization/monopoly-project),
deployed on Azure here:

- **Running service URL (root):** [https://cs262-simon-webservices-gnbzh3bgbde4bjac.westus3-01.azurewebsites.net](https://cs262-simon-webservices-gnbzh3bgbde4bjac.westus3-01.azurewebsites.net)

---

## API Endpoints

Based on the root URL, the service implements the following endpoints:

- `/` — Returns a hello message
- `/players` — Retrieves the full list of players
- `/players/:id` — Retrieves a single player by ID (e.g., `/players/1`)
- `/players` (POST) — Creates a new player; expects a JSON body with `name` and `emailaddress`
- `/players/:id` (PUT) — Updates an existing player; expects a JSON body with `name` and `emailaddress`
- `/players/:id` (DELETE) — Deletes a player by ID

### Error Handling

- `/players/-1` — Invalid IDs return a **404 Not Found** error  
- `/blob` or any undefined endpoints — Return a **cannot GET** error

---

## Database

- Relational database hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/)
- Schema and sample data are in the `sql/` sub-directory
- Database credentials (server, user, password) are stored in **Azure App Service environment variables** for security; they are **not included in this repo**

---

## Deployment

- Based on [Azure App Service Node.js tutorial](https://learn.microsoft.com/en-us/azure/app-service/quickstart-nodejs?tabs=linux&pivots=development-environment-cli)
- This repo is set up to **auto-deploy** to Azure from the `main` branch via GitHub Actions workflow  
- To configure your own service, go to **Deployment Center** on Azure and link your GitHub repo

---

## Notes

- This sample service is maintained in a separate repo to simplify Azure integration and CI/CD
- All endpoints are live on the Azure-hosted service URL provided above
- Make sure your Azure environment variables (`DB_SERVER`, `DB_USER`, `DB_PASSWORD`, `DB_DATABASE`, `DB_PORT`) are set correctly to allow database connection
