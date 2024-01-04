/*
  Warnings:

  - The primary key for the `Product` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Product` table. The data in that column could be lost. The data in that column will be cast from `String` to `BigInt`.
  - The primary key for the `Variant` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `admin_graphql_api_id` on the `Variant` table. All the data in the column will be lost.
  - You are about to alter the column `productId` on the `Variant` table. The data in that column could be lost. The data in that column will be cast from `String` to `BigInt`.
  - Added the required column `id` to the `Variant` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Product" (
    "id" BIGINT NOT NULL PRIMARY KEY,
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
INSERT INTO "new_Product" ("admin_graphql_api_id", "body_html", "created_at", "handle", "id", "product_type", "published_at", "published_scope", "status", "tags", "template_suffix", "title", "updated_at", "vendor") SELECT "admin_graphql_api_id", "body_html", "created_at", "handle", "id", "product_type", "published_at", "published_scope", "status", "tags", "template_suffix", "title", "updated_at", "vendor" FROM "Product";
DROP TABLE "Product";
ALTER TABLE "new_Product" RENAME TO "Product";
CREATE TABLE "new_Variant" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "productId" BIGINT NOT NULL,
    CONSTRAINT "Variant_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Variant" ("productId") SELECT "productId" FROM "Variant";
DROP TABLE "Variant";
ALTER TABLE "new_Variant" RENAME TO "Variant";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
