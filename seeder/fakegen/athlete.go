package fakegen

import (
	"context"
	"fmt"
	"github.com/go-faker/faker/v4"
	"github.com/jackc/pgtype"
	"github.com/jackc/pgx/v4"
	"github.com/mroth/weightedrand/v2"
	"log"
	"math/rand"
)

func randomSportCategory() string {
	chooser, err := weightedrand.NewChooser(
		weightedrand.NewChoice("Бокс", 5),
		weightedrand.NewChoice("Плавание", 10),
		weightedrand.NewChoice("Лёгкая атлетика", 15),
		weightedrand.NewChoice("Тяжёлая атлетика", 8),
		weightedrand.NewChoice("Фехтование", 1),
		weightedrand.NewChoice("Дзюдо", 2),
		weightedrand.NewChoice("Гимнастика", 1),
		weightedrand.NewChoice("Биатлон", 2),
		weightedrand.NewChoice("Баскетбол", 5),
		weightedrand.NewChoice("Пауэрлифтинг", 10),
	)
	if err != nil {
		log.Fatalf("Ошибка при создании выборщика: %v", err)
	}
	return chooser.Pick()
}

func randomInsuranceCompany() string {
	chooser, err := weightedrand.NewChooser(
		weightedrand.NewChoice("Росгосстрах", 10),
		weightedrand.NewChoice("Ингосстрах", 8),
		weightedrand.NewChoice("СОГАЗ", 6),
		weightedrand.NewChoice("АльфаСтрахование", 5),
		weightedrand.NewChoice("РЕСО-Гарантия", 3),
	)
	if err != nil {
		log.Fatalf("Ошибка при создании выборщика: %v", err)
	}
	return chooser.Pick()
}

func randomRank() string {
	chooser, err := weightedrand.NewChooser(
		weightedrand.NewChoice("3 разряд", 15),
		weightedrand.NewChoice("2 разряд", 12),
		weightedrand.NewChoice("1 разряд", 10),
		weightedrand.NewChoice("КМС", 7),
		weightedrand.NewChoice("МС", 5),
		weightedrand.NewChoice("МСМК", 3),
		weightedrand.NewChoice("Элита", 1),
	)
	if err != nil {
		log.Fatalf("Ошибка при создании выборщика: %v", err)
	}
	return chooser.Pick()
}

func randomMedicalClearance() bool {
	if rand.Intn(2) == 0 {
		return true
	}
	return false
}

type nameComponent struct {
	value  string
	weight int
}

func weightedChoice(components []nameComponent) string {
	totalWeight := 0
	for _, c := range components {
		totalWeight += c.weight
	}
	r := rand.Intn(totalWeight)
	for _, c := range components {
		if r < c.weight {
			return c.value
		}
		r -= c.weight
	}
	return components[len(components)-1].value
}

// TODO: поменять названия всего что есть на нормальные
func generateCompanyName() string {
	prefixes := []nameComponent{
		{"Техно", 5},
		{"Инфо", 3},
		{"Глобал", 2},
		{"Эко", 4},
		{"Альфа", 1},
	}

	roots := []nameComponent{
		{"Систем", 5},
		{"Сервис", 4},
		{"Трейд", 3},
		{"Лаб", 2},
		{"Софт", 5},
	}

	suffixes := []nameComponent{
		{"Групп", 3},
		{"Солюшнс", 2},
		{"Инк", 1},
		{"Лтд", 2},
		{"", 5}, // Пустой суффикс
	}

	prefix := weightedChoice(prefixes)
	root := weightedChoice(roots)
	suffix := weightedChoice(suffixes)

	return prefix + root + suffix
}

func SeedAthletes(ctx context.Context, conn *pgx.Conn, userIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	athleteIDs := make([]pgtype.UUID, 0, len(userIDs))
	for _, userID := range userIDs {
		sport_category := randomSportCategory()
		club := generateCompanyName()
		coach := faker.Name()
		medical_clearance := randomMedicalClearance()
		insurance := randomInsuranceCompany()
		rank := randomRank()

		var id pgtype.UUID
		err := conn.QueryRow(context.Background(),
			`INSERT INTO athletes (user_id, sport_category, club, coach, medical_clearance, insurance, rank)
			VALUES ($1, $2, $3, $4, $5, $6, $7)
			RETURNING athlete_id`,
			userID, sport_category, club, coach, medical_clearance, insurance, rank,
		).Scan(&id)

		if err != nil {
			fmt.Println("Ошибка вставки:", err)
			continue
		}

		athleteIDs = append(athleteIDs, id)
	}
	return athleteIDs, nil
}
