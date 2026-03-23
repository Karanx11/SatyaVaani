require("dotenv").config();
const cron = require("node-cron");
const fetchVideos = require("./youtubeFetcher");

// Every 1 hour
cron.schedule("0 * * * *", () => {
  console.log("⏰ Running scheduled fetch...");
  fetchVideos();
});