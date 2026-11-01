const form     = document.getElementById("loginForm");
const errorBox = document.getElementById("errorBox");
const btnLogin = form.querySelector("button[type='submit']");

function showError(msg) {
  errorBox.textContent = msg;
  errorBox.style.display = "block";
}

function clearError() {
  errorBox.textContent = "";
  errorBox.style.display = "none";
}

form.addEventListener("submit", async function (e) {
  e.preventDefault();
  clearError();

  const email    = document.getElementById("email").value.trim().toLowerCase();
  const password = document.getElementById("password").value;

  if (!email || !password) {
    showError("Preencha e-mail e senha.");
    return;
  }

  btnLogin.disabled = true;
  const textoOriginal = btnLogin.textContent;
  btnLogin.textContent = "Entrando...";

  try {
    const dados = await Auth.login(email, password);
    window.location.href = Auth.paginaInicial(dados.perfil);
  } catch (err) {
    showError(err.message || "Falha no login.");
    btnLogin.disabled = false;
    btnLogin.textContent = textoOriginal;
  }
});

document.getElementById("btnSobre").addEventListener("click", function () {
  window.location.href = "sobre.html";
});
