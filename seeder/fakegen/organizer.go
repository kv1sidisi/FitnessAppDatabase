package fakegen

import (
	"context"
	"fmt"
	"github.com/go-faker/faker/v4"
	"github.com/jackc/pgtype"
	"github.com/jackc/pgx/v4"
)

func SeedOrganizers(ctx context.Context, conn *pgx.Conn, userIDs []pgtype.UUID) ([]pgtype.UUID, error) {
	organizerIDs := make([]pgtype.UUID, 0, len(userIDs))
	for _, userID := range userIDs {
		orgName := generateCompanyName()
		licenseNum := faker.IPv6()
		var id pgtype.UUID
		err := conn.QueryRow(context.Background(),
			`INSERT INTO organizers (user_id, organization, license_number)
			 VALUES ($1, $2, $3)
			 RETURNING organizer_id`,
			userID, orgName, licenseNum,
		).Scan(&id)
		if err != nil {
			fmt.Println("Ошибка вставки:", err)
			continue
		}

		organizerIDs = append(organizerIDs, id)
	}
	return organizerIDs, nil
}
