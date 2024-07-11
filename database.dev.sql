-- Ensure proper naming conventions, data types, and indexing

CREATE TABLE IF NOT EXISTS "user" (
	"id" BIGSERIAL PRIMARY KEY,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL, -- Ensure this is hashed and salted
	"name" TEXT NOT NULL,
	"phone_number" VARCHAR(20) NOT NULL,
	"address" TEXT NOT NULL,
	"birthdate" DATE,
	"created_at" TIMESTAMP NOT NULL DEFAULT current_timestamp,
	"admin" BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS "discounts" (
	"id" BIGSERIAL PRIMARY KEY,
	"name" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "restrictions" (
	"id" BIGSERIAL PRIMARY KEY,
	"name" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "golf_courses" (
	"id" BIGSERIAL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"phone_number" VARCHAR(20),
	"is_active" BOOLEAN NOT NULL DEFAULT true, -- Consistent naming with snake_case
	"created_at" TIMESTAMP NOT NULL DEFAULT current_timestamp,
	"street" TEXT NOT NULL,
	"city" TEXT NOT NULL,
	"state" TEXT NOT NULL,
	"zip_code" VARCHAR(10) NOT NULL, -- ZIP codes can have leading zeros and extended format
	"latitude" DECIMAL(9,6) NOT NULL,
	"longitude" DECIMAL(9,6) NOT NULL,
    "image_url" TEXT -- Use TEXT for URLs for consistency
);

CREATE TABLE IF NOT EXISTS "golf_courses_discounts" (
	"id" BIGSERIAL PRIMARY KEY,
	"golf_course_id" BIGINT NOT NULL,
	"discount_id" BIGINT NOT NULL,
	FOREIGN KEY ("golf_course_id") REFERENCES "golf_courses"("id") ON DELETE CASCADE,
	FOREIGN KEY ("discount_id") REFERENCES "discounts"("id") ON DELETE CASCADE,
	UNIQUE ("golf_course_id", "discount_id") -- Ensure unique pairings
);

CREATE TABLE IF NOT EXISTS "golf_courses_restrictions" (
	"id" BIGSERIAL PRIMARY KEY,
	"golf_course_id" BIGINT NOT NULL,
	"restriction_id" BIGINT NOT NULL,
	FOREIGN KEY ("golf_course_id") REFERENCES "golf_courses"("id") ON DELETE CASCADE,
	FOREIGN KEY ("restriction_id") REFERENCES "restrictions"("id") ON DELETE CASCADE,
	UNIQUE ("golf_course_id", "restriction_id") -- Ensure unique pairings
);

CREATE TABLE IF NOT EXISTS "punch_card" (
	"id" BIGSERIAL PRIMARY KEY,
	"user_id" BIGINT NOT NULL,
	"is_purchased" BOOLEAN NOT NULL DEFAULT false,
	"purchased_date" TIMESTAMP DEFAULT NULL,
	FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "punch_card_golf_courses" (
	"id" BIGSERIAL PRIMARY KEY,
	"punch_card_id" BIGINT NOT NULL,
	"golf_course_id" BIGINT NOT NULL,
	"is_redeemed" BOOLEAN DEFAULT false,
	"redeemed_date" TIMESTAMP,
	"discount_id" BIGINT NOT NULL,
	FOREIGN KEY ("punch_card_id") REFERENCES "punch_card"("id") ON DELETE CASCADE,
	FOREIGN KEY ("golf_course_id") REFERENCES "golf_courses"("id") ON DELETE CASCADE,
	FOREIGN KEY ("discount_id") REFERENCES "discounts"("id") ON DELETE CASCADE,
	UNIQUE ("punch_card_id", "golf_course_id") -- Ensure unique pairings
);

-- Indexes for frequently queried fields
CREATE INDEX IF NOT EXISTS idx_user_email ON "user" ("email");
CREATE INDEX IF NOT EXISTS idx_golf_courses_name ON "golf_courses" ("name");
CREATE INDEX IF NOT EXISTS idx_punch_card_user_id ON "punch_card" ("user_id");
