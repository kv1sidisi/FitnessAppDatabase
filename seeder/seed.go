package main

import (
	"context"
	"fmt"
	"github.com/go-faker/faker/v4"
	"github.com/jackc/pgconn"
	"github.com/jackc/pgtype"
	"github.com/jackc/pgx/v4"
	"golang.org/x/crypto/bcrypt"
	"log"
	"math/rand"
	"os"
	"time"

	"gitlab.sqlwars.ru/dbd25/M3207_LyapunovVA/seed/fakegen"
)

func runIfTableExists[T any](ctx context.Context, conn *pgx.Conn, fn func() (T, error)) (T, error) {
	var zero T
	res, err := fn()
	if err == nil {
		return res, nil
	}
	if pgErr, ok := err.(*pgconn.PgError); ok && pgErr.Code == "42P01" {
		log.Printf("Таблица %q не найдена, пропускаем.", pgErr.TableName)
		return zero, nil
	}
	return zero, err
}

func main() {
	dbHost := os.Getenv("DB_HOST")
	dbPort := os.Getenv("DB_PORT")
	dbUser := os.Getenv("DB_USER")
	dbPassword := os.Getenv("DB_PASSWORD")
	dbName := os.Getenv("DB_NAME")

	connString := fmt.Sprintf("postgresql://%s:%s@%s:%s/%s", dbUser, dbPassword, dbHost, dbPort, dbName)
	log.Println(connString)
	ctx := context.Background()
	conn, err := pgx.Connect(ctx, connString)
	if err != nil {
		log.Fatalf("conn err: %v", err)
	}
	defer conn.Close(ctx)

	counts := GetNormalizedSeedCounts()

	userIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedUsers(ctx, conn, counts.Users)
	})
	if err != nil {
		log.Fatalf("seedUsers: %v", err)
	}

	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedUserCredentials(ctx, conn, userIDs)
	})
	if err != nil {
		log.Fatalf("seedUserCredentials: %v", err)
	}

	rand.Shuffle(len(userIDs), func(i, j int) { userIDs[i], userIDs[j] = userIDs[j], userIDs[i] })
	athleteUserIDs := userIDs[:counts.Athletes]
	coachUserIDs := userIDs[counts.Athletes : counts.Athletes+counts.Coaches]
	organizerUserIDs := userIDs[counts.Athletes+counts.Coaches:]

	athleteIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return fakegen.SeedAthletes(ctx, conn, athleteUserIDs)
	})
	if err != nil {
		log.Fatalf("SeedAthletes: %v", err)
	}

	coachIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return fakegen.SeedCoaches(ctx, conn, coachUserIDs)
	})
	if err != nil {
		log.Fatalf("SeedCoaches: %v", err)
	}

	organizerIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return fakegen.SeedOrganizers(ctx, conn, organizerUserIDs)
	})
	if err != nil {
		log.Fatalf("SeedOrganizers: %v", err)
	}

	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedAthleteRatings(ctx, conn, athleteIDs)
	})
	if err != nil {
		log.Fatalf("seedAthleteRatings: %v", err)
	}

	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, fakegen.SeedMedicalIndicators(ctx, conn, athleteIDs)
	})
	if err != nil {
		log.Fatalf("SeedMedicalIndicators: %v", err)
	}

	injuryIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedInjuries(ctx, conn, athleteIDs)
	})
	if err != nil {
		log.Fatalf("seedInjuries: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedRehabilitationPrograms(ctx, conn, injuryIDs)
	})
	if err != nil {
		log.Fatalf("seedRehabilitationPrograms: %v", err)
	}

	deviceIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedDevices(ctx, conn, athleteIDs)
	})
	if err != nil {
		log.Fatalf("seedDevices: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedDeviceData(ctx, conn, deviceIDs)
	})
	if err != nil {
		log.Fatalf("seedDeviceData: %v", err)
	}

	trainingPlanIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedTrainingPlans(ctx, conn, coachIDs)
	})
	if err != nil {
		log.Fatalf("seedTrainingPlans: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedMacroCycles(ctx, conn, trainingPlanIDs)
	})
	if err != nil {
		log.Fatalf("SeedMacroCycles: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedMicroCycles(ctx, conn, trainingPlanIDs)
	})
	if err != nil {
		log.Fatalf("SeedMicroCycles: %v", err)
	}
	exerciseIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedExercises(ctx, conn, trainingPlanIDs)
	})
	if err != nil {
		log.Fatalf("seedExercises: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedPulseZones(ctx, conn, trainingPlanIDs)
	})
	if err != nil {
		log.Fatalf("seedPulseZones: %v", err)
	}
	trainingIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedTrainings(ctx, conn, athleteIDs, trainingPlanIDs)
	})
	if err != nil {
		log.Fatalf("seedTrainings: %v", err)
	}
	completedExerciseIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedCompletedExercises(ctx, conn, trainingIDs, exerciseIDs)
	})
	if err != nil {
		log.Fatalf("seedCompletedExercises: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedCompletedSets(ctx, conn, completedExerciseIDs)
	})
	if err != nil {
		log.Fatalf("seedCompletedSets: %v", err)
	}

	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedNotifications(ctx, conn, userIDs)
	})
	if err != nil {
		log.Fatalf("seedNotifications: %v", err)
	}

	groupChatIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedGroupChats(ctx, conn, userIDs)
	})
	if err != nil {
		log.Fatalf("seedGroupChats: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedGroupChatMembers(ctx, conn, groupChatIDs, userIDs)
	})
	if err != nil {
		log.Fatalf("seedGroupChatMembers: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedMessages(ctx, conn, groupChatIDs, userIDs)
	})
	if err != nil {
		log.Fatalf("seedMessages: %v", err)
	}

	competitionIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedCompetitions(ctx, conn, organizerIDs)
	})
	if err != nil {
		log.Fatalf("seedCompetitions: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedSchedules(ctx, conn, competitionIDs)
	})
	if err != nil {
		log.Fatalf("seedSchedules: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedCompetitionApplications(ctx, conn, competitionIDs, athleteIDs)
	})
	if err != nil {
		log.Fatalf("seedCompetitionApplications: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedCompetitionResults(ctx, conn, competitionIDs, athleteIDs)
	})
	if err != nil {
		log.Fatalf("seedCompetitionResults: %v", err)
	}

	materialIDs, err := runIfTableExists(ctx, conn, func() ([]pgtype.UUID, error) {
		return seedMaterials(ctx, conn, userIDs)
	})
	if err != nil {
		log.Fatalf("seedMaterials: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedMaterialComments(ctx, conn, materialIDs, userIDs)
	})
	if err != nil {
		log.Fatalf("seedMaterialComments: %v", err)
	}
	_, err = runIfTableExists(ctx, conn, func() (struct{}, error) {
		return struct{}{}, seedFavorites(ctx, conn, userIDs, materialIDs)
	})
	if err != nil {
		log.Fatalf("seedFavorites: %v", err)
	}

	fmt.Println("Seeding success.")
}
func seedUsers(ctx context.Context, conn *pgx.Conn, count int) ([]pgtype.UUID, error) {
	userIDs := make([]pgtype.UUID, 0, count)
	for i := 0; i < count; i++ {
		firstName := faker.FirstName()
		lastName := faker.LastName()
		fullName := firstName + " " + lastName
		phoneNumber := faker.Phonenumber()

		gender := "man"
		if rand.Intn(2) == 0 {
			gender = "woman"
		}
		birthYear := time.Now().Year() - rand.Intn(42) - 18
		birthDate := fmt.Sprintf("%d-%02d-%02d", birthYear, rand.Intn(12)+1, rand.Intn(28)+1)
		citizenship := "Russia"

		var id pgtype.UUID
		err := conn.QueryRow(context.Background(),
			`INSERT INTO users (full_name, phone_number, gender, birth_date, citizenship)
			 VALUES ($1, $2, $3, $4, $5)
			 RETURNING user_id`,
			fullName, phoneNumber, gender, birthDate, citizenship,
		).Scan(&id)
		if err != nil {
			fmt.Println("Ошибка вставки:", err)
			continue
		}

		userIDs = append(userIDs, id)
	}
	return userIDs, nil
}

