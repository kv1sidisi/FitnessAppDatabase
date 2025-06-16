
CREATE INDEX IF NOT EXISTS idx_trainings_athlete_id_date ON trainings (athlete_id, date DESC);

CREATE INDEX IF NOT EXISTS idx_trainings_training_plan_id ON trainings (training_plan_id);

CREATE INDEX IF NOT EXISTS idx_training_plans_coach_id ON training_plans (coach_id);

CREATE INDEX IF NOT EXISTS idx_coaches_user_id ON coaches (user_id);

CREATE INDEX IF NOT EXISTS idx_users_user_id ON users (user_id);

CREATE INDEX IF NOT EXISTS idx_athlete_rating_athlete_id_update_date ON athlete_rating (athlete_id, update_date DESC);

CREATE INDEX IF NOT EXISTS idx_medical_indicators_athlete_id_measurement_date ON medical_indicators (athlete_id, measurement_date DESC);

CREATE INDEX IF NOT EXISTS idx_coach_certifications_coach_id ON coach_certifications (coach_id);

CREATE INDEX IF NOT EXISTS idx_competitions_organizer_id ON competitions (organizer_id);

CREATE INDEX IF NOT EXISTS idx_competition_applications_competition_id_athlete_id ON competition_applications (competition_id, athlete_id);

CREATE INDEX IF NOT EXISTS idx_athletes_user_id ON athletes (user_id);

CREATE INDEX IF NOT EXISTS idx_devices_athlete_id ON devices (athlete_id);

CREATE INDEX IF NOT EXISTS idx_device_data_device_id_timestamp ON device_data (device_id, timestamp DESC);

CREATE INDEX IF NOT EXISTS idx_organizers_organizer_id ON organizers (organizer_id);
