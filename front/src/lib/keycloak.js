import Keycloak from "keycloak-js";

export const keycloak = new Keycloak({
  url: "http://localhost:8080",
  realm: "testpoc",
  clientId: "frontend-client",
});

export async function initKeycloak() {
  try {
    await keycloak.init({
      onLoad: "check-sso",
      checkLoginIframe: false,
      pkceMethod: "S256",
    });

    return keycloak;
  } catch (error) {
    console.error("Keycloak init error:", error);
  }
}