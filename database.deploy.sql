CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS "user" (
	"id" uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
	"email" text NOT NULL UNIQUE,
	"password" text NOT NULL,
	"name" text NOT NULL,
	"phone_number" bigint NOT NULL,
	"address" text NOT NULL,
	"birthdate" date,
	"created_at" timestamp with time zone NOT NULL DEFAULT current_timestamp,
	"admin" boolean NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "discounts" (
	"id" uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
	"name" text NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "restrictions" (
	"id" uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
	"name" text NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "golf_courses" (
	"id" uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
	"name" text NOT NULL,
	"phone_number" bigint,
	"isActive" boolean NOT NULL DEFAULT true,
	"created_at" timestamp with time zone NOT NULL DEFAULT current_timestamp,
	"street" text NOT NULL,
	"city" text NOT NULL,
	"state" text NOT NULL,
	"zip_code" bigint NOT NULL,
	"longitude" text NOT NULL,
	"latitude" text NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "golf_courses_discounts" (
	"id" uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
	"golf_courses_id" uuid NOT NULL,
	"discounts_id" uuid NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("golf_courses_id") REFERENCES "golf_courses"("id"),
	FOREIGN KEY ("discounts_id") REFERENCES "discounts"("id")
);

CREATE TABLE IF NOT EXISTS "golf_courses_restrictions" (
	"id" uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
	"golf_courses_id" uuid NOT NULL,
	"restrictions_id" uuid NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("golf_courses_id") REFERENCES "golf_courses"("id"),
	FOREIGN KEY ("restrictions_id") REFERENCES "restrictions"("id")
);

CREATE TABLE IF NOT EXISTS "punch_card" (
	"id" uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
	"users_id" uuid NOT NULL,
	"isPurchased" boolean NOT NULL DEFAULT false,
	"purchased_date" timestamp with time zone DEFAULT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("users_id") REFERENCES "user"("id")
);

CREATE TABLE IF NOT EXISTS "punch_card_golf_courses" (
	"id" uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
	"punch_card_id" uuid NOT NULL,
	"golf_courses_id" uuid NOT NULL,
	"isRedeemed" boolean DEFAULT false,
	"redeemed_date" timestamp with time zone,
	"discount_id" uuid NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("punch_card_id") REFERENCES "punch_card"("id"),
	FOREIGN KEY ("golf_courses_id") REFERENCES "golf_courses"("id"),
	FOREIGN KEY ("discount_id") REFERENCES "discounts"("id")
);
