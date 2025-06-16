CREATE TABLE IF NOT EXISTS injuries (
                                        injury_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                        athlete_id UUID NOT NULL REFERENCES athletes(athlete_id),
                                        description VARCHAR(255),
                                        injury_date DATE,
                                        recovery_date DATE
);

CREATE TABLE IF NOT EXISTS rehabilitation_programs (
                                                       rehabilitation_program_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                       injury_id UUID NOT NULL REFERENCES injuries(injury_id),
                                                       description VARCHAR(255),
                                                       start_date DATE,
                                                       end_date DATE
);

CREATE TABLE IF NOT EXISTS devices (
                                       device_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                       athlete_id UUID NOT NULL REFERENCES athletes(athlete_id),
                                       name VARCHAR(255),
                                       type device_type_enum,
                                       model VARCHAR(255),
                                       serial_number VARCHAR(255),
                                       last_sync TIMESTAMP
);

CREATE TABLE IF NOT EXISTS device_data (
                                           data_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                           device_id UUID NOT NULL REFERENCES devices(device_id),
                                           timestamp TIMESTAMP,
                                           metric_type metric_type_enum,
                                           value FLOAT,
                                           unit VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS training_plans (
                                              training_plan_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                              coach_id UUID NOT NULL REFERENCES coaches(coach_id),
                                              name VARCHAR(255),
                                              goals VARCHAR(255),
                                              intensity VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS macro_cycles (
                                            macro_cycle_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                            training_plan_id UUID NOT NULL REFERENCES training_plans(training_plan_id),
                                            description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS micro_cycles (
                                            micro_cycle_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                            training_plan_id UUID NOT NULL REFERENCES training_plans(training_plan_id),
                                            description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS exercises (
                                         exercise_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                         training_plan_id UUID NOT NULL REFERENCES training_plans(training_plan_id),
                                         description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS pulse_zones (
                                           zone_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                           training_plan_id UUID NOT NULL REFERENCES training_plans(training_plan_id),
                                           min INT,
                                           max INT
);

CREATE TABLE IF NOT EXISTS medical_indicators (
                                                  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                  athlete_id UUID NOT NULL REFERENCES athletes(athlete_id),
                                                  pulse INT,
                                                  blood_pressure VARCHAR(255),
                                                  oxygen_level INT,
                                                  heart_rate_variability VARCHAR(255),
                                                  glucose_level INT,
                                                  weight FLOAT,
                                                  body_mass_index FLOAT,
                                                  body_composition VARCHAR(255),
                                                  hydration_level VARCHAR(255),
                                                  resting_heart_rate INT,
                                                  exercise_heart_rate INT,
                                                  ecg_data VARCHAR(255),
                                                  measurement_date DATE
);

CREATE TABLE IF NOT EXISTS athlete_rating (
                                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                              athlete_id UUID NOT NULL REFERENCES athletes(athlete_id),
                                              rating INT,
                                              update_date DATE
);
