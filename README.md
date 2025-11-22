# CS 262 Monopoly Web Service

This is the data service application for the
[CS 262 sample Monopoly project](https://github.com/calvin-cs262-organization/monopoly-project),
deployed on Azure here:

- **Running service URL (root):** [https://cs262-simon-webservices-gnbzh3bgbde4bjac.westus3-01.azurewebsites.net](https://cs262-simon-webservices-gnbzh3bgbde4bjac.westus3-01.azurewebsites.net)

---

## API Endpoints

Based on the root URL, the service implements the following endpoints:

### Player Endpoints

- `/` — Returns a hello message  
- `/players` — Retrieves the full list of players  
- `/players/:id` — Retrieves a single player by ID (e.g., `/players/1`)  
- `/players` (POST) — Creates a new player; expects a JSON body with `name` and `emailaddress`  
- `/players/:id` (PUT) — Updates an existing player; expects a JSON body with `name` and `emailaddress`  
- `/players/:id` (DELETE) — Deletes a player by ID  

### Game Endpoints (Homework 3)

- `/games` — Retrieves the full list of games (e.g., `[{"id":1,"time":"2006-06-27T08:00:00.000Z"}]`)  
- `/games/:id` — Retrieves the specified game plus the players and scores for that game  
- `/games` (POST) — Creates a new game; if `time` is omitted the current timestamp is used  
- `/games/:id` (PUT) — Updates the timestamp for an existing game  
- `/games/:id` (DELETE) — Deletes the specified game and all associated PlayerGame records  

### Error Handling

- Invalid player or game IDs (e.g., `/players/-1` or `/games/-1`) return a **404 Not Found** error  
- Any undefined endpoints (e.g., `/blob`) return a **cannot GET** error  

---

## Database

- Relational database hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/)  
- Schema and sample data are in the `sql/` sub-directory (`monopoly.sql`)  
- Database credentials are stored in **Azure App Service environment variables** (`DB_SERVER`, `DB_USER`, `DB_PASSWORD`, `DB_DATABASE`, `DB_PORT`)  
- The service connects to the database using these environment variables; they are **not included in this repo** for security  

---

## Deployment

- Based on [Azure App Service Node.js tutorial](https://learn.microsoft.com/en-us/azure/app-service/quickstart-nodejs?tabs=linux&pivots=development-environment-cli)  
- This repo is set up to **auto-deploy** to Azure from the `main` branch via GitHub Actions workflow  
- To configure your own service, go to **Deployment Center** on Azure and link your GitHub repo  
- After any code changes, push to `main` to trigger CI/CD and redeploy  

---

## Notes

- This service is maintained in a separate repo to simplify Azure integration and CI/CD  
- Supports both Player and Game data with proper foreign key handling  
- All endpoints are live on the Azure-hosted service URL provided above  
- Make sure your Azure environment variables are correct to allow database connection  
