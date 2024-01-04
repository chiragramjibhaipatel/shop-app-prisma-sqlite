/*
  Warnings:

  - The primary key for the `Product` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The required column `id` was added to the `Product` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Variant" (
    "admin_graphql_api_id" TEXT NOT NULL PRIMARY KEY,
    "productId" TEXT NOT NULL,
    CONSTRAINT "Variant_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Variant" ("admin_graphql_api_id", "productId") SELECT "admin_graphql_api_id", "productId" FROM "Variant";
DROP TABLE "Variant";
ALTER TABLE "new_Variant" RENAME TO "Variant";
CREATE TABLE "new_Product" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "admin_graphql_api_id" TEXT NOT NULL,
    "body_html" TEXT,
    "created_at" DATETIME,
    "handle" TEXT,
    "product_type" TEXT,
    "published_at" DATETIME,
    "template_suffix" TEXT,
    "title" TEXT,
    "updated_at" DATETIME,
    "vendor" TEXT,
    "status" TEXT,
    "published_scope" TEXT,
    "tags" TEXT
);
INSERT INTO "new_Product" ("admin_graphql_api_id", "body_html", "created_at", "handle", "product_type", "published_at", "published_scope", "status", "tags", "template_suffix", "title", "updated_at", "vendor") SELECT "admin_graphql_api_id", "body_html", "created_at", "handle", "product_type", "published_at", "published_scope", "status", "tags", "template_suffix", "title", "updated_at", "vendor" FROM "Product";
DROP TABLE "Product";
ALTER TABLE "new_Product" RENAME TO "Product";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