func seedUserCredentials(ctx context.Context, conn *pgx.Conn, userIDs []pgtype.UUID) error {
	for _, userID := range userIDs {
		login := faker.Username()
		email := faker.Email()
		password := faker.Password()
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)

		_, err = conn.Exec(ctx,
			`INSERT INTO user_credentials (user_id, login, email, password_hash)
             VALUES ($1, $2, $3, $4)`,
			userID, login, email, string(hashedPassword),
		)
		if err != nil {
			return err
		}
	}
	return nil
}

func seedAthleteRatings(ctx context.Context, conn *pgx.Conn, athleteIDs []pgtype.UUID) error {
	for _, athleteID := range athleteIDs {
		rating := rand.Intn(30) + 1
		year := time.Now().Year() - rand.Intn(10)
		date := fmt.Sprintf("%d-%02d-%02d", year, rand.Intn(12)+1, rand.Intn(28)+1)

		_, err := conn.Exec(ctx,
			`INSERT INTO athlete_rating (athlete_id, rating, update_date)
             VALUES ($1, $2, $3)`,
			athleteID, rating, date,
		)
		if err != nil {
			return err
		}
	}
	return nil
}

func seedInjuries(ctx context.Context, conn *pgx.Conn, athleteIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	injuryIDs := make([]pgtype.UUID, 0, len(athleteIDs))
	injuryNames := []string{"Sprained Ankle", "Knee Injury", "Back Pain", "Fracture", "Concussion"}
	for _, athleteID := range athleteIDs {
		if rand.Intn(2) == 0 {
			continue
		}
		description := injuryNames[rand.Intn(len(injuryNames))]

		injYear := time.Now().Year() - rand.Intn(20)
		injDate := fmt.Sprintf("%d-%02d-%02d", injYear, rand.Intn(12)+1, rand.Intn(28)+1)

		recDate := fmt.Sprintf("%d-%02d-%02d", injYear+rand.Intn(3), rand.Intn(12)+1, rand.Intn(28)+1)

		var id pgtype.UUID
		err := conn.QueryRow(context.Background(),
			`INSERT INTO injuries (athlete_id, description, injury_date, recovery_date)
             VALUES ($1, $2, $3, $4)
             RETURNING injury_id`,
			athleteID, description, injDate, recDate,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: Injuries:", err)
			continue
		}
		injuryIDs = append(injuryIDs, id)
	}
	return injuryIDs, nil
}

