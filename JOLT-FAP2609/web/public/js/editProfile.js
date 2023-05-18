function showEditModal() {
  var contact = document.getElementById("contact");
  var editContact = document.getElementById("edit-contact");
  var description = document.getElementById("description");
  var editDescription = document.getElementById("edit-description");

  if (contact.classList.contains("hidden")) {
    contact.classList.remove("hidden");
    description.classList.remove("hidden");
    editContact.classList.add("hidden");
    editDescription.classList.add("hidden");
  } else {
    contact.classList.add("hidden");
    description.classList.add("hidden");
    editContact.classList.remove("hidden");
    editDescription.classList.remove("hidden");
  }
}

function showCredentials() {
  var credential = document.getElementById("change-credential");
  var btn = document.getElementById("credential-btn");
  if (credential.classList.contains("hidden")) {
    credential.classList.remove("hidden");
    btn.innerHTML = "Hide Credentials"
  } else {
    credential.classList.add("hidden");
    btn.innerHTML = "Show Credentials"
  }
}

