-- Recorded trainings
CREATE TABLE IF NOT EXISTS trainings (
                                         training_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                         athlete_id UUID NOT NULL REFERENCES athletes(athlete_id),
                                         training_plan_id UUID NOT NULL REFERENCES training_plans(training_plan_id),
                                         date DATE,
                                         time_spent TIME,
                                         average_speed FLOAT,
                                         max_speed FLOAT,
                                         distance FLOAT
);

CREATE TABLE IF NOT EXISTS completed_exercises (
                                                   completed_exercise_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                   training_id UUID NOT NULL REFERENCES trainings(training_id),
                                                   exercise_id UUID NOT NULL REFERENCES exercises(exercise_id),
                                                   notes VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS completed_sets (
                                              completed_set_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                              completed_exercise_id UUID NOT NULL REFERENCES completed_exercises(completed_exercise_id),
                                              set_number INT,
                                              repetitions INT,
                                              weight FLOAT,
                                              duration TIME
);

CREATE TABLE IF NOT EXISTS notifications (
                                             notification_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                             user_id UUID NOT NULL REFERENCES users(user_id),
                                             message VARCHAR(255),
                                             date DATE
);

CREATE TABLE IF NOT EXISTS group_chats (
                                           group_chat_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                           name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS group_chat_members (
                                                  member_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                  group_chat_id UUID NOT NULL REFERENCES group_chats(group_chat_id),
                                                  user_id UUID NOT NULL REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS messages (
                                        message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                        sender_id UUID NOT NULL REFERENCES users(user_id),
                                        receiver_id UUID NOT NULL REFERENCES users(user_id),
                                        text VARCHAR(255),
                                        date DATE,
                                        group_chat_id UUID REFERENCES group_chats(group_chat_id)
);

CREATE TABLE IF NOT EXISTS competitions (
                                            competition_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                            organizer_id UUID NOT NULL REFERENCES organizers(organizer_id),
                                            name VARCHAR(255),
                                            date DATE,
                                            location VARCHAR(255),
                                            participation_criteria VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS schedules (
                                         schedule_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                         competition_id UUID NOT NULL REFERENCES competitions(competition_id),
                                         event_description VARCHAR(255),
                                         start_time TIMESTAMP,
                                         end_time TIMESTAMP
);

CREATE TABLE IF NOT EXISTS competition_applications (
                                                        application_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                        athlete_id UUID NOT NULL REFERENCES athletes(athlete_id),
                                                        competition_id UUID NOT NULL REFERENCES competitions(competition_id),
                                                        status VARCHAR(255),
                                                        submission_date DATE
);

CREATE TABLE IF NOT EXISTS competition_results (
                                                   result_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                   athlete_id UUID NOT NULL REFERENCES athletes(athlete_id),
                                                   competition_id UUID NOT NULL REFERENCES competitions(competition_id),
                                                   result VARCHAR(255),
                                                   rating INT
);

CREATE TABLE IF NOT EXISTS materials (
                                         material_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                         name VARCHAR(255),
                                         type VARCHAR(255),
                                         content VARCHAR(255),
                                         publication_date DATE
);

CREATE TABLE IF NOT EXISTS material_comments (
                                                 comment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                 material_id UUID NOT NULL REFERENCES materials(material_id),
                                                 user_id UUID NOT NULL REFERENCES users(user_id),
                                                 text VARCHAR(255),
                                                 date DATE
);

CREATE TABLE IF NOT EXISTS favorites (
                                         favorite_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                         user_id UUID NOT NULL REFERENCES users(user_id),
                                         material_id UUID NOT NULL REFERENCES materials(material_id)
);
