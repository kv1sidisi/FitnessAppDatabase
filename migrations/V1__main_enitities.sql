CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TYPE gender_type AS ENUM ('man', 'woman');
CREATE TYPE device_type_enum AS ENUM ('watch', 'tracker', 'sensor', 'other');
CREATE TYPE metric_type_enum AS ENUM (
    'heart_rate', 'blood_pressure', 'oxygen', 'temperature',
    'gps', 'ecg', 'glucose', 'hydration', 'cortisol',
    'stress', 'body_composition'
    );

CREATE TABLE IF NOT EXISTS users (
                                     user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                     full_name VARCHAR(255),
                                     phone_number VARCHAR(255),
                                     gender gender_type,
                                     birth_date DATE,
                                     citizenship VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS user_credentials (
                                                user_credentials_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                user_id UUID NOT NULL REFERENCES users(user_id),
                                                login VARCHAR(255),
                                                email VARCHAR(255),
                                                password_hash VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS athletes (
                                        athlete_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                        user_id UUID NOT NULL REFERENCES users(user_id),
                                        sport_category VARCHAR(255),
                                        club VARCHAR(255),
                                        coach VARCHAR(255),
                                        medical_clearance BOOLEAN,
                                        insurance VARCHAR(255),
                                        rank VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS coaches (
                                       coach_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                       user_id UUID NOT NULL REFERENCES users(user_id),
                                       experience_years INT,
                                       affiliated_club VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS organizers (
                                          organizer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                          user_id UUID NOT NULL REFERENCES users(user_id),
                                          organization VARCHAR(255),
                                          license_number VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS coach_certifications (
                                                    certification_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                    coach_id UUID NOT NULL REFERENCES coaches(coach_id),
                                                    name VARCHAR(255)
);