func seedRehabilitationPrograms(ctx context.Context, conn *pgx.Conn, injuryIDs []pgtype.UUID) error {
	for _, injuryID := range injuryIDs {
		description := "Rehab for " + faker.Word()
		stYear := time.Now().Year() - rand.Intn(20)
		stDate := fmt.Sprintf("%d-%02d-%02d", stYear, rand.Intn(12)+1, rand.Intn(28)+1)
		endDate := fmt.Sprintf("%d-%02d-%02d", stYear+rand.Intn(3), rand.Intn(12)+1, rand.Intn(28)+1)

		_, err := conn.Exec(ctx,
			`INSERT INTO rehabilitation_programs (injury_id, description, start_date, end_date)
             VALUES ($1, $2, $3, $4)`,
			injuryID, description, stDate, endDate,
		)
		if err != nil {
			return fmt.Errorf("Insert error: RehabilitationPrograms: %w", err)
		}

	}
	return nil
}

func seedDevices(ctx context.Context, conn *pgx.Conn, athleteIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	deviceIDs := make([]pgtype.UUID, 0, len(athleteIDs))
	deviceTypes := []string{"watch", "tracker", "sensor", "other"}
	for _, athleteID := range athleteIDs {
		numDevices := rand.Intn(3) + 1
		for i := 0; i < numDevices; i++ {
			name := fmt.Sprintf("%s %d", deviceTypes[rand.Intn(len(deviceTypes))], rand.Intn(1000))
			devType := deviceTypes[rand.Intn(len(deviceTypes))]
			model := faker.Username()
			serialNum := faker.IPv6()
			lastSync := time.Now().Add(-time.Duration(rand.Intn(8760)) * time.Hour)
			var id pgtype.UUID
			err := conn.QueryRow(context.Background(),
				`INSERT INTO devices (athlete_id, name, type, model, serial_number, last_sync)
                 VALUES ($1, $2, $3, $4, $5, $6)
                 RETURNING device_id`,
				athleteID, name, devType, model, serialNum, lastSync,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error::", err)
				continue
			}
			deviceIDs = append(deviceIDs, id)
		}
	}
	return deviceIDs, nil
}

