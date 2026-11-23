# BAZA
**Everything you need. All in one place.**

BAZA is a Nigeria-first general marketplace for discovering products, services, shops, and local deals.

## Live preview
- Vercel preview: https://baza-marketplace-h0uxps6qc-holydon.vercel.app
- GitHub: https://github.com/michealeze616-source/BAZA

## Current features
- Responsive marketplace landing page and navigation
- Category browsing and client-side search
- Sample listing cards in Nigerian Naira
- Favorites (currently in browser session state)
- Signup and login UI wired to Supabase Auth when configured
- Supabase starter schema for profiles, listings, favorites, conversations, and messages with Row Level Security policies

## Tech stack
- React + TypeScript + Vite
- Supabase Auth + Postgres planned/partially wired
- Vercel deployment connected to GitHub main branch

## Run locally
```bash
npm install
npm run dev
```

## Supabase setup (needed for real accounts and saved data)
1. Create a Supabase project.
2. In Supabase SQL Editor, run `supabase/migrations/001_initial_schema.sql`.
3. Add the following Vite variables in local `.env.local` and Vercel Project Settings → Environment Variables:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
4. Redeploy after setting the variables.

Only use the Supabase anon/publishable key in this frontend. Never place service-role keys or other secrets in client environment variables.

## Roadmap
- Real product/listing CRUD and image uploads
- Persistent favorites
- Seller storefronts and profile pages
- Buyer-seller messaging
- Orders, moderation/reporting, and admin tools
- Payment provider integration and delivery workflow (after core marketplace is tested)
