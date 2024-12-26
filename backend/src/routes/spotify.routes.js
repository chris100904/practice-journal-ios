import { Router } from "express";
const router = Router();
import { getAuthURL, handleCallback } from "../spotify/auth";
import { searchTracks } from "../spotify/search";

router.get('/auth', (req, res) => {
  const url = getAuthURL();
  res.json({ url });
});

router.get('/callback', async (req, res) => {
    try {
        const { code } = req.query;
        const tokens = await handleCallback(code);
        res.json(tokens);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get("/search", async (req, res) => {
    try {
        const { q } = req.query;
        const results = await searchTracks(q);
        res.json(results);
    } catch (error) {
        handleError(error, res);
    }
});


/**
 * Handles an error by logging it and sending a JSON response to the client
 * with the appropriate HTTP status code and error message.
 *
 * @param {Error} error - The error to handle
 * @param {Response} res - The response object
 */
const handleError = (error, res) => {
  let statusCode = 500;
  let message = "Internal Server Error";

  if (error.response && error.response.status) {
    statusCode = error.response.status;
    if (statusCode === 401) message = "Bad or expired token";
    else if (statusCode === 403) message = "Bad OAuth request";
    else if (statusCode === 429) message = "Exceeded rate limit";
  } else if (error.message) {
    if (error.message.includes("validation")) {
      statusCode = 400;
      message = "Bad Request - Validation Error";
    }
  }

  console.error(error);

  res.status(statusCode).json({ error: message });
};

export default router;