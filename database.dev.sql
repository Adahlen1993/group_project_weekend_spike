CREATE TABLE IF NOT EXISTS "user" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"email" text NOT NULL UNIQUE,
	"password" text NOT NULL, -- Ensure this is hashed and salted
	"name" text NOT NULL,
	"phone_number" VARCHAR(20) NOT NULL, -- Changed to VARCHAR to accommodate different formats
	"address" text NOT NULL,
	"birthdate" date,
	"created_at" timestamp with time zone NOT NULL DEFAULT current_timestamp,
	"admin" boolean NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "discounts" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"name" text NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "restrictions" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"name" text NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "golf_courses" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"name" text NOT NULL,
	"phone_number" VARCHAR(20), -- Changed to VARCHAR to accommodate different formats
	"isActive" boolean NOT NULL DEFAULT true,
	"created_at" timestamp with time zone NOT NULL DEFAULT current_timestamp,
	"street" text NOT NULL,
	"city" text NOT NULL,
	"state" text NOT NULL,
	"zip_code" bigint NOT NULL,
	"latitude" decimal(9,6) NOT NULL, -- Defined precision and scale for latitude
	"longitude" decimal(9,6) NOT NULL, -- Defined precision and scale for longitude 
    "image_url" varchar,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "golf_courses_discounts" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"golf_courses_id" bigint NOT NULL,
	"discounts_id" bigint NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("golf_courses_id") REFERENCES "golf_courses"("id") ON DELETE CASCADE,
	FOREIGN KEY ("discounts_id") REFERENCES "discounts"("id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "golf_courses_restrictions" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"golf_courses_id" bigint NOT NULL,
	"restrictions_id" bigint NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("golf_courses_id") REFERENCES "golf_courses"("id") ON DELETE CASCADE,
	FOREIGN KEY ("restrictions_id") REFERENCES "restrictions"("id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "punch_card" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"users_id" bigint NOT NULL,
	"isPurchased" boolean NOT NULL DEFAULT false,
	"purchased_date" timestamp with time zone DEFAULT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("users_id") REFERENCES "user"("id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "punch_card_golf_courses" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"punch_card_id" bigint NOT NULL,
	"golf_courses_id" bigint NOT NULL,
	"isRedeemed" boolean DEFAULT false,
	"redeemed_date" timestamp with time zone,
	"discount_id" bigint NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("punch_card_id") REFERENCES "punch_card"("id") ON DELETE CASCADE,
	FOREIGN KEY ("golf_courses_id") REFERENCES "golf_courses"("id") ON DELETE CASCADE,
	FOREIGN KEY ("discount_id") REFERENCES "discounts"("id") ON DELETE CASCADE
);
