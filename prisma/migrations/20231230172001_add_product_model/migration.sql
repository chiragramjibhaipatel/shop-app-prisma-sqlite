-- CreateTable
CREATE TABLE "Product" (
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
