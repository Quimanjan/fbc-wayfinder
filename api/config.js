// Returns the public Supabase URL and anon key that the Vercel–Supabase integration
// stores as environment variables. The anon key is safe to expose: row level security
// limits it to reading places and adding search-log rows.
module.exports = (req, res) => {
  res.setHeader("Cache-Control", "no-store");
  res.status(200).json({
    url: process.env.SUPABASE_URL || process.env.NEXT_PUBLIC_SUPABASE_URL || null,
    anonKey: process.env.SUPABASE_ANON_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || null,
  });
};
