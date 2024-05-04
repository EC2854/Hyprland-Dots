// Windows
import { Bar } from "./modules/bar/bar.js";
import { Dashboard } from "./modules/dashboard/dashboard.js";

// Apply css
const applyScss = () => {
  // Compile scss
  Utils.exec(
    `sassc ${App.configDir}/scss/main.scss ${App.configDir}/style.css`,
  );
  console.log("Scss compiled");

  // Apply compiled css
  App.resetCss();
  App.applyCss(`${App.configDir}/style.css`);
  console.log("Compiled css applied");
};

// Apply css then check for changes
applyScss();


// Main config
App.config({
    style: `${App.configDir}/style.css`,
    windows: [Bar(), Dashboard() ],
});
