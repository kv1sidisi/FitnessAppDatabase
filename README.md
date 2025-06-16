# Функциональные требования

## Управление профилем

- **Регистрация и аутентификация**
  - Система должна позволять создавать профили спортсменов с указанием личных данных (ФИО, возраст, контакты, пол, гражданство, спортивная категория, клуб, тренер, медицинский допуск, страховка, разряд).
  - Поддержка ролей: спортсмен, тренер, организатор соревнований.
- **Хранение данных**
  - Возможность загрузки медицинских показателей (пульс, артериальное давление, уровень кислорода в крови, вариабельность сердечного ритма, уровень глюкозы, вес, индекс массы тела, состав тела, уровень гидратации,  ЧСС в покое и при нагрузке, показатели ЭКГ).
  - Интеграция с часами, фитнес-трекерами и другими датчиками (GPS, акселерометры, пульсометры, датчики температуры, датчики ЭКГ, анализаторы состава тела, глюкометры, анализаторы пота, датчики уровня стресса).
  - Хранение истории травм и реабилитационных программ.

## Планирование и контроль тренировок

- **Создание тренировочных программ**
  - Тренер может разрабатывать тренировочные планы (цели, упражнения, интенсивность, периодичность, пульсовые зоны, тренировочные макро- и микроциклы).
  - Автоматическая генерация рекомендаций по нагрузке на основе медицинских показателей.
- **Мониторинг выполнения**
  - Отображение прогресса в реальном времени (выполненные задания, затраченное время, КПШ, средняя скорость, максимальная скорость, дистанция, количество повторений, пульсовые зоны).
  - Уведомления о пропущенных тренировках или отклонениях от плана.
  - Анализ данных с фитнес-трекеров и автоматическая корректировка нагрузок.

## Аналитика и отчетность

- **Визуализация данных**
  - Графики и диаграммы для анализа физических показателей.
  - Сравнение текущих результатов с прошлыми данными и целевыми показателями.
  - Формирование отчетов по тренировочному процессу и медицинским данным.
- **Прогнозирование**
  - Формирование рекомендаций по коррекции нагрузок на основе анализа прогресса.
  - Автоматическое предупреждение о возможном перетренированности.

## Управление соревнованиями

- **Календарь событий**
  - Автоматическое добавление соревнований с интеграцией внешних источников (например, сайтов федераций).
  - Напоминания о сроках регистрации, подготовке к стартам.
- **Анализ выступлений**
  - Запись и анализ результатов соревнований.
  - Сравнение с результатами других участников.
  - Вычисление рейтинга спортсмена.
- **Регистрация на соревнования**
  - Проверка соответствия критериям участия.
  - Оплата участия через платформу.
  - Уведомления о статусе заявки.
- **Управление заявками**
  - Просмотр, подтверждение или отклонение заявок организатором.
  - Формирование стартовых протоколов.

## Спортсмен

### Описание

Спортсмен – это пользователь, который участвует в тренировочном процессе, соревнованиях и ведет учет своих достижений. Он получает рекомендации от тренера, следит за своим физическим состоянием и анализирует прогресс.

### Функциональные требования

- **Управление профилем**
  - Заполнение и редактирование личных данных.
  - Добавление информации о тренере, клубе, спортивной категории.
  - Ведение списка достигнутых разрядов и наград.
  - Интеграция с системой допинг-контроля (при необходимости).
- **Планирование тренировок**
  - Получение индивидуального тренировочного плана от тренера.
  - Просмотр расписания тренировок и соревнований.
  - Заполнение отчетов о выполненных тренировках.
  - Получение уведомлений о корректировках программы.
- **Мониторинг состояния**
  - Ведение и анализ медицинских показателей.
  - Получение уведомлений о критических изменениях состояния.
  - Автоматический анализ риска травм.

## Тренер

### Описание

Тренер – это пользователь, который отвечает за разработку и контроль тренировочного процесса спортсменов. Он следит за их физической формой, корректирует планы подготовки и анализирует прогресс.

### Функциональные требования

- **Создание и управление тренировочными программами**
  - Разработка индивидуальных и командных тренировочных планов.
  - Коррекция программ на основе результатов анализов и обратной связи.
- **Контроль выполнения тренировок**
  - Отслеживание результатов в реальном времени.
  - Анализ данных с фитнес-трекеров и датчиков.
- **Коммуникация с командой**
  - Обмен сообщениями с спортсменами.
  - Проведение видеоконференций и консультаций.

## Организатор

### Описание

Организатор соревнований – это пользователь, который отвечает за проведение спортивных мероприятий, регистрацию участников, управление заявками и обработку результатов.

