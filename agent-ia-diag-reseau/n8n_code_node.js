// Exemple de code pour le nœud "Code"
const text = $json.body.message.text;
const parts = text.split(' '); // Sépare la commande par des espaces

if (parts.length < 3 || parts[0] !== '/diag') {
  return; // Ignore les messages mal formatés
}

const module = parts[1]; // "dns", "http", "tcp", etc.
const target = parts[2]; // "google.com"

// Retourne les données pour les nœuds suivants
return [{
  json: {
    module: module,
    target: target
  }
}];