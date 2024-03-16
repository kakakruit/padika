const db = require("./db");

function insert_ingredient_name(name) {
  // console.log("ingredient: ", name);
  return new Promise((resolve, reject) => {
    db.query(
      `SELECT * FROM ingredient_name WHERE lower(ingredient_name) = lower($1)`,
      [name],
      (error, results) => {
        if (error) {
          reject(error);
        }
        if (results.rowCount != 0) {
          resolve(results.rows[0].ingredient_name_id);
        } else {
          db.query(
            "INSERT INTO ingredient_name (ingredient_name) VALUES ($1) RETURNING ingredient_name_id",
            [name],
            (error, results) => {
              if (error) {
                reject(error);
              }
              resolve(results.rows[0].ingredient_name_id);
            }
          );
        }
      }
    );
  });
}

function insert_ingredient_description(description, source_id) {
  // console.log("Description: ", description, source_id);
  return new Promise((resolve, reject) => {
    db.query(
      `SELECT * FROM ingredient_description WHERE description = $1 and source_id = $2`,
      [description, source_id],
      (error, results) => {
        if (error) {
          reject(error);
        }
        if (results.rowCount != 0) {
          resolve(results.rows[0].description_id);
        } else {
          db.query(
            "INSERT INTO ingredient_description (description,source_id) VALUES ($1, $2) RETURNING description_id",
            [description, source_id],
            (error, results) => {
              if (error) {
                reject(error);
              }
              if (results) resolve(results.rows[0].description_id);
              else reject();
            }
          );
        }
      }
    );
  });
}

function insert_ingredient_description_mapping(
  source_id,
  source_pk,
  name,
  description
) {
  return new Promise((resolve, reject) => {
    var name_id = null;
    var description_id = null;

    // Promises for each insert operation
    const namePromise = insert_ingredient_name(name)
      .then((id) => {
        name_id = id;
      })
      .catch((error) => {
        reject(error);
      });

    const descriptionPromise = insert_ingredient_description(
      description,
      source_id
    )
      .then((id) => {
        description_id = id;
      })
      .catch((error) => {
        reject(error);
      });

    Promise.all([namePromise, descriptionPromise]).then(() => {
      // console.log("Got Values: ", name_id, description_id);
      db.query(
        "INSERT INTO ingredient_description_mapping (ingredient_name_id, description_id, source_pk, source_id) VALUES ($1, $2, $3, $4) RETURNING ingredient_mapping_id",
        [name_id, description_id, source_pk, source_id],
        (error, results) => {
          if (results) resolve(results.rows[0].ingredient_mapping_id);
          resolve(null);
        }
      );
    });
  });
}

function insert_product_name(name, barcode, source_id) {
  // console.log("Product Name: ", name, barcode, source_id);
  return new Promise((resolve, reject) => {
    db.query(
      `SELECT * FROM product WHERE lower(product_name) = lower($1) and barcode = $2`,
      [name, barcode],
      (error, results) => {
        if (error) {
          reject(error);
        }
        if (results.rowCount != 0) {
          resolve(results.rows[0].product_id);
        } else {
          db.query(
            "INSERT INTO product (product_name, barcode, source_id) VALUES ($1, $2, $3) RETURNING product_id",
            [name, barcode, source_id],
            (error, results) => {
              if (error) {
                reject(error);
              }
              if (results) resolve(results.rows[0].product_id);
              else reject();
            }
          );
        }
      }
    );
  });
}

function insert_product_ingredient_mapping(
  product_id,
  ingredient_name,
  source_id
) {
  // console.log(
  //   "Mapping Product Ingredient:",
  //   product_id,
  //   ingredient_name,
  //   source_id
  // );
  return new Promise((resolve, reject) => {
    insert_ingredient_name(ingredient_name).then((ingredient_name_id) => {
      db.query(
        `SELECT * FROM ingredients_list WHERE product_id = $1 and ingredient_name_id = $2 and source_id = $3`,
        [product_id, ingredient_name_id, source_id],
        (error, results) => {
          if (error) {
            reject(error);
          }
          if (results.rowCount != 0) {
            resolve(results.rows[0].ingredients_list_id);
          } else {
            db.query(
              "INSERT INTO ingredients_list (product_id, ingredient_name_id, source_id) VALUES ($1, $2, $3) RETURNING ingredients_list_id",
              [product_id, ingredient_name_id, source_id],
              (error, results) => {
                if (error) {
                  reject(error);
                }
                if (results) resolve(results.rows[0].ingredients_list_id);
                else reject();
              }
            );
          }
        }
      );
    });
  });
}

function insert_product_ingredients(
  product_name,
  barcode,
  source_id,
  ingredients_list
) {
  return new Promise((resolve, reject) => {
    insert_product_name(product_name, barcode, source_id)
      .then((product_id) => {
        async function iterateArray() {
          for (var ingredient_name of ingredients_list) {
            await insert_product_ingredient_mapping(
              product_id,
              ingredient_name,
              source_id
            )
              .then()
              .catch();
          }
        }
        iterateArray()
          .then(() => {
            resolve();
          })
          .catch((error) => {
            reject(error);
          });
      })
      .catch((error) => console.error(error));
  });
}

module.exports.insert_ingredient_description_mapping =
  insert_ingredient_description_mapping;
module.exports.insert_product_ingredients = insert_product_ingredients;