func seedDeviceData(ctx context.Context, conn *pgx.Conn, deviceIDs []pgtype.UUID) error {
	metricConfig := []struct {
		Type string
		Unit string
		Min  float64
		Max  float64
	}{
		{"heart_rate", "bpm", 60, 100},
		{"blood_pressure", "mmHg", 90, 140},
		{"oxygen", "%", 95, 100},
		{"temperature", "°C", 36.0, 37.5},
		{"gps", "degrees", -90, 90},
		{"ecg", "mV", -0.5, 5.0},
		{"glucose", "mg/dL", 70, 140},
		{"hydration", "%", 50, 100},
		{"cortisol", "nmol/L", 5, 25},
		{"stress", "level", 0, 10},
		{"body_composition", "%", 10, 40},
	}

	for _, deviceID := range deviceIDs {
		var exists bool
		err := conn.QueryRow(ctx,
			`SELECT EXISTS(SELECT 1 FROM devices WHERE device_id = $1)`,
			deviceID,
		).Scan(&exists)

		if err != nil || !exists {
			continue
		}

		numRecords := rand.Intn(5) + 1
		for i := 0; i < numRecords; i++ {
			cfg := metricConfig[rand.Intn(len(metricConfig))]

			value := cfg.Min + rand.Float64()*(cfg.Max-cfg.Min)
			timestamp := time.Now().Add(-time.Duration(rand.Intn(8760)) * time.Hour)

			_, err := conn.Exec(ctx,
				`INSERT INTO device_data 
                    (device_id, timestamp, metric_type, value, unit)
                 VALUES ($1, $2, $3, $4, $5)`,
				deviceID, timestamp, cfg.Type, value, cfg.Unit,
			)

			if err != nil {
				return fmt.Errorf("Insert error:: %w", err)
			}
		}
	}
	return nil
}

func seedTrainingPlans(ctx context.Context, conn *pgx.Conn, coachIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	planIDs := make([]pgtype.UUID, 0)
	for _, coachID := range coachIDs {
		name := "Plan " + faker.Word()
		goals := "Goal" + faker.Word()
		intensity := "Intens " + faker.Word()

		var id pgtype.UUID
		err := conn.QueryRow(context.Background(),
			`INSERT INTO training_plans (coach_id, name, goals, intensity)
             VALUES ($1, $2, $3, $4)
             RETURNING training_plan_id`,
			coachID, name, goals, intensity,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: Training Plans:", err)
			continue
		}
		planIDs = append(planIDs, id)
	}
	return planIDs, nil
}

func seedMacroCycles(ctx context.Context, conn *pgx.Conn, trainingPlanIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	macroCycleIDs := make([]pgtype.UUID, 0)
	for _, planID := range trainingPlanIDs {
		description := "MacroCycle " + faker.Word()
		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO macro_cycles (training_plan_id, description)
			 VALUES ($1, $2)
			 RETURNING macro_cycle_id`,
			planID, description,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: MacroCycle:", err)
			continue
		}
		macroCycleIDs = append(macroCycleIDs, id)
	}
	return macroCycleIDs, nil
}

func seedMicroCycles(ctx context.Context, conn *pgx.Conn, trainingPlanIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	microCycleIDs := make([]pgtype.UUID, 0)
	for _, planID := range trainingPlanIDs {
		description := "MicroCycle " + faker.Word()
		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO micro_cycles (training_plan_id, description)
			 VALUES ($1, $2)
			 RETURNING micro_cycle_id`,
			planID, description,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: MicroCycle:", err)
			continue
		}
		microCycleIDs = append(microCycleIDs, id)
	}
	return microCycleIDs, nil
}

