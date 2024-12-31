const express = require('express');
const setup = require('../setup/setup');
const db = require('../database'); // Import the database pool

//----------------DATABASE CHECK------------------
let isDbOn = false;
// Function to check database status
async function checkDb() {
    let connection;
    try {
        connection = await db.getConnection();
        isDbOn = true;
    } catch (err) {
        isDbOn = false;
    } finally {
        if (connection) connection.release(); // Ensure the connection is released if it was acquired
    }
}

// Set up a periodic check every 15 minutes (900000 ms)
setInterval(checkDb, 600000);
checkDb();
//----------------DATABASE CHECK------------------

async function loadStatus(app) {
    // Create the HTML response based on the latest database status
    app.get('/', (req, res) => {
        const htmlResponse = `
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EntryCode Status Page</title>
            <style>
                body { font-family: 'Arial', sans-serif; margin: 0; padding: 20px; background-color: #e9ecef; color: #495057; }
                h1 { text-align: center; color: #343a40; margin-bottom: 30px; }
                .status-table { width: 80%; margin: 0 auto; border-collapse: collapse; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); border-radius: 8px; overflow: hidden; }
                .status-table th, .status-table td { padding: 15px; text-align: left; border-bottom: 1px solid #dee2e6; }
                .status-table th { background-color: #007bff; color: white; font-weight: bold; }
                .status-table tr:hover { background-color: #f1f1f1; }
                .status { width: 15px; height: 15px; border-radius: 50%; display: inline-block; margin-right: 8px; }
                .green { background-color: #28a745; }
                .red { background-color: #dc3545; }
                .yellow { background-color: #ffc107; }
                .footer { text-align: center; margin-top: 40px; color: #6c757d; }
            </style>
        </head>
        <body>
            <h1>EntryCode Status Page</h1>
            <table class="status-table">
                <thead>
                    <tr>
                        <th>Service</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Database</td>
                        <td>
                            <span class="status ${isDbOn ? 'green' : 'red'}"></span>
                            ${isDbOn ? 'Operational' : 'Down'}
                        </td>
                    </tr>
                    <tr>
                        <td>API</td>
                        <td><span class="status yellow"></span> Tracking Not Available</td>
                    </tr>
                    <tr>
                        <td>Web Server</td>
                        <td><span class="status yellow"></span> Tracking Not Available</td>
                    </tr>
                    <tr>
                        <td>Email Service</td>
                        <td><span class="status yellow"></span> Tracking Not Available</td>
                    </tr>
                    <tr>
                        <td>File Storage</td>
                        <td><span class="status yellow"></span> Tracking Not Available</td>
                    </tr>
                </tbody>
            </table>
            <div class="footer">
                <p>&copy; 2024 EntryCode. All rights reserved.</p>
            </div>
        </body>
        </html>
        `;
        res.send(htmlResponse);
    });
}

module.exports = { loadStatus };
