# Go Hello World API Template (Cloud Run)

This Go application template provides a starting point for a "Hello World" API, suitable for deployment on Google Cloud Run. It features a clean project structure, a robust automation menu, structured logging, and a containerized setup.

This project uses `your-module-name` as its initial Go module path. **You must change this to your own desired module path.**

## 1. Quick Start & Setup

1.  **Initialize Your Go Module:**
    *   Decide on your Go module path (e.g., `github.com/your-username/my-cool-api`).
    *   In the `go.mod` file, change `module your-module-name` to your chosen path.
    *   Using your IDE's search and replace, replace all occurrences of `your-module-name` in `.go` files with your chosen module path.
    *   Run `go mod tidy` to update dependencies.

2.  **Configure Your Environment:**
    *   Copy `.env.example` to `.env`.
    *   Update `.env` with your settings, especially `GOOGLE_CLOUD_PROJECT`.

## 2. The Automation Factory

This project is managed by a simple and powerful automation menu. It is the primary way to build, test, and run this application.

**To see all available commands, run:**
```bash
task
```
This will display a menu of all development and operational tasks like `build`, `test`, `run`, `deploy`, and `clean`.

### Key Development Tasks
*   **Run all tests:** `task test`
*   **Run the API locally:** `task run`
*   **Build the binary:** `task build`
*   **Build the Docker image:** `task build -- docker` (or similar, depending on task implementation)

## 3. Features & API Payloads

*   **HTTP Endpoints:**
    *   `GET /hello`: Returns a "Hello, World!" message.
    *   `POST /echo`: Echoes back a JSON message.
    *   `GET /healthz`: A simple health check endpoint.
*   **Structured Logging:** GCP-compatible JSON logs using `log/slog`.
*   **Configuration:** Loads settings from environment variables.
*   **Containerized:** Includes a multi-stage `Dockerfile` for a minimal, secure image.

### `POST /echo` Payload
*   **Request Body:**
    ```json
    {
      "text_to_echo": "Your message here"
    }
    ```
*   **Response (200 OK):**
    ```json
    {
      "received_text": "Your message here",
      "reply": "Service 'go-hello-world-api' received your message: 'Your message here'",
      "timestamp": "..."
    }
    ```

## 4. Deployment to Cloud Run

The recommended way to deploy this service is by using the automation menu:
```bash
task deploy
```
This task is a placeholder that you can implement with your specific deployment logic (e.g., using the `gcloud run deploy` commands found in the original `README`).

## 5. Prerequisites

*   **Go:** Version 1.24 or higher.
*   **Docker:** Required for building and running the container.
*   **Task:** The Go-Task runner is included in the Nix environment.
*   **GCP Project:** Required for deployment and full logging features.

## Error Handling

*   **HTTP Method Not Allowed (405):** Returned if an incorrect HTTP method is used for an endpoint (e.g., POST to `/hello`).
*   **Bad Request (400):**
    *   Malformed JSON payload for `/echo`.
    *   Missing or empty `text_to_echo` field in `/echo` request.
*   **Not Found (404):** For undefined paths.