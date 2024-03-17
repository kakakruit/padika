const fs = require("fs");
const readline = require("readline");
const { insert_product_ingredients } = require("./helper");

async function processLine(line) {
  const fields = line.split("\t"); // Assuming tab-separated values, adjust if needed
  const code = fields[0];
  const productName = fields[8];
  var ingredientsText = fields[39];
  if (code && productName && ingredientsText && code != "code") {
    console.log(code, productName);
    if (ingredientsText[ingredientsText.length - 1] == ".")
      ingredientsText = ingredientsText.slice(0, -1);
    var ingredients = ingredientsText.split(/\s*,\s*(?![^()]*\))/);
    await insert_product_ingredients(productName, code, 2, ingredients);
  }
}

// Define the path to your CSV file
const filePath =
  "C:/Users/SeriousWolfey/Documents/Work/Projects/HackOverflow2/Food_Database/OpenFoodFacts/2/products.csv"; // Change this to the path of your CSV file

// Create a readline interface to read the file
const rl = readline.createInterface({
  input: fs.createReadStream(filePath),
  crlfDelay: Infinity,
});
async function processFile() {
  for await (const line of rl) {
    try {
      await processLine(line);
    } catch (error) {
      console.error("Error processing line:", error);
    }
  }
}

// Start processing the file
processFile()
  .then(() => {
    console.log("Finished processing the file.");
  })
  .catch((error) => {
    console.error("Error processing file:", error);
  });
