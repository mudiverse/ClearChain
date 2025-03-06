// app.js

// Replace with your API base URL if different (e.g., if hosted on Vercel or Heroku)
const API_BASE_URL = "http://localhost:3000";

// --- Admin Page Logic ---
document.addEventListener("DOMContentLoaded", () => {
  // Check if we're on the admin page by looking for the Issue Document button
  const btnIssue = document.getElementById("btnIssueDocument");
  if (btnIssue) {
    const docTypeSelect = document.getElementById("docType");
    const tenderFields = document.getElementById("tenderFields");

    // Show/hide tender fields based on selected type
    docTypeSelect.addEventListener("change", () => {
      if (docTypeSelect.value === "tender") {
        tenderFields.style.display = "block";
      } else {
        tenderFields.style.display = "none";
      }
    });

    btnIssue.addEventListener("click", async () => {
      const type = docTypeSelect.value;
      const title = document.getElementById("docTitle").value.trim();
      const content = document.getElementById("docContent").value.trim();

      if (!title || !content) {
        document.getElementById("adminStatus").innerText = "Please fill in title and content.";
        return;
      }

      // Create the document object
      let doc = { type, title, content };

      // If it's a tender, add additional fields
      if (type === "tender") {
        const tenderStartDate = document.getElementById("tenderStartDate").value;
        const tenderExpectedBid = document.getElementById("tenderExpectedBid").value;
        const daysLimit = document.getElementById("daysLimit").value;

        if (!tenderStartDate || !tenderExpectedBid || !daysLimit) {
          document.getElementById("adminStatus").innerText = "Please fill in all tender fields.";
          return;
        }

        doc.tenderStartDate = tenderStartDate;
        doc.tenderExpectedBid = tenderExpectedBid;
        doc.daysLimit = daysLimit;
      }

      // Send POST request to issue the document
      try {
        document.getElementById("adminStatus").innerText = "Issuing document...";
        const response = await fetch(`${API_BASE_URL}/documents`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(doc),
        });
        const data = await response.json();
        if (response.ok) {
          document.getElementById("adminStatus").innerText =
            `Document issued successfully! (ID: ${data.document.id})`;
          // Clear inputs
          document.getElementById("docTitle").value = "";
          document.getElementById("docContent").value = "";
          if (type === "tender") {
            document.getElementById("tenderStartDate").value = "";
            document.getElementById("tenderExpectedBid").value = "";
            document.getElementById("daysLimit").value = "";
          }
        } else {
          document.getElementById("adminStatus").innerText = "Error: " + data.error;
        }
      } catch (err) {
        console.error(err);
        document.getElementById("adminStatus").innerText = "Error: " + err.message;
      }
    });
  }

  // --- Citizen Page Logic ---
  const btnFetch = document.getElementById("btnFetchDocuments");
  if (btnFetch) {
    btnFetch.addEventListener("click", async () => {
      try {
        document.getElementById("citizenStatus").innerText = "Fetching documents...";
        const response = await fetch(`${API_BASE_URL}/documents`);
        const docs = await response.json();
        const list = document.getElementById("documentsList");
        list.innerHTML = "";
        if (docs.length === 0) {
          list.innerHTML = "<li>No documents available.</li>";
        } else {
          docs.forEach((doc) => {
            let li = document.createElement("li");
            li.innerHTML = `<strong>ID:</strong> ${doc.id}<br>
              <strong>Type:</strong> ${doc.type}<br>
              <strong>Title:</strong> ${doc.title}<br>
              <strong>Content:</strong> ${doc.content}<br>
              <strong>Timestamp:</strong> ${doc.timestamp}`;
            if (doc.type === "tender") {
              li.innerHTML += `<br><strong>Tender Start Date:</strong> ${doc.tenderStartDate}<br>
              <strong>Expected Bid:</strong> ${doc.tenderExpectedBid}<br>
              <strong>Days Limit:</strong> ${doc.daysLimit}`;
            }
            list.appendChild(li);
          });
        }
        document.getElementById("citizenStatus").innerText = "Documents fetched.";
      } catch (err) {
        console.error(err);
        document.getElementById("citizenStatus").innerText = "Error: " + err.message;
      }
    });
  }
});