func seedExercises(ctx context.Context, conn *pgx.Conn, trainingPlanIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	exerciseIDs := make([]pgtype.UUID, 0)
	for _, planID := range trainingPlanIDs {
		description := "Exercise " + faker.Word()
		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO exercises (training_plan_id, description)
			 VALUES ($1, $2)
			 RETURNING exercise_id`,
			planID, description,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: Exercise:", err)
			continue
		}
		exerciseIDs = append(exerciseIDs, id)
	}
	return exerciseIDs, nil
}

func seedPulseZones(ctx context.Context, conn *pgx.Conn, trainingPlanIDs []pgtype.UUID) error {
	for _, planID := range trainingPlanIDs {
		minHR := rand.Intn(50) + 50
		maxHR := minHR + rand.Intn(40) + 10
		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO pulse_zones (training_plan_id, min, max)
			 VALUES ($1, $2, $3)
			 RETURNING zone_id`,
			planID, minHR, maxHR,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: PulseZone:", err)
			continue
		}
	}
	return nil
}

func seedTrainings(ctx context.Context, conn *pgx.Conn, athleteIDs, trainingPlanIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	trainingIDs := make([]pgtype.UUID, 0)
	for _, athleteID := range athleteIDs {
		if len(trainingPlanIDs) == 0 {
			return nil, fmt.Errorf("Ошибка вставки Trainings, trainingPlansIds(len) = 0")
		}
		planID := trainingPlanIDs[rand.Intn(len(trainingPlanIDs))]

		date := time.Now().AddDate(0, 0, -rand.Intn(30)).Format("2006-01-02")
		timeSpent := fmt.Sprintf("%02d:%02d:%02d", rand.Intn(2), rand.Intn(59), rand.Intn(59))
		avgSpeed := rand.Float64()*10 + 5
		maxSpeed := avgSpeed + rand.Float64()*5
		distance := rand.Float64()*10 + 1

		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO trainings (athlete_id, training_plan_id, date, time_spent, average_speed, max_speed, distance)
			 VALUES ($1, $2, $3, $4, $5, $6, $7)
			 RETURNING training_id`,
			athleteID, planID, date, timeSpent, avgSpeed, maxSpeed, distance,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: Training:", err)
			continue
		}
		trainingIDs = append(trainingIDs, id)
	}
	return trainingIDs, nil
}

func seedCompletedExercises(ctx context.Context, conn *pgx.Conn, trainingIDs, exerciseIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	completedExerciseIDs := make([]pgtype.UUID, 0)
	for _, trainingID := range trainingIDs {
		for i := 0; i < rand.Intn(3)+1; i++ {
			exerciseID := exerciseIDs[rand.Intn(len(exerciseIDs))]
			notes := faker.Sentence()

			var id pgtype.UUID
			err := conn.QueryRow(ctx,
				`INSERT INTO completed_exercises (training_id, exercise_id, notes)
				 VALUES ($1, $2, $3)
				 RETURNING completed_exercise_id`,
				trainingID, exerciseID, notes,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error: CompletedExercise:", err)
				continue
			}
			completedExerciseIDs = append(completedExerciseIDs, id)
		}
	}
	return completedExerciseIDs, nil
}

func seedCompletedSets(ctx context.Context, conn *pgx.Conn, completedExerciseIDs []pgtype.UUID) error {
	for _, compID := range completedExerciseIDs {
		for i := 1; i <= rand.Intn(3)+1; i++ {
			reps := rand.Intn(10) + 5
			weight := rand.Float64()*40 + 10
			duration := fmt.Sprintf("00:%02d:%02d", rand.Intn(5), rand.Intn(59))

			var id pgtype.UUID
			err := conn.QueryRow(ctx,
				`INSERT INTO completed_sets (completed_exercise_id, set_number, repetitions, weight, duration)
				 VALUES ($1, $2, $3, $4, $5)
				 RETURNING completed_set_id`,
				compID, i, reps, weight, duration,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error: CompletedSet:", err)
				continue
			}
		}
	}
	return nil
}

func seedNotifications(ctx context.Context, conn *pgx.Conn, userIDs []pgtype.UUID) error {
	for _, userID := range userIDs {
		message := "Уведомление: " + faker.Sentence()
		date := time.Now().AddDate(0, 0, -rand.Intn(10)).Format("2006-01-02")

		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO notifications (user_id, message, date)
			 VALUES ($1, $2, $3)
			 RETURNING notification_id`,
			userID, message, date,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: Notification:", err)
			continue
		}
	}
	return nil
}

