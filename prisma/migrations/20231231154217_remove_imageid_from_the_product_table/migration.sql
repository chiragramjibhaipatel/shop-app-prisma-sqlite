/*
  Warnings:

  - You are about to drop the column `imageId` on the `Product` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Product" (
    "admin_graphql_api_id" TEXT NOT NULL,
    "body_html" TEXT,
    "created_at" DATETIME,
    "handle" TEXT,
    "id" BIGINT NOT NULL PRIMARY KEY,
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
INSERT INTO "new_Product" ("admin_graphql_api_id", "body_html", "created_at", "handle", "id", "product_type", "published_at", "published_scope", "status", "tags", "template_suffix", "title", "updated_at", "vendor") SELECT "admin_graphql_api_id", "body_html", "created_at", "handle", "id", "product_type", "published_at", "published_scope", "status", "tags", "template_suffix", "title", "updated_at", "vendor" FROM "Product";
DROP TABLE "Product";
ALTER TABLE "new_Product" RENAME TO "Product";
CREATE TABLE "new_Image" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "position" INTEGER,
    "product_id" BIGINT,
    "width" INTEGER,
    "height" INTEGER,
    "alt" TEXT,
    "src" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "admin_graphql_api_id" TEXT,
    "variant_ids" TEXT,
    CONSTRAINT "Image_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Image" ("admin_graphql_api_id", "alt", "created_at", "height", "id", "position", "product_id", "src", "updated_at", "variant_ids", "width") SELECT "admin_graphql_api_id", "alt", "created_at", "height", "id", "position", "product_id", "src", "updated_at", "variant_ids", "width" FROM "Image";
DROP TABLE "Image";
ALTER TABLE "new_Image" RENAME TO "Image";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
