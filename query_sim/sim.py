import logging
import os
import random
import time
from psycopg2 import connect, OperationalError, InterfaceError

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

DB_CONFIG = {
    'host': os.environ.get('DB_HOST', 'postgresdb'),
    'port': os.environ.get('DB_PORT', '5432'),
    'database': os.environ.get('POSTGRES_DB', 'sportsdb'),
    'user': os.environ.get('POSTGRES_USER', 'sportuser'),
    'password': os.environ.get('POSTGRES_PASSWORD', 'root')
}

class SportsQuerySimulator:
    def __init__(self):
        self.connection = None
        self.connect()

    def connect(self):
        max_retries = 10
        retry_delay = 5

        if self.connection:
            try:
                self.connection.close()
            except Exception:
                pass
            self.connection = None

        for attempt in range(max_retries):
            try:
                self.connection = connect(**DB_CONFIG)
                self.connection.autocommit = False
                logger.info("Connected to sports DB successfully")
                return True
            except (OperationalError, InterfaceError) as e:
                logger.warning(f"Connection attempt {attempt + 1}/{max_retries} failed: {e}")
                time.sleep(retry_delay)
        logger.error("Could not connect to sports DB after retries")
        return False

    def ensure_connection(self):
        if not self.connection:
            return self.connect()
        try:
            cur = self.connection.cursor()
            cur.execute("SELECT 1")
            cur.close()
            return True
        except (OperationalError, InterfaceError, AttributeError):
            logger.warning("Connection lost, reconnecting...")
            return self.connect()

    def execute_query(self, query, params=None):
        max_retries = 3
        retry_delay = 2

        for attempt in range(max_retries):
            try:
                if not self.ensure_connection():
                    logger.error(f"Failed to ensure connection on attempt {attempt + 1}")
                    time.sleep(retry_delay)
                    continue
                cur = self.connection.cursor()
                start_time = time.time()
                cur.execute(query, params)
                result = cur.fetchall() if cur.description else None
                self.connection.commit()
                exec_time = time.time() - start_time
                cur.close()
                logger.info(f"Query executed in {exec_time:.3f}s, rows: {len(result) if result else 0}")
                return result, exec_time
            except (OperationalError, InterfaceError) as e:
                logger.error(f"DB error on attempt {attempt + 1}: {e}")
                try:
                    self.connection.rollback()
                except Exception:
                    pass
                self.connection = None
                time.sleep(retry_delay)
            except Exception as e:
                logger.error(f"Unexpected error: {e}")
                try:
                    self.connection.rollback()
                except Exception:
                    pass
                return None, 0
        return None, 0

    def get_random_ids(self):
        default_ids = {
            'athlete_id': None,
            'coach_id': None,
            'training_plan_id': None,
            'competition_id': None
        }
        if not self.ensure_connection():
            return default_ids
        try:
            cur = self.connection.cursor()
            ids = {}
            for table, col in [('athletes', 'athlete_id'), ('coaches', 'coach_id'),
                               ('training_plans', 'training_plan_id'), ('competitions', 'competition_id')]:
                cur.execute(f"SELECT {col} FROM {table} ORDER BY RANDOM() LIMIT 1")
                res = cur.fetchone()
                ids[col] = res[0] if res else None
            cur.close()
            return ids
        except Exception as e:
            logger.error(f"Error getting random IDs: {e}")
            return default_ids

    def simulate_queries(self):
        logger.info("Starting sports domain query simulation...")
        time.sleep(5)

        while True:
            try:
                ids = self.get_random_ids()

                queries = [
                    ("""
                    SELECT t.training_id, t.date, t.distance, t.average_speed, tp.name as plan_name, c.user_id as coach_user_id, u.full_name as coach_name
                    FROM trainings t
                    JOIN training_plans tp ON t.training_plan_id = tp.training_plan_id
                    JOIN coaches c ON tp.coach_id = c.coach_id
                    JOIN users u ON c.user_id = u.user_id
                    WHERE t.athlete_id = %s
                    ORDER BY t.date DESC
                    LIMIT 5
                    """, [ids['athlete_id']]),

                    ("""
                    SELECT a.athlete_id, u.full_name, ar.rating, mi.pulse, mi.blood_pressure, mi.oxygen_level
                    FROM athletes a
                    JOIN users u ON a.user_id = u.user_id
                    LEFT JOIN athlete_rating ar ON a.athlete_id = ar.athlete_id
                    LEFT JOIN medical_indicators mi ON a.athlete_id = mi.athlete_id
                    WHERE ar.update_date = (SELECT MAX(update_date) FROM athlete_rating WHERE athlete_id = a.athlete_id)
                      AND mi.measurement_date = (SELECT MAX(measurement_date) FROM medical_indicators WHERE athlete_id = a.athlete_id)
                    ORDER BY ar.rating DESC NULLS LAST
                    LIMIT 10
                    """, None),

                    ("""
                    SELECT c.coach_id, u.full_name, cert.name as certification_name
                    FROM coaches c
                    JOIN users u ON c.user_id = u.user_id
                    LEFT JOIN coach_certifications cert ON c.coach_id = cert.coach_id
                    WHERE c.coach_id = %s
                    """, [ids['coach_id']]),

                    ("""
                    SELECT comp.competition_id, comp.name, comp.date, o.organization, oa.status, u.full_name as athlete_name
                    FROM competitions comp
                    JOIN organizers o ON comp.organizer_id = o.organizer_id
                    LEFT JOIN competition_applications oa ON comp.competition_id = oa.competition_id
                    LEFT JOIN athletes a ON oa.athlete_id = a.athlete_id
                    LEFT JOIN users u ON a.user_id = u.user_id
                    WHERE comp.competition_id = %s
                    """, [ids['competition_id']]),

                    ("""
                    SELECT d.device_id, d.name, d.type, dd.metric_type, dd.value, dd.timestamp
                    FROM devices d
                    LEFT JOIN device_data dd ON d.device_id = dd.device_id
                    WHERE d.athlete_id = %s
                    ORDER BY dd.timestamp DESC NULLS LAST
                    LIMIT 10
                    """, [ids['athlete_id']])
                ]

                query, params = random.choice(queries)
                result, exec_time = self.execute_query(query, params)

                if result is None:
                    logger.warning("Query failed or returned no results")
                else:
                    logger.info(f"Fetched {len(result)} rows")

                time.sleep(random.uniform(1, 5))

            except KeyboardInterrupt:
                logger.info("Simulation stopped by user")
                break
            except Exception as e:
                logger.error(f"Unexpected error in simulation loop: {e}")
                time.sleep(5)


if __name__ == "__main__":
    simulator = SportsQuerySimulator()
    simulator.simulate_queries()
