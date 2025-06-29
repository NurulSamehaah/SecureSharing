const express = require('express');
const cors = require('cors');
const app = express();
const certRoutes = require('./routes/certificate');

app.use(cors());
app.use(express.json());
app.use('/api', certRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
