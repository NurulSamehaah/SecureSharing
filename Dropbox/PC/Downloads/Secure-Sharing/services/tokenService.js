const { db } = require('../firebaseService');
const { v4: uuidv4 } = require('uuid');

async function generateToken(certId, expireSeconds = 86400) {
  const token = uuidv4();
  const now = Date.now();
  const data = {
    certId,
    token,
    createdAt: now,
    expiresAt: now + expireSeconds * 1000
  };
  await db.collection('shared_links').doc(token).set(data);
  return token;
}

async function getTokenData(token) {
  const doc = await db.collection('shared_links').doc(token).get();
  if (!doc.exists) return null;
  return doc.data();
}

module.exports = { generateToken, getTokenData };
