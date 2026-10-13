# FBC Wayfinder

Kiosk-based campus navigation system for Fellowship Baptist College, Kabankalan City.
A static web app (`index.html`) with one Vercel function (`api/config.js`) and a Supabase database.

## What's inside

| File | Purpose |
| --- | --- |
| `index.html` | The kiosk app: campus map, directory, routes, office status, light/dark mode |
| `api/config.js` | Gives the app the Supabase URL and public anon key from Vercel's environment variables |
| `supabase/schema.sql` | Creates the `wf_places` and `wf_search_logs` tables, their security rules, and the 43 places |

The app works without the database too: it falls back to its built-in data and shows "Offline data" in the top bar.

## Deploy (about 10 minutes)

1. **GitHub:** create a new repository named `fbc-wayfinder` under the account Vercel is linked to (`Quimanjan16`) and upload these files, keeping the `api` and `supabase` folders.
2. **Vercel:** Add New → Project → import `fbc-wayfinder` → Deploy. No build settings are needed.
3. **Supabase database:** in the new Vercel project, open Storage and either
   - connect the existing `supabase-fbc-paypoint` database (the `wf_` tables stay separate from PayPoint's), or
   - create a new Supabase database for the Wayfinder.
4. **Tables:** open that database's SQL editor (Vercel Storage → the database → Query, or Supabase → SQL Editor), paste the whole of `supabase/schema.sql`, and run it.
5. **Redeploy** the Vercel project so it picks up the Supabase environment variables. The top bar should now say "Live · Supabase".

## Editing places and office hours

Open the `wf_places` table in Supabase's Table Editor. You can rename places, change descriptions, and set
`weekday_open`, `weekday_close`, `saturday_open`, `saturday_close` per office. Changes appear on the kiosk at the next page load.
Every route shown is logged in `wf_search_logs` (place and time only, no personal data).
