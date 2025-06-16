package main

import (
	"fmt"
	"os"
	"strconv"
)

func GetSeedCount() int {
	value := os.Getenv("SEED_COUNT")
	if value == "" {
		return 20
	}

	count, err := strconv.Atoi(value)
	if err != nil || count < 1 {
		fmt.Println("Invalid SEED_COUNT, fallback to default 10000")
		return 20
	}
	return count
}

func NormalizeCounts(total int, weights map[string]float64) map[string]int {
	result := make(map[string]int)
	var totalWeight float64
	for _, w := range weights {
		totalWeight += w
	}

	sum := 0
	var lastKey string
	for k, w := range weights {
		count := int(float64(total) * (w / totalWeight))
		result[k] = count
		sum += count
		lastKey = k
	}

	result[lastKey] += total - sum
	return result
}

type NormalizedSeedCounts struct {
	Users      int
	Athletes   int
	Coaches    int
	Organizers int
}

func GetNormalizedSeedCounts() NormalizedSeedCounts {
	seedCount := GetSeedCount()
	roleWeights := map[string]float64{
		"athlete":   4,
		"coach":     1,
		"organizer": 1,
	}

	normalized := NormalizeCounts(seedCount, roleWeights)

	return NormalizedSeedCounts{
		Users:      seedCount,
		Athletes:   normalized["athlete"],
		Coaches:    normalized["coach"],
		Organizers: normalized["organizer"],
	}
}
