// server.js
const express = require("express");
const cors = require("cors");
const { Low, JSONFile } = require("lowdb");
const app = express();

app.use(cors());
app.use(express.json());

// Setup Lowdb with a JSON file database
const adapter = new JSONFile("db.json");
const db = new Low(adapter);

// Initialize the database structure
async function initDB() {
  await db.read();
  db.data = db.data || { documents: [] };
  await db.write();
}
initDB();

// POST endpoint for issuing a document
app.post("/documents", async (req, res) => {
  const doc = req.body;
  if (!doc.title || !doc.content || !doc.type) {
    return res.status(400).json({ error: "Missing required fields." });
  }
  // Auto-increment id
  const documents = db.data.documents;
  const id = documents.length ? documents[documents.length - 1].id + 1 : 1;
  doc.id = id;
  doc.timestamp = new Date().toLocaleString();
  documents.push(doc);
  await db.write();
  res.json({ message: "Document issued successfully", document: doc });
});

// GET endpoint to fetch all documents
app.get("/documents", async (req, res) => {
  await db.read();
  res.json(db.data.documents);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`API Server running on port ${PORT}`);
});