func seedGroupChats(ctx context.Context, conn *pgx.Conn, userIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	groupIDs := make([]pgtype.UUID, 0)
	for i := 0; i < 5; i++ {
		name := "Group " + faker.Word()
		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO group_chats (name)
			 VALUES ($1)
			 RETURNING group_chat_id`,
			name,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error:GroupChat:", err)
			continue
		}
		groupIDs = append(groupIDs, id)
	}
	return groupIDs, nil
}

func seedGroupChatMembers(ctx context.Context, conn *pgx.Conn, groupIDs, userIDs []pgtype.UUID) error {
	for _, groupID := range groupIDs {
		for _, userID := range userIDs {
			if rand.Intn(3) == 0 {
				var id pgtype.UUID
				err := conn.QueryRow(ctx,
					`INSERT INTO group_chat_members (group_chat_id, user_id)
					 VALUES ($1, $2)
					 RETURNING member_id`,
					groupID, userID,
				).Scan(&id)
				if err != nil {
					fmt.Println("Insert error: GroupChatMember:", err)
					continue
				}
			}
		}
	}
	return nil
}

func seedMessages(ctx context.Context, conn *pgx.Conn, groupIDs, userIDs []pgtype.UUID) error {
	for _, groupID := range groupIDs {
		for i := 0; i < rand.Intn(5)+1; i++ {
			sender := userIDs[rand.Intn(len(userIDs))]
			receiver := userIDs[rand.Intn(len(userIDs))]
			text := faker.Sentence()
			date := time.Now().AddDate(0, 0, -rand.Intn(7)).Format("2006-01-02")

			var id pgtype.UUID
			err := conn.QueryRow(ctx,
				`INSERT INTO messages (sender_id, receiver_id, text, date, group_chat_id)
				 VALUES ($1, $2, $3, $4, $5)
				 RETURNING message_id`,
				sender, receiver, text, date, groupID,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error: Message:", err)
				continue
			}
		}
	}
	return nil
}

func seedCompetitions(ctx context.Context, conn *pgx.Conn, organizerIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	compIDs := make([]pgtype.UUID, 0)
	for _, organizer := range organizerIDs {
		name := "Соревнование " + faker.Word()
		date := time.Now().AddDate(0, rand.Intn(3), rand.Intn(28)).Format("2006-01-02")
		location := faker.Word()
		criteria := "Уровень допуска: " + faker.Word()

		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO "competitions" (organizer_id, name, date, location, participation_criteria)
             VALUES ($1, $2, $3, $4, $5)
             RETURNING competition_id`,
			organizer, name, date, location, criteria,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error:Competition:", err)
			continue
		}
		compIDs = append(compIDs, id)
	}
	return compIDs, nil
}

func seedSchedules(ctx context.Context, conn *pgx.Conn, competitionIDs []pgtype.UUID) error {
	for _, compID := range competitionIDs {
		for i := 0; i < rand.Intn(3)+1; i++ {
			description := "Этап " + faker.Word()
			start := time.Now().Add(time.Duration(rand.Intn(48)) * time.Hour)
			end := start.Add(time.Duration(rand.Intn(2)+1) * time.Hour)

			var id pgtype.UUID
			err := conn.QueryRow(ctx,
				`INSERT INTO schedules (competition_id, event_description, start_time, end_time)
				 VALUES ($1, $2, $3, $4)
				 RETURNING schedule_id`,
				compID, description, start, end,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error: Schedule:", err)
				continue
			}
		}
	}
	return nil
}

