const express = require('express');
const router = express.Router();
const { getCertificateByToken } = require('../services/certificateService');

router.get('/view/:token', async (req, res) => {
  try {
    const result = await getCertificateByToken(req.params.token);
    if (result.error) {
      return res.status(result.status).json({ error: result.error });
    }
    res.json(result.data);
  } catch (err) {
    res.status(500).json({ error: "Server error" });
  }
});

module.exports = router;
