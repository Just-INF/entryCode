const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const authRoutes = require('./Auth/auth');
const editRoutes = require('./Auth/editAccount');
const statusCheck = require('./setup/setup');
const setup = require('./setup/setup');
const status = require('./status/status');

const reset = "\x1b[0m"; // Reset to default
const red = "\x1b[31m"; // Red

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());

// Test route

app.use('/auth', authRoutes);
app.use('/edit', editRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

async function startUp() {
    console.log(red + 'DataBase INFO - START' + reset);
    await setup.init(app);
    console.log(red + 'DataBase INFO - END' + reset);

    await status.loadStatus(app);
}
startUp();