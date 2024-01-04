/*
  Warnings:

  - You are about to drop the `Image` table. If the table is not empty, all the data it contains will be lost.
  - The primary key for the `Product` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Product` table. All the data in the column will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Image";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Variant" (
    "admin_graphql_api_id" TEXT NOT NULL PRIMARY KEY
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Product" (
    "admin_graphql_api_id" TEXT NOT NULL PRIMARY KEY,
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