### Функциональные требования

- **Создание соревнований**
  - Формирование описания мероприятия, условий участия, расписания.
  - Автоматическая публикация в календаре событий.
- **Управление заявками**
  - Прием и обработка заявок от спортсменов.
  - Подтверждение или отклонение регистрации.
- **Анализ результатов соревнований**
  - Занесение данных о выступлениях спортсменов.
  - Автоматический подсчет рейтингов и статистики.


Медицинская поддержка
-
* Медкарта
    * Ведение истории здоровья 
* Управление восстановлением
    * Рекомендации по реабилитации после травм.
    * Корректировка тренировок при выявлении отклонений в показателях здоровья.

Коммуникация
-
* Внутренний чат
    * Обмен сообщениями
    * Групповые чаты команд
* Уведомления
    * Push-уведомления о предстоящих событиях, изменениях в расписании

Библиотека материалов
-
* Платформа должна содержать раздел с обучающими статьями, видео-лекциями, вебинарами и тренинговыми программами по подготовке спортсменов.
* Пользователи должны иметь возможность просматривать, комментировать и сохранять материалы в избранное.


```plantuml
entity "User" {
* user_id : uuid
--
full_name : varchar(255)
phone_number : varchar(255)
gender : enum('man', 'woman')
birth_date : date
citizenship : varchar(255)
}

entity "UserCredentials" {
* user_credentials_id : uuid
--
* user_id : uuid <<FK>>
login : varchar(255)
email : varchar(255)
password_hash : varchar(255)
}

entity "Athlete" {
* athlete_id : uuid
--
* user_id : uuid <<FK>>
sport_category : varchar(255)
club : varchar(255)
coach : varchar(255)
medical_clearance : boolean
insurance : varchar(255)
rank : varchar(255)
}

entity "Coach" {
* coach_id : uuid
--
* user_id : uuid <<FK>>
experience_years : int
affiliated_club : varchar(255)
}

entity CoachCertification {
*certification_id : uuid
--
*coach_id : uuid <<FK>>
name : varchar(255)
}

entity "Organizer" {
* organizer_id : uuid
--
* user_id : uuid <<FK>>
organization : varchar(255)
license_number : varchar(255)
}




entity "MedicalIndicators" {
* id : uuid
--
* athlete_id : uuid <<FK>>
pulse : int
blood_pressure : varchar(255)
oxygen_level : int
heart_rate_variability : varchar(255)
glucose_level : int
weight : float
body_mass_index : float
body_composition : varchar(255)
hydration_level : varchar(255)
resting_heart_rate : int
exercise_heart_rate : int
ecg_data : varchar(255)
measurement_date : date
}

entity AthleteRating {
*id : uuid
--
*athlete_id : uuid <<FK>>
rating : int
update_date : date
}

entity "Injury" {
* id : uuid
--
* athlete_id : uuid <<FK>>
description : varchar(255)
injury_date : date
recovery_date : date
}

entity "RehabilitationProgram" {
* id : uuid
--
* injury_id : uuid <<FK>>
description : varchar(255)
start_date : date
end_date : date
}

entity "Device" {
* device_id : uuid
--
* user_id : uuid <<FK>>
name : varchar(255)
type : enum('watch', 'tracker', 'sensor', 'other')
model : varchar(255)
serial_number : varchar(255)
last_sync : datetime
}

entity "DeviceData" {
* data_id : uuid
--
device_id : uuid
timestamp : datetime
metric_type : enum('heart_rate', 'blood_pressure', 'oxygen', 'temperature', 'gps', 'ecg', 'glucose', 'hydration', 'cortisol', 'stress', 'body_composition')
value : float
unit : varchar(50)
}




entity TrainingPlan {
*training_plan_id : uuid
--
*coach_id : uuid <<FK>>
name : varchar(255)
goals : varchar(255)
intensity : varchar(255)
}

entity MacroCycle {
*macro_cycle_id : uuid
--
*training_plan_id : uuid <<FK>>
description : varchar(255)
}

entity MicroCycle {
*micro_cycle_id : uuid
--
*training_plan_id : uuid <<FK>>
description : varchar(255)
}

entity Exercise {
*exercise_id : uuid
--
*training_plan_id : uuid <<FK>>
description : varchar(255)
}

entity PulseZone {
*zone_id : uuid
--
*training_plan_id : uuid <<FK>>
min : int
max : int
}

entity Training {
*training_id : uuid
--
*athlete_id : uuid <<FK>>
*training_plan_id : uuid <<FK>>
date : date
time_spent : time
average_speed : float
max_speed : float
distance : float
}

entity CompletedExercise {
*completed_exercise_id : uuid
--
*training_id : uuid <<FK>>
*exercise_id : uuid <<FK>>
notes : varchar(255)
}

entity CompletedSet {
  *completed_set_id : uuid
  --
  *completed_exercise_id : uuid <<FK>>
  set_number : int
  repetitions : int
  weight : float
  duration : time
}




entity Notification {
*id : uuid
--
*user_profile_id : uuid <<FK>>
message : varchar
date : date
}

entity Message {
*message_id : uuid
--
*sender_id : uuid <<FK>>
*receiver_id : uuid <<FK>>
text : varchar
date : date
}

entity GroupChat {
*id : uuid
--
name : varchar(255)
*message_id : uuid <<FK>>
}

entity GroupChatMember {
*id : uuid
--
*group_chat_id : uuid <<FK>>
*user_profile_id : uuid <<FK>>
}




entity Competition {
*id : uuid
--
*organizer_id : int <<FK>>
name : varchar(255)
date : date
location : varchar(255)
participation_criteria : varchar(255)
}

entity Schedule {
*schedule_id : uuid
--
*competition_id : uuid <<FK>>
event_description : varchar(255)
start_time : datetime
end_time : datetime
}

entity CompetitionApplication {
*application_id : uuid
--
*athlete_id : uuid <<FK>>
*competition_id : uuid <<FK>>
status : varchar(255)
submission_date : date
}

entity CompetitionResult {
*result_id : uuid
--
*athlete_id : uuid <<FK>>
*competition_id : uuid <<FK>>
result : varchar(255)
rating : int
}



entity Material {
*id : int
--
name : varchar(255)
type : varchar(255)
content : varchar(255)
publication_date : date
}

entity MaterialComment {
*id : uuid
--
*material_id : uuid <<FK>>
*user_profile_id : uuid <<FK>>
text : varchar(255)
date : date
}

entity Favorite {
*id : uuid
--
*user_profile_id : uuid <<FK>>
*material_id : uuid <<FK>>
}

User ||--|| UserCredentials : has
User ||--|| Athlete : has
User ||--|| Coach : has
Coach ||--o{ CoachCertification : has
User ||--|| Organizer : has

Athlete ||--|| MedicalIndicators : has
Athlete ||--o{ Injury : has
Athlete ||--o{ Training : has
Athlete ||--o{ Device : has
Athlete ||--o{ AthleteRating : has
Athlete ||--o{ CompetitionApplication : submits
Athlete ||--o{ CompetitionResult : has
Device ||--o{ DeviceData : has

Injury ||--o{ RehabilitationProgram : contains

TrainingPlan ||--o{ Exercise : has
TrainingPlan ||--o{ PulseZone : has
TrainingPlan ||--o{ MacroCycle : has
TrainingPlan ||--o{ MicroCycle : has
Training ||--o{ CompletedExercise : includes
Exercise ||--o{ CompletedExercise : part_of
CompletedExercise ||--o{ CompletedSet : contains

Coach ||--o{ TrainingPlan : creates
TrainingPlan ||--o{ Training : used_in

User ||--o{ Notification : receives
User ||--o{ Message : sends/receives
User ||--o{ GroupChatMember : participates
GroupChat ||--o{ GroupChatMember : has
GroupChat ||--o{ Message : has

Organizer ||--o{ Competition : creates
Competition ||--o{ CompetitionApplication : has
Competition ||--o{ Schedule : has
Competition ||--o{ CompetitionResult : has

Material ||--o{ MaterialComment : has
Material ||--o{ Favorite : is_added_to
User ||--o{ MaterialComment : writes
User ||--o{ Favorite : adds

```

