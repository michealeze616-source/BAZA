# BAZA
**Everything you need. All in one place.**

BAZA is a Nigeria-first general marketplace for discovering products, services, shops, and local deals.

## Live preview
- Vercel preview: https://baza-marketplace-h0uxps6qc-holydon.vercel.app
- GitHub: https://github.com/michealeze616-source/BAZA

## Current features
- Responsive marketplace landing page and category search
- Real user listings loaded from Supabase (no demo inventory)
- Buyer, seller, or buyer-and-seller signup roles
- Editable account profiles
- Listing creation with photo upload
- Seller dashboard to edit and delete their own listings
- Supabase Auth, Postgres and Storage policies (requires project setup)

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
2. In Supabase SQL Editor, run `supabase/migrations/001_initial_schema.sql`.\n3. Then run `supabase/migrations/002_profiles_roles_and_listing_storage.sql` to enable Buyer/Seller profiles and secure listing-photo uploads.
3. Add the following Vite variables in local `.env.local` and Vercel Project Settings → Environment Variables:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
5. Redeploy after setting the variables.

Only use the Supabase anon/publishable key in this frontend. Never place service-role keys or other secrets in client environment variables.

## Roadmap
- Real product/listing CRUD and image uploads
- Persistent favorites
- Seller storefronts and profile pages
- Buyer-seller messaging
- Orders, moderation/reporting, and admin tools
- Payment provider integration and delivery workflow (after core marketplace is tested)
