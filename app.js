// app.js

// Base URL for your API server
const API_BASE_URL = "http://localhost:3000";

/*----------------------------------------
  Common Function: showSection
  Hides all sections with class "input-section" or "citizen-section"
  and then shows the section with the provided ID.
-----------------------------------------*/
function showSection(sectionId) {
  // Try to hide admin input sections (if any)
  document.querySelectorAll('.input-section').forEach(section => {
    section.style.display = 'none';
  });
  // Also hide citizen sections (if any)
  document.querySelectorAll('.citizen-section').forEach(section => {
    section.style.display = 'none';
  });
  // Show the requested section
  const section = document.getElementById(sectionId);
  if (section) {
    section.style.display = 'block';
  }
}

/*----------------------------------------
  ADMIN PAGE FUNCTIONS
-----------------------------------------*/
if (document.getElementById("adminStatus")) {
  // Function to submit a document (Form, Notice, Tender) from Admin Page
  async function submitDocument(docType) {
    let title, content, extra = {};
    if (docType === "Form") {
      title = document.getElementById("formTitle").value.trim();
      content = document.getElementById("formContent").value.trim();
    } else if (docType === "Notice") {
      title = document.getElementById("noticeTitle").value.trim();
      content = document.getElementById("noticeContent").value.trim();
    } else if (docType === "Tender") {
      title = document.getElementById("tenderTitle").value.trim();
      content = document.getElementById("tenderContent").value.trim();
      const tenderStartDate = document.getElementById("tenderStartDate").value;
      const tenderExpectedBid = document.getElementById("tenderExpectedBid").value;
      const tenderDaysLimit = document.getElementById("tenderDaysLimit").value;
      if (!tenderStartDate || !tenderExpectedBid || !tenderDaysLimit) {
        document.getElementById("adminStatus").innerText = "Please fill in all tender fields.";
        return;
      }
      extra = { tenderStartDate, tenderExpectedBid, tenderDaysLimit };
    }
    if (!title || !content) {
      document.getElementById("adminStatus").innerText = "Please fill in all required fields.";
      return;
    }
    const doc = { type: docType, title, content, ...extra };
    console.log("Submitting document:", doc);
    try {
      document.getElementById("adminStatus").innerText = "Submitting document...";
      const response = await fetch(`${API_BASE_URL}/documents`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(doc)
      });
      const data = await response.json();
      if (response.ok) {
        document.getElementById("adminStatus").innerText =
          `Document issued successfully! (ID: ${data.document.id})`;
      } else {
        document.getElementById("adminStatus").innerText = `Error: ${data.error}`;
        console.error("Error response:", data);
      }
    } catch (error) {
      document.getElementById("adminStatus").innerText = "Error: " + error.message;
      console.error(error);
    }
  }

  // Expose admin functions globally if needed
  window.submitDocument = submitDocument;
}

/*----------------------------------------
  CITIZEN PAGE FUNCTIONS
-----------------------------------------*/
if (document.getElementById("citizenStatus")) {
  // Function to fetch documents from the API and populate the Headlines section
  async function fetchDocuments() {
    try {
      document.getElementById("citizenStatus").innerText = "Fetching documents...";
      const response = await fetch(`${API_BASE_URL}/documents`);
      const docs = await response.json();
      const container = document.getElementById("updatesContainer");
      container.innerHTML = ""; // Clear previous updates
      if (docs.length === 0) {
        container.innerHTML = "<p>No updates available.</p>";
      } else {
        docs.forEach(doc => {
          let extra = "";
          if (doc.type === "Tender") {
            extra = `<p><strong>Start Date:</strong> ${doc.tenderStartDate}</p>
                     <p><strong>Expected Bid:</strong> ${doc.tenderExpectedBid}</p>
                     <p><strong>Days Limit:</strong> ${doc.tenderDaysLimit}</p>`;
          }
          const div = document.createElement("div");
          div.className = "update-item";
          div.innerHTML = `
            <p><strong>ID:</strong> ${doc.id}</p>
            <p><strong>Type:</strong> ${doc.type}</p>
            <p><strong>Title:</strong> ${doc.title}</p>
            <p><strong>Content:</strong> ${doc.content}</p>
            ${extra}
            <p><strong>Timestamp:</strong> ${doc.timestamp}</p>
          `;
          container.appendChild(div);
        });
      }
      document.getElementById("citizenStatus").innerText = "Documents fetched.";
    } catch (error) {
      document.getElementById("citizenStatus").innerText = "Error: " + error.message;
      console.error(error);
    }
  }

  // Expose citizen functions globally if needed
  window.fetchDocuments = fetchDocuments;
  window.showSection = showSection;
}

/*----------------------------------------
  OPTIONAL: Common initialization code if needed
-----------------------------------------*/
// For example, you could auto-load a default section on page load:
window.addEventListener("load", () => {
  // Uncomment the next line if you want to auto-show a section (for citizen page, e.g., Headlines):
  // showSection('headlinesSection');
});
