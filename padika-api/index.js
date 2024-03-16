const express = require("express");
const cors = require("cors");
const db = require("./db");
const bodyParser = require("body-parser");
const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

//get all products
app.get("/api/search/products", (request, response) => {
  console.log("All products");
  db.query(
    `select product_id, barcode, product_name, source_name from product p 
    inner join data_source ds 
    on p.source_id = ds.source_id
    limit 100`,
    (error, results) => {
      if (error) {
        response.status(500).json(error);
      }
      response.status(200).json(results.rows);
    }
  );
});
//get all ingredients
app.get("/api/search/ingredients", (request, response) => {
  console.log("All ingredients");
  db.query(
    `SELECT in2.ingredient_name_id, ingredient_name, idm.description_id, description, source_name FROM ingredient_name in2
    left join ingredient_description_mapping idm 
    on idm.ingredient_name_id = in2.ingredient_name_id
    left join ingredient_description id 
    on id.description_id = idm.description_id 
    left join data_source ds 
    on id.source_id = ds.source_id
    limit 100`,
    (error, results) => {
      if (error) {
        response.status(500).json(error);
      }
      response.status(200).json(results.rows);
    }
  );
});

//search for product by id
app.get("/api/search/product/:id", (request, response) => {
  console.log("Product id:", request.params.id);
  db.query(
    `select barcode, product_name, source_name from product p 
      inner join data_source ds 
      on p.source_id = ds.source_id
      where product_id = ${request.params.id}
      limit 100;`,
    (error, results) => {
      if (error) {
        response.status(500).json(error);
      }
      response.status(200).json(results.rows);
    }
  );
});

//search for products by barcode
app.get("/api/search/barcode/:id", (request, response) => {
  console.log("Barcode: " + request.params.id);
  db.query(
    `select product_id, product_name, source_name from product p 
      inner join data_source ds 
      on p.source_id = ds.source_id
      where barcode = ${request.params.id}
      limit 100;`,
    (error, results) => {
      if (error) {
        response.status(500).json(error);
      }
      response.status(200).json(results.rows);
    }
  );
});

//search for products by name
app.get("/api/search/products/:name", (request, response) => {
  console.log("Product by name: " + request.params.name);
  db.query(
    `select product_id, barcode, product_name, source_name from product p 
    inner join data_source ds 
    on p.source_id = ds.source_id
    where lower(product_name) like lower('%${request.params.name}%')
    limit 100;`,
    (error, results) => {
      if (error) {
        response.status(500).json(error);
      }
      response.status(200).json(results.rows);
    }
  );
});

//search for ingredient by id
app.get("/api/search/ingredient/:id", (request, response) => {
  console.log("Ingredient id:", request.params.id);
  db.query(
    `SELECT ingredient_name, idm.description_id, description, source_name FROM ingredient_name in2
      left join ingredient_description_mapping idm 
      on idm.ingredient_name_id = in2.ingredient_name_id
      left join ingredient_description id 
      on id.description_id = idm.description_id 
      left join data_source ds 
      on id.source_id = ds.source_id
      where in2.ingredient_name_id = ${request.params.id}
      limit 100;`,
    (error, results) => {
      if (error) {
        response.status(500).json(error);
      }
      response.status(200).json(results.rows);
    }
  );
});

//search for ingredients by name
app.get("/api/search/ingredients/:name", (request, response) => {
  console.log("Ingredient by name", request.params.name);
  db.query(
    `SELECT in2.ingredient_name_id, ingredient_name, idm.description_id, description, source_name FROM ingredient_name in2
    left join ingredient_description_mapping idm 
    on idm.ingredient_name_id = in2.ingredient_name_id
    left join ingredient_description id 
    on id.description_id = idm.description_id 
    left join data_source ds 
    on id.source_id = ds.source_id
    where lower(ingredient_name) like lower('%${request.params.name}%')
    limit 100;`,
    (error, results) => {
      if (error) {
        response.status(500).json(error);
      }
      response.status(200).json(results.rows);
    }
  );
});

//get ingredients of a product
app.get("/api/search/ingredients_list/:id", (request, response) => {
  console.log("Ingredients list:", request.params.id);
  db.query(
    `select il.ingredient_name_id, ingredient_name, idesc.description_id, description  from ingredients_list il 
    inner join product p 
    on p.product_id = il.product_id 
    inner join ingredient_name inname
    on il.ingredient_name_id  = inname.ingredient_name_id 
    left join ingredient_description_mapping idm 
    on idm.ingredient_name_id = il.ingredient_name_id 
    left join ingredient_description idesc
    on idesc.description_id = idm.description_id 
    where il.product_id = ${request.params.id}
    limit 100;`,
    (error, results) => {
      if (error) {
        response.status(500).json(error);
      }
      response.status(200).json(results.rows);
    }
  );
});

app.get("/", (request, response) => {
  response.json({ info: "All systems nominal" });
});
app.listen(port, () => {
  console.log(`App running on port ${port}.`);
});
