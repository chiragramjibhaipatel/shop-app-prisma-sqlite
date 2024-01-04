-- CreateTable
CREATE TABLE "Image" (
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
    "variant_ids" TEXT
);

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
    "tags" TEXT,
    "imageId" BIGINT NOT NULL DEFAULT 0,
    CONSTRAINT "Product_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES "Image" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Product" ("admin_graphql_api_id", "body_html", "created_at", "handle", "id", "product_type", "published_at", "published_scope", "status", "tags", "template_suffix", "title", "updated_at", "vendor") SELECT "admin_graphql_api_id", "body_html", "created_at", "handle", "id", "product_type", "published_at", "published_scope", "status", "tags", "template_suffix", "title", "updated_at", "vendor" FROM "Product";
DROP TABLE "Product";
ALTER TABLE "new_Product" RENAME TO "Product";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
