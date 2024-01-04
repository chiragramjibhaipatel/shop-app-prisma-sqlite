/*
  Warnings:

  - Added the required column `productId` to the `Variant` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Variant" (
    "admin_graphql_api_id" TEXT NOT NULL PRIMARY KEY,
    "productId" TEXT NOT NULL,
    CONSTRAINT "Variant_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("admin_graphql_api_id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Variant" ("admin_graphql_api_id") SELECT "admin_graphql_api_id" FROM "Variant";
DROP TABLE "Variant";
ALTER TABLE "new_Variant" RENAME TO "Variant";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
