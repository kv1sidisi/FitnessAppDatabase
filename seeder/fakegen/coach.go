package fakegen

import (
	"context"
	"fmt"
	"github.com/jackc/pgtype"
	"github.com/jackc/pgx/v4"
	"math/rand"
)

func SeedCoaches(ctx context.Context, conn *pgx.Conn, userIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	coachIDs := make([]pgtype.UUID, 0, len(userIDs))
	for _, userID := range userIDs {
		experience_years := rand.Intn(50) + 1
		affiliated_club := generateCompanyName()

		var id pgtype.UUID
		err := conn.QueryRow(context.Background(),
			`INSERT INTO coaches (user_id, experience_years, affiliated_club)
    		VALUES ($1, $2, $3)
    		RETURNING coach_id`,
			userID, experience_years, affiliated_club,
		).Scan(&id)

		if err != nil {
			fmt.Println("Ошибка вставки:", err)
			continue
		}
		coachIDs = append(coachIDs, id)
	}
	return coachIDs, nil
}
