const fs = require("fs");
const db = require("./db");
const { insert_ingredient_description_mapping } = require("./helper");

var path =
  "./Food_Database/foodb_2020_04_07_json/foodb_2020_04_07_json/Compound.json";
// var path = "./Compound.json";

try {
  const data = fs.readFileSync(path, "utf8");
  const jsonObjects = data.trim().split("\n");
  async function iterateArray() {
    for (var item of jsonObjects) {
      let jsonObject = JSON.parse(item);
      if (jsonObject.id && jsonObject.name && jsonObject.description) {
        await insert_ingredient_description_mapping(
          5,
          jsonObject.id,
          jsonObject.name,
          jsonObject.description
        ).then((e) => console.log("Mapping id:", e));
      }
    }
  }
  iterateArray()
    .then(() => {
      console.log("Done!");
    })
    .catch((error) => {
      console.error("Error:", error);
    });
} catch (error) {
  console.error("Error reading the file:", error);
} finally {
  console.log("Finished Quering. please wait");
}
