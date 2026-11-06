# Звіт про промпт: лабораторна «Взаємодія (діаграми послідовності)»

## Модель і середовище

| Параметр | Значення |
| --- | --- |
| Модель | Claude Sonnet 5.5 |
| Інтерфейс | Claude Code (хмарна сесія), один безперервний чат |
| Дата роботи | 05.11.2026 – 06.11.2026 |
| Інструменти | читання зовнішніх посилань (WebFetch), клон репозиторію (git), Mermaid CLI (`mmdc`) для перевірки синтаксису і рендеру |

## Вхідні матеріали та шаблони

| Матеріал | Призначення | Посилання |
| --- | --- | --- |
| spec.md (Завдання 1, модель даних Rent-a-Gig) | Джерело сутностей, зв'язків і кардинальностей для звірки учасників | <https://raw.githubusercontent.com/therealsunfl0wer/SMRA-labs/refs/heads/main/1-entity-relationship/spec.md> |
| Репозиторій лабораторних | Завдання 2 (use-cases.md, scenarios.feature), місце розміщення артефактів | <https://github.com/therealsunfl0wer/SMRA-labs> |
| Шаблон специфікації (GitHub Spec Kit) | Структура `spec.md` | <https://raw.githubusercontent.com/github/spec-kit/refs/heads/main/templates/spec-template.md> |
| Гайд з EARS (8-habit-ai-dev) | Формулювання вимог у `requirements.md` | <https://raw.githubusercontent.com/pitimon/8-habit-ai-dev/refs/heads/main/guides/ears-notation.md> |

## Вхідний промпт

```text
Ти допомагаєш зробити лабораторну з Моделювання та Аналізу Вимог ПЗ
Візьми:
- Модель даних із Завдання 1 (spec.md, домен Rent-a-Gig):
  https://raw.githubusercontent.com/therealsunfl0wer/SMRA-labs/refs/heads/main/1-entity-relationship/spec.md
- Репозиторій: https://github.com/therealsunfl0wer/SMRA-labs
- Шаблон специфікації:
  https://raw.githubusercontent.com/github/spec-kit/refs/heads/main/templates/spec-template.md
- Гайд з EARS:
  https://raw.githubusercontent.com/pitimon/8-habit-ai-dev/refs/heads/main/guides/ears-notation.md

Правила:
- Не створюй файли: кожен документ видавай окремим блоком коду.
- Усі артефакти пиши англійською
- Діаграма в Mermaid: код видай у блоці plaintext (без рендеру), а в spec.md діаграм і Gherkin, тощо не вставляй.
-  Sequence-діаграма для кожного сценарію, детально; у кожній — щонайменше один фрагмент alt/opt/loop; реалістичні назви дій (submitOrder(), validateUser()).
- Activation bar учасника, що працює поза фрагментом або в кількох гілках, починається до і закінчується після умовного фрагмента — не обривається в одній гілці.
- Аудит після виконання основних інструкцій: учасники відповідають сутностям/сервісам ER-моделі (Завдання 1); кроки збігаються зі сценаріями Gherkin (Завдання 2); топ-3 розбіжності.

Артефакт: sequence-діаграма на КОЖЕН сценарій обраного UC — актори, компоненти/об'єкти, повідомлення й return-повідомлення, activation bars, комбіновані фрагменти (opt/alt/loop/par), аудит в загальному форматі ADR.

Ознаки відмінного виконання: кожен сценарій має свою діаграму; учасники узгоджені з ER-моделлю; є альтернативні/циклічні/паралельні гілки; activation bars коректні; назви викликів реалістичні.

Якщо є запитання / неточності / прогалини в вхідних даних, допускаються уточнювальні питання та пропозиції варіантів, вичерпно.
```

## Уточнювальні промпти

```text
Також забув уточнити що додавання файлу або ітерація над ним має містити за собою комміт.

1. Обраний UC є найлогічнішим для вибору, варто його лишити.
2. Додаткові діаграми не потрібні, сценарії лише Gherkin, все правильно.
3. Має сенс додати Event.capacity, але ітерування попередніх матеріалів вимагатиме коміту, в директорію теперішньої лабораторної, в наявному форматі історії.
4. Шари мають бути узгоджені з ER, якщо вони не належать до неї напряму. Якщо шар виступає сутністю яка має безпосередній зв'язок та тримає дані, варто розглянути створення ADR та зміни ER.
5. spec.md не потрібно робити з нуля, лише модифікувати якщо це облегшить будову артефактів, позначаючи зміни відповідно.
6. Цю частину недогледів я особисто, варто тримати повідомлення як і через Email, так і сайт, а UC не посилається на Email Service, результат: ще один ADR + ітерація.
7. Так, можеш скласти звіт на промпт, не бачу причини цього не робити.
```

## Результат уточнень

| Пункт | Що змінилося | Коміт |
| --- | --- | --- |
| 3 | `Event.capacity` у ER, ADR 3 | `ai: add Event.capacity to the data model` |
| 3 | Мінімальна кардинальність Event–Signup змінена на нуль | `ai: fix Event-Signup minimum cardinality to zero` |
| 4, 6 | Сутність `Notification` (email і site), ADR 4 | `ai: add Notification entity to the data model` |
| 6 | UC-MUS-001 включає UC-SYS-003 і UC-SYS-001, UC-SYS-003 перейменовано | `ai: include notifications and capacity in the use cases` |
| 6 | EARS-IF-002, EARS-EV-008, кроки Gherkin (сценарії 1 і 3) | `ai: align requirements and scenarios with capacity and notifications` |
| 5 | Позначені зміни у spec.md Завдання 2 | `ai: mark lab 3 changes in the Task 2 spec` |
| 6 | Трасування й аудит Завдання 2 | `ai: update traceability matrix and audit after the model changes` |
| 1, 2 | Три діаграми для сценаріїв 3, 4, 11 і їх рендер | `ai: add sequence diagrams for UC-MUS-001`, `ai: render sequence diagrams` |
| 1 | Аудит у форматі ADR | `ai: add the sequence diagram audit ADR` |

## Перевірка

- Усі діаграми відрендерено через `mmdc`.
- Скриптом перевірено, що кожен activation bar або повністю лежить в одній гілці фрагмента, або охоплює весь фрагмент.
- `useCase.png` не перерендерено: PlantUML недоступний у середовищі, оновлено лише `useCase.puml`.
