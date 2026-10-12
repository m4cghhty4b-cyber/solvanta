# SOLVANTA — Agent Instructions

## Quick Commands

**Backend (Go 1.27+):**
```bash
cd backend
./run-dev.cmd           # dev server on :8080 (loads .env)
./run-dev.cmd -Check    # validate .env without starting
go test ./... -count=1 -timeout 30m   # full test suite (see notes)
go vet ./...
```

**Flutter Client:**
```bash
flutter analyze
flutter test
flutter test integration_test/rbac_on_device_test.dart -d <device-id>
```

**Docker (full stack):**
```bash
docker compose up       # db + api on :8080
```

---

## Architecture Essentials

| Layer | Tech | Key Files |
|-------|------|-----------|
| Client | Flutter 3.x, Dart | `lib/main.dart` → `lib/app.dart` |
| Offline Store | `SharedPreferences` | `lib/core/storage/local_store.dart` (1263 lines, seeds all demo data) |
| Sync | Outbox queue | `lib/core/sync/sync_queue.dart`, `lib/core/api/api_client.dart` |
| Auth | HMAC bearer tokens | `backend/internal/security/security.go` |
| API | Go + Gin | `backend/cmd/server/main.go`, `backend/internal/httpapi/` |
| DB | PostgreSQL (pgx) | `backend/internal/store/postgres.go`, `backend/migrations/*.sql` |
| In-Memory Dev Store | Go map | `backend/internal/store/store.go` |

**Offline-first:** Mutating requests (non-GET, non-/auth) auto-queue to `SyncQueue` on network failure. Reads never queue. Token persists in `SharedPreferences` (`solvanta.api_token`) and republishes to `ApiClient.sharedToken` on cold start.

**RBAC Matrix:** Enforced client-side (`lib/features/home/dashboards.dart` → `modulesFor(role)`) and server-side (`backend/internal/httpapi/rbac_test.go`). Integration test `integration_test/rbac_on_device_test.dart` verifies exact module grid per role.

---

## Backend Gotchas

1. **Default store is in-memory** — data vanishes on restart. Set `POSTGRES_DSN` in `.env` for persistence.
2. **Dev SECRET auto-generated** — `run-dev.ps1` writes a random key to `.env` so tokens survive restarts. Production requires explicit `SECRET`.
3. **PostgreSQL integration tests SKIP unless `TEST_POSTGRES_DSN` is set** — they need a disposable database (truncates `public` each test). See `backend/README.md` lines 41–54.
4. **Test timeout:** Remote pooler ~150ms RTT → full suite takes minutes. Always use `-timeout 30m`.
5. **Not safe to run tests concurrently** — shared test database.
6. **Migrations apply at boot** — `migrations/*.sql` concatenated in filename order, all `IF NOT EXISTS`.
7. **Supabase:** Use **Session pooler** (port 5432), not Transaction pooler (6543). Host `aws-0-<region>.pooler.supabase.com`. `sslmode=require` mandatory.

---

## Flutter Gotchas

1. **No unit tests in `lib/`** — only integration test at `integration_test/rbac_on_device_test.dart`.
2. **Analysis config:** `analysis_options.yaml` uses `flutter_lints` and excludes all platform dirs.
3. **API base URL:** Defaults to `http://127.0.0.1:8080`. Override via `--dart-define=SOLVANTA_API=<url>` or `SOLVANTA_API_URL` env var.
4. **Demo logins** (seeded in both client and backend):
   | Role | Email | Password |
   |------|-------|----------|
   | Super Admin | super@solvanta.app | super123 |
   | School Admin | admin@solvanta.app | admin123 |
   | Headteacher | head@school.gh | head123 |
   | Teacher | efua.mensah@school.gh | teacher123 |
   | Parent | ama.owusu@school.gh | parent123 |
   | Student | kojo.owusu@school.gh | student123 |

---

## CI Pipeline (`.github/workflows/ci.yml`)

```yaml
backend:  go vet ./... → go build ./... → go test ./... (with TEST_POSTGRES_DSN)
client:   flutter pub get → flutter analyze → flutter test
```
Runs on push/PR to `main`.

---

## Key Files to Know

- `backend/README.md` — exhaustive run/test/deploy docs
- `lib/core/storage/local_store.dart` — entire offline seed + schema
- `lib/core/api/api_client.dart` — sync queue, token handling, offline queueing logic
- `lib/features/home/dashboards.dart` — RBAC module matrix (`modulesFor(role)`)
- `integration_test/rbac_on_device_test.dart` — on-device RBAC acceptance test
- `backend/internal/httpapi/rbac_test.go` — server-side RBAC matrix
- `docker-compose.yml` — local PostgreSQL + API stack