### 1. User
Primary key: user_id  
Функциональная зависимость:  
user_id → full_name, phone_number, gender, age, citizenship

Все неключевые атрибуты зависят только от первичного ключа.

---

### 2. UserCredentials
Primary key: user_credentials_id  
Функциональная зависимость:  
user_credentials_id → user_id, login, email, password_hash

Все неключевые атрибуты зависят только от первичного ключа.

---

### 3. Athlete

Primary key: athlete_id  
Функциональная зависимость:  
athlete_id → user_id, sport_category, club, coach, medical_clearance, insurance, rank

Все неключевые атрибуты зависят только от первичного ключа.

---

### 4. Coach

Primary key: coach_id  
Функциональная зависимость:  
coach_id → user_id, experience_years, affiliated_club

Все неключевые атрибуты зависят только от первичного ключа.

---

### 5. CoachCertification

Primary key: certification_id  
Функциональная зависимость:  
certification_id → coach_id, name

Все неключевые атрибуты зависят только от первичного ключа.

---

### 6. Organizer

Primary key: organizer_id  
Функциональная зависимость:  
organizer_id → user_id, organization, license_number

Все неключевые атрибуты зависят только от первичного ключа.

---

### 7. MedicalIndicators

Primary key: id  
Функциональная зависимость:  
id → athlete_id, pulse, blood_pressure, oxygen_level, heart_rate_variability, glucose_level, weight, body_mass_index, body_composition, hydration_level, resting_heart_rate, exercise_heart_rate, ecg_data, measurement_date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 8. AthleteRating

