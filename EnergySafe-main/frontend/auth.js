/* ============================================================
   EnergySafe • auth.js
   Sessão (JWT) + controle de acesso por perfil no frontend.
   Incluir ANTES de manutencao.js / financeiro.js / login.js.

   ATENÇÃO: esconder telas aqui é só conforto visual. A proteção real
   é feita pela API (o servidor devolve 401/403 sem token/perfil).
   ============================================================ */

// Produção: mesma origem (o Nginx encaminha /api/ → backend).
// Desenvolvimento local (Live Server :5500): backend em localhost:8000.
const API_URL = (["localhost", "127.0.0.1"].includes(location.hostname) && location.port === "5500")
  ? "http://localhost:8000"
  : "/api";

const Auth = {
  /* ── sessão ── */
  token:  () => sessionStorage.getItem("token"),
  perfil: () => sessionStorage.getItem("perfil"),
  email:  () => sessionStorage.getItem("email"),
  logado: () => !!sessionStorage.getItem("token"),

  /* Cabeçalho para chamadas à API: fetch(url, { headers: { ...Auth.headers() } }) */
  headers() {
    const t = this.token();
    return t ? { Authorization: `Bearer ${t}` } : {};
  },

  async login(email, senha) {
    const resp = await fetch(`${API_URL}/auth/login/`, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams({ username: email, password: senha })
    });
    if (!resp.ok) {
      const err = await resp.json().catch(() => ({}));
      throw new Error(err.detail || "Não foi possível entrar.");
    }
    const d = await resp.json();
    sessionStorage.setItem("token",  d.access_token);
    sessionStorage.setItem("perfil", d.perfil);
    sessionStorage.setItem("email",  d.email);
    return d;
  },

  logout() {
    sessionStorage.clear();
    window.location.replace("index.html");
  },

  /* Página inicial de cada perfil (o master começa na manutenção) */
  paginaInicial(perfil = this.perfil()) {
    return perfil === "financeiro" ? "financeiro.html" : "manutencao.html";
  },

  /* Guarda de página. Ex.: Auth.exigir("manutencao")  → master também entra. */
  exigir(...perfisPermitidos) {
    if (!this.logado()) { window.location.replace("index.html"); return; }
    const p = this.perfil();
    if (p !== "master" && perfisPermitidos.length && !perfisPermitidos.includes(p)) {
      window.location.replace(this.paginaInicial(p));
    }
  }
};

/* Botão "Sair" limpa a sessão; o master ganha atalho para a outra tela. */
document.addEventListener("DOMContentLoaded", () => {
  const sair = document.querySelector(".btn-sair");
  if (sair) {
    sair.addEventListener("click", (e) => { e.preventDefault(); Auth.logout(); });

    if (Auth.perfil() === "master") {
      const naFinanceiro = location.pathname.endsWith("financeiro.html");
      const atalho = document.createElement("a");
      atalho.className = "btn-sair";
      atalho.href = naFinanceiro ? "manutencao.html" : "financeiro.html";
      atalho.textContent = naFinanceiro ? "Manutenção" : "Financeiro";
      atalho.style.marginRight = "8px";
      sair.parentNode.insertBefore(atalho, sair);
    }
  }
});
