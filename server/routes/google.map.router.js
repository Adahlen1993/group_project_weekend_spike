const express = require('express');
const pool = require('../modules/pool');
const router = express.Router();
const axios = require('axios');

/**
 * GET route template
 */
router.get('/location', async (req, res) => {
  // GET route code here
  try {
    const response = await axios.post(
      `https://www.googleapis.com/geolocation/v1/geolocate?key=${process.env.REACT_APP_GOOGLE_MAPS_API_KEY}`
    );
    res.json(response.data.location);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

/**
 * POST route template
 */
router.post('/', (req, res) => {
  // POST route code here
});

module.exports = router;

