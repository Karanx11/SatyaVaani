require("dotenv").config();
const axios = require("axios");
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SECRET_KEY
);

const API_KEY = process.env.YOUTUBE_API_KEY;

// Trusted Channels with REGION mapping
const CHANNELS = [
  {
    id: "UC16niRr50-MSBwiO3YDb3RA", // BBC
    region: "global",
  },
  {
    id: "UCZFMm1mMw0F81Z37aaEzTUA", // NDTV
    region: "india",
  },
  {
    id: "UC9CYT9gSNLevX5ey2_6CK0Q", // Aaj Tak (Hindi) 🔥
    region: "india",
  },
  {
    id: "UC_gUM8rL-Lrg6O3adPW9K1g", // Zee News Hindi 🔥
    region: "india",
  },
];

// 🔥 Prevent duplicate videos
async function isDuplicate(videoUrl) {
  const { data, error } = await supabase
    .from("news")
    .select("id")
    .eq("video_url", videoUrl)
    .limit(1);

  if (error) {
    console.error("Supabase error:", error.message);
    return false;
  }

  return data && data.length > 0;
}

async function fetchVideos() {
  try {
    for (let channel of CHANNELS) {
      console.log(`Fetching from ${channel.id}...`);

      const res = await axios.get(
        `https://www.googleapis.com/youtube/v3/search`,
        {
          params: {
            key: API_KEY,
            channelId: channel.id,
            part: "snippet",
            order: "date",
            maxResults: 5,
          },
        }
      );

      const videos = res.data.items;

      for (let vid of videos) {
        if (!vid.id.videoId) continue;

        const videoUrl = `https://www.youtube.com/watch?v=${vid.id.videoId}`;

        // ❌ Skip duplicates
        const exists = await isDuplicate(videoUrl);
        if (exists) {
          console.log("Duplicate skipped");
          continue;
        }

        await supabase.from("news").insert({
          headline: vid.snippet.title,
          video_url: videoUrl,
          source: vid.snippet.channelTitle,
          caption: vid.snippet.description || "",
          is_verified: true,
          region: channel.region,
          category: "national",
        });

        console.log("Inserted:", vid.snippet.title);
      }
    }

    console.log("✅ Fetch complete");
  } catch (err) {
    console.error("❌ Error:", err.message);
  }
}

fetchVideos();