func seedCompetitionApplications(ctx context.Context, conn *pgx.Conn, competitionIDs, athleteIDs []pgtype.UUID) error {
	statuses := []string{"pending", "approved", "rejected"}
	for _, athleteID := range athleteIDs {
		if rand.Intn(2) == 0 {
			compID := competitionIDs[rand.Intn(len(competitionIDs))]
			status := statuses[rand.Intn(len(statuses))]
			date := time.Now().AddDate(0, 0, -rand.Intn(10)).Format("2006-01-02")

			var id pgtype.UUID
			err := conn.QueryRow(ctx,
				`INSERT INTO competition_applications (athlete_id, competition_id, status, submission_date)
				 VALUES ($1, $2, $3, $4)
				 RETURNING application_id`,
				athleteID, compID, status, date,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error: Application:", err)
				continue
			}
		}
	}
	return nil
}

func seedCompetitionResults(ctx context.Context, conn *pgx.Conn, competitionIDs, athleteIDs []pgtype.UUID) error {
	for _, athleteID := range athleteIDs {
		if rand.Intn(3) == 0 {
			compID := competitionIDs[rand.Intn(len(competitionIDs))]
			result := fmt.Sprintf("%d:%02d", rand.Intn(5), rand.Intn(60))
			rating := rand.Intn(100)

			var id pgtype.UUID
			err := conn.QueryRow(ctx,
				`INSERT INTO competition_results (athlete_id, competition_id, result, rating)
				 VALUES ($1, $2, $3, $4)
				 RETURNING result_id`,
				athleteID, compID, result, rating,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error: Result:", err)
				continue
			}
		}
	}
	return nil
}

func seedMaterials(ctx context.Context, conn *pgx.Conn, userIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	materialIDs := make([]pgtype.UUID, 0)
	for i := 0; i < 15; i++ {
		name := "Материал " + faker.Word()
		matType := "Тип " + faker.Word()
		content := faker.Sentence()
		pubDate := time.Now().AddDate(0, 0, -rand.Intn(20)).Format("2006-01-02")

		var id pgtype.UUID
		err := conn.QueryRow(ctx,
			`INSERT INTO materials (name, type, content, publication_date)
			 VALUES ($1, $2, $3, $4)
			 RETURNING material_id`,
			name, matType, content, pubDate,
		).Scan(&id)
		if err != nil {
			fmt.Println("Insert error: Material:", err)
			continue
		}
		materialIDs = append(materialIDs, id)
	}
	return materialIDs, nil
}

func seedMaterialComments(ctx context.Context, conn *pgx.Conn, materialIDs, userIDs []pgtype.UUID) error {
	for _, materialID := range materialIDs {
		for i := 0; i < rand.Intn(3)+1; i++ {
			userID := userIDs[rand.Intn(len(userIDs))]
			text := faker.Sentence()
			date := time.Now().AddDate(0, 0, -rand.Intn(15)).Format("2006-01-02")

			var id pgtype.UUID
			err := conn.QueryRow(ctx,
				`INSERT INTO material_comments (material_id, user_id, text, date)
				 VALUES ($1, $2, $3, $4)
				 RETURNING comment_id`,
				materialID, userID, text, date,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error: Comment:", err)
				continue
			}
		}
	}
	return nil
}

func seedFavorites(ctx context.Context, conn *pgx.Conn, userIDs, materialIDs []pgtype.UUID) error {
	for _, userID := range userIDs {
		for i := 0; i < rand.Intn(3); i++ {
			matID := materialIDs[rand.Intn(len(materialIDs))]

			var id pgtype.UUID
			err := conn.QueryRow(ctx,
				`INSERT INTO favorites (user_id, material_id)
				 VALUES ($1, $2)
				 RETURNING favorite_id`,
				userID, matID,
			).Scan(&id)
			if err != nil {
				fmt.Println("Insert error: Favorite:", err)
				continue
			}
		}
	}
	return nil
}
