package fakegen

import (
	"context"
	"fmt"
	"github.com/go-faker/faker/v4"
	"github.com/jackc/pgtype"
	"github.com/jackc/pgx/v4"
	"math/rand"
	"strconv"
	"time"
)

type MedicalIndicator struct {
	Pulse                int
	BloodPressure        string
	OxygenLevel          int
	HeartRateVariability string
	GlucoseLevel         int
	Weight               float64
	BodyMassIndex        float64
	BodyComposition      string
	HydrationLevel       string
	RestingHeartRate     int
	ExerciseHeartRate    int
	ECGData              string
	MeasurementDate      time.Time
}

func init() {
	rand.Seed(time.Now().UnixNano())
}

func randomBloodPressure() string {
	sys := rand.Intn(21) + 100
	dia := rand.Intn(21) + 60
	return fmt.Sprintf("%d/%d", sys, dia)
}

func randomHeartRateVariability() string {
	res := rand.Intn(41) + 60
	return strconv.Itoa(res)
}

func randomBodyComposition() string {
	sportsFat := map[string][2]int{
		"DistanceRunning": {5, 11},
		"Swimming":        {9, 12},
		"Basketball":      {6, 12},
		"Gymnastics":      {5, 12},
		"Soccer":          {10, 18},
	}
	keys := []string{"DistanceRunning", "Swimming", "Basketball", "Gymnastics", "Soccer"}
	sp := keys[rand.Intn(len(keys))]
	r := sportsFat[sp]
	pct := rand.Intn(r[1]-r[0]+1) + r[0]
	return fmt.Sprintf("%s: %d%%", sp, pct)
}

func randomHydrationLevel() string {
	levels := []string{"Hypohydrated", "Euhydrated", "Hyperhydrated"}
	weights := []int{2, 10, 1}
	total := 0
	for _, w := range weights {
		total += w
	}
	r := rand.Intn(total)
	for i, w := range weights {
		if r < w {
			return levels[i]
		}
		r -= w
	}
	return levels[1]
}

func randomMeasurementDate() time.Time {
	now := time.Now()
	past := now.AddDate(0, -1, 0)
	delta := now.Sub(past)
	return past.Add(time.Duration(rand.Int63n(int64(delta))))
}

func generateFakeIndicator() MedicalIndicator {
	weight := rand.Float64()*30 + 60
	height := rand.Float64()*0.4 + 1.6
	bmi := weight / (height * height)
	return MedicalIndicator{
		Pulse:                rand.Intn(21) + 40,
		BloodPressure:        randomBloodPressure(),
		OxygenLevel:          rand.Intn(4) + 97,
		HeartRateVariability: randomHeartRateVariability(),
		GlucoseLevel:         rand.Intn(41) + 70,
		Weight:               weight,
		BodyMassIndex:        bmi,
		BodyComposition:      randomBodyComposition(),
		HydrationLevel:       randomHydrationLevel(),
		RestingHeartRate:     rand.Intn(31) + 30,
		ExerciseHeartRate:    rand.Intn(81) + 120,
		ECGData:              faker.Sentence(),
		MeasurementDate:      randomMeasurementDate(),
	}
}

func SeedMedicalIndicators(ctx context.Context, conn *pgx.Conn, athleteIDs []pgtype.UUID) error {
	for _, athleteID := range athleteIDs {
		mi := generateFakeIndicator()

		_, err := conn.Exec(ctx,
			`INSERT INTO medical_indicators (
        athlete_id, pulse, blood_pressure, oxygen_level,
        heart_rate_variability, glucose_level, weight, body_mass_index,
        body_composition, hydration_level, resting_heart_rate,
        exercise_heart_rate, ecg_data, measurement_date
    ) VALUES (
        $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)`,
			athleteID, mi.Pulse, mi.BloodPressure, mi.OxygenLevel,
			mi.HeartRateVariability, mi.GlucoseLevel, mi.Weight, mi.BodyMassIndex,
			mi.BodyComposition, mi.HydrationLevel, mi.RestingHeartRate,
			mi.ExerciseHeartRate, mi.ECGData, mi.MeasurementDate,
		)
		if err != nil {
			return err
		}
	}
	return nil
}
