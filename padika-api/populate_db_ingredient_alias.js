const fs = require("fs");
const db = require("./db");
const { insert_product_alias_mapping } = require("./helper");

var path =
  "./Food_Database/foodb_2020_04_07_json/foodb_2020_04_07_json/CompoundSynonym.json";

try {
  const data = fs.readFileSync(path, "utf8");
  const jsonObjects = data.trim().split("\n");
  async function iterateArray() {
    for (var item of jsonObjects) {
      let jsonObject = JSON.parse(item);
      console.log(jsonObject.id, jsonObject.synonym, jsonObject.source_id);
      await insert_product_alias_mapping(
        jsonObject.id,
        jsonObject.synonym,
        jsonObject.source_id,
        5
      ).then((e) => console.log("Mapping id:", e));
    }
  }
  iterateArray()
    .then(() => {
      console.log("Done");
    })
    .catch((error) => {
      console.error("Error:", error);
    });
} catch (error) {
  console.error("Error reading the file:", error);
} finally {
  console.log("Finished Quering!");
}