Primary key: id  
Функциональная зависимость:  
id → athlete_id, rating, update_date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 9. Injury

Primary key: id  
Функциональная зависимость:  
id → athlete_id, description, injury_date, recovery_date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 10. RehabilitationProgram

Primary key: id  
Функциональная зависимость:  
id → athlete_id, description, start_date, end_date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 11. Device

Primary key: device_id  
Функциональная зависимость:  
device_id → user_id, name, type, model, serial_number, last_sync

Все неключевые атрибуты зависят только от первичного ключа.

---

### 12. DeviceData

Primary key: data_id  
Функциональная зависимость:  
data_id → device_id, timestamp, metric_type, value, unit

Все неключевые атрибуты зависят только от первичного ключа.

---

### 13. TrainingPlan

Primary key: training_plan_id  
Функциональная зависимость:  
training_plan_id → coach_id, name, goals, intensity, frequency

Все неключевые атрибуты зависят только от первичного ключа.

---

### 14. MacroCycle

Primary key: macro_cycle_id  
Функциональная зависимость:  
macro_cycle_id → training_plan_id, description

Все неключевые атрибуты зависят только от первичного ключа.

---

### 15. MicroCycle

Primary key: micro_cycle_id  
Функциональная зависимость:  
micro_cycle_id → training_plan_id, description

Все неключевые атрибуты зависят только от первичного ключа.

---

### 16. Exercise

Primary key: exercise_id  
Функциональная зависимость:  
exercise_id → training_plan_id, description

Все неключевые атрибуты зависят только от первичного ключа.

---

### 17. PulseZone

Primary key: zone_id  
Функциональная зависимость:  
zone_id → training_plan_id, min, max

Все неключевые атрибуты зависят только от первичного ключа.

---

### 18. Training

Primary key: training_id  
Функциональная зависимость:  
training_id → athlete_id, training_plan_id, date, time_spent, average_speed, max_speed, distance

Все неключевые атрибуты зависят только от первичного ключа.

---

### 19. CompletedExercise

Primary key: completed_exercise_id  
Функциональная зависимость:  
completed_exercise_id → training_id, exercise_id, repetitions, sets, weight, duration, notes

Все неключевые атрибуты зависят только от первичного ключа.

---

### 20. Notification

Primary key: id  
Функциональная зависимость:  
id → user_profile_id, message, date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 21. Message

Primary key: message_id  
Функциональная зависимость:  
message_id → sender_id, receiver_id, text, date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 22. GroupChat

Primary key: id  
Функциональная зависимость:  
id → name

Все неключевые атрибуты зависят только от первичного ключа.

---

### 23. GroupChatMember

Primary key: id  
Функциональная зависимость:  
id → group_chat_id, user_profile_id

Все неключевые атрибуты зависят только от первичного ключа.

---

### 24. Competition

Primary key: id  
Функциональная зависимость:  
id → organizer_id, name, date, location, participation_criteria, schedule

Все неключевые атрибуты зависят только от первичного ключа.

---

### 25. Schedule

Primary key: schedule_id  
Функциональная зависимость:  
schedule_id → competition_id, event_description, start_time, end_time

Все неключевые атрибуты зависят только от первичного ключа.

---

### 26. CompetitionApplication

Primary key: application_id  
Функциональная зависимость:  
application_id → athlete_id, competition_id, status, submission_date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 27. CompetitionResult

Primary key: result_id  
Функциональная зависимость:  
result_id → athlete_id, competition_id, result, rating

Все неключевые атрибуты зависят только от первичного ключа.

---

### 28. Material

Primary key: id  
Функциональная зависимость:  
id → name, type, content, publication_date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 29. MaterialComment
Primary key: id  
Функциональная зависимость:  
id → material_id, user_profile_id, text, date

Все неключевые атрибуты зависят только от первичного ключа.

---

### 30. Favorite

Primary key: id  
Функциональная зависимость:  
id → user_profile_id, material_id

Все неключевые атрибуты зависят только от первичного ключа.