const { db, admin } = require('../firebaseService');
const { getTokenData } = require('./tokenService');

async function getCertificateByToken(token) {
  const tokenData = await getTokenData(token);
  if (!tokenData) return { status: 404, error: "Invalid token" };

  if (Date.now() > tokenData.expiresAt) {
    return { status: 410, error: "Link expired" };
  }

  const certDoc = await db.collection('certificates').doc(tokenData.certId).get();
  if (!certDoc.exists) return { status: 404, error: "Certificate not found" };

  const cert = certDoc.data();
  const [url] = await admin
    .storage()
    .bucket()
    .file(cert.filePath)
    .getSignedUrl({
      action: 'read',
      expires: Date.now() + 60 * 60 * 1000,
    });

  return {
    status: 200,
    data: {
      metadata: cert,
      fileUrl: url,
    },
  };
}

module.exports = { getCertificateByToken };
