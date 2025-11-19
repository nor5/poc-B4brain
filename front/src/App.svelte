

<script>
  import { onMount } from 'svelte';
  import Keycloak from "keycloak-js";

  let keycloak;
  let token = null;
  let apiData = {};
  let isInitialized = false;
  let isLogged = false;
  let envType = "";
  let envName = "";
  let showForm = false;
  $: isAdmin = apiData.roles?.includes("admin");
  


   onMount(() => {
    keycloak = new Keycloak({
      url: "http://localhost:8080",
      realm: "testpoc",
      clientId: "frontend-client"
    });

    keycloak
      .init({
        onLoad: "check-sso",
        pkceMethod: "S256", //method pour les app SPA
        checkLoginIframe: false, //pas check automatique de session
        scope: "openid profile email api-backend-scope",
      })
      .then((authenticated) => {
        isInitialized = true;
        isLogged = authenticated;
        if (authenticated) {
          token = keycloak.token;
          fetchData();
          getEnvironment();
        }
      });
  });

   function login() {
    keycloak.login();
  }
  function logout() {
    keycloak.logout();
  }



  async function fetchData() {
    const res = await fetch("http://localhost:5000/api/auth", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    apiData = await res.json();
  }
  


  //create env 
   function showCreateForm() {
    showForm = true;
  }
  async function createEnvironment() {
    if (!envName || !envType) {
      alert("Veuillez remplir tous les champs !");
      return;
    }
    const response = await fetch("http://localhost:5000/api/environments", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${token}`
      },
      body: JSON.stringify({ name: envName, type: envType })
    });
    const data = await response.json();

    if (response.ok) {
      alert(`Environnement créé : ${data.name}`);
      showForm = false;
      envName = "";
      envType = "";
      
    } else {
      alert(data.error || "Erreur lors de la création");
    }
  }

  async function getEnvironment() {
    const response = await fetch("http://localhost:5000/api/environments", {
      headers: {
        "Authorization": `Bearer ${token}`
      }
    });
    if (response.ok){
      const data = await response.json();
      console.log("Environnements reçus du backend :", data);
      apiData.environments = data || []; 
      console.log("Environnements reçus du api.env :", apiData.environments);
    } else {
      console.error("Erreur lors de la récupération des environnements");
    }

    }
  
</script>




<main>
  {#if !isInitialized}
  <p>Chargement...</p>
  {:else if !isLogged}
   
    <div class="banner">
      <img src="/b4brain.jpg" alt="B4Brain Banner" />
    </div>

    <div class="login-container">
      <h1>Bienvenue sur B4Brain</h1>
      <p>Veuillez vous connecter pour accéder à votre espace scientifique.</p>
      <button class="login-btn" on:click={login}>Se connecter</button>
    </div>
  {:else}
  <header class="top-bar">
      <img src="/b4brain.jpg" alt="B4brain" class="logo" />
      <button class="logout-btn" on:click={logout}>Se déconnecter</button>
    </header>
    <section class="card">
      <h2> Profil utilisateur</h2>

      <div class="info-item">
        <span>Nom</span>
        <strong>{apiData.name}</strong>
      </div>

      <div class="info-item">
        <span>Email</span>
        <strong>{apiData.email}</strong>
      </div>

      <div class="info-item">
        <span>Rôles</span>
        <div class="roles">
          {#each apiData.resource_access?.["backend-api"]?.roles || [] as role}
            <span class="role-pill">{role}</span>
          {/each}
        </div>
      </div>
    </section>

    <section class="card">
      <h2> Vos environnements scientifiques</h2>

      {#if apiData.environments?.length > 0}
        <ul class="env-list">
          {#each apiData.environments as env}
            <li>
              <strong>{env.name}</strong>
              <span class="env-status">{env.status}</span>
            </li>
          {/each}
        </ul>
      {:else}
        <p>Aucun environnement pour le moment.</p>
      {/if}
 
    </section>
   {#if apiData.resource_access?.["backend-api"]?.roles.includes("admin")}
  <button class="create-btn" on:click={showCreateForm}>
    ➕ Créer un environnement
  </button>
   {/if}
   {#if showForm}
  <div class="card form-card">
    <h3>Créer un nouvel environnement</h3>

    <label>Nom :</label>
    <input type="text" bind:value={envName} placeholder="Nom de l'environnement" />

    <label>Type :</label>
    <select bind:value={envType}>
      <option value="" disabled selected>Choisissez un type</option>
      <option value="python-VM">python-VM</option>
      <option value="jupyter-VM">jupyter-VM</option>
      <option value="Test">Test</option>
    </select>

    <div class="buttons">
      <button class="create-btn" on:click={createEnvironment}>Créer</button>
      <button class="cancel-btn" on:click={() => showForm = false}>Annuler</button>
    </div>
  </div>
{/if}

    
  {/if}
</main>
