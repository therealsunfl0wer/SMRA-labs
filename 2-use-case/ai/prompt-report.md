# Звіт про промпт: лабораторна «Вимоги, сценарії використання і трасування»

## Модель і середовище

| Параметр | Значення |
| --- | --- |
| Модель | Mistral Medium 3.5 |
| Інтерфейс | chat.mistral.ai/code, один безперервний чат |
| Дата роботи | 21.10.2026 |
| Інструменти | читання зовнішніх посилань (WebFetch) |

## Вхідні матеріали та шаблони

| Матеріал | Призначення | Посилання |
| --- | --- | --- |
| spec.md (Завдання 1, модель даних Rent-a-Gig) | Джерело сутностей, зв'язків і кардинальностей для звірки акторів і сутностей | <https://raw.githubusercontent.com/therealsunfl0wer/SMRA-labs/refs/heads/main/1-entity-relationship/spec.md> |
| Репозиторій лабораторних | Місце розміщення артефактів | <https://github.com/therealsunfl0wer/SMRA-labs> |
| Шаблон специфікації (GitHub Spec Kit) | Структура `spec.md` | <https://raw.githubusercontent.com/github/spec-kit/refs/heads/main/templates/spec-template.md> |
| Гайд з EARS (8-habit-ai-dev) | Формулювання вимог у `requirements.md` | <https://raw.githubusercontent.com/pitimon/8-habit-ai-dev/refs/heads/main/guides/ears-notation.md> |

## Вхідний промпт

```text
Ти допомагає зробити лабораторну з Моделювання та Аналізу Вимог ПЗ
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
- Діаграма в Mermaid: код видай у блоці plaintext (без рендеру), а в spec.md діаграм і Gherkin не вставляй.
- Актори й сутності мають збігатися з моделлю даних лабораторної 1

Артефакти:
- spec.md обсягом приблизно одна сторінка і лише власне специфікація, сфокусовані user stories з пріоритетами P1–P3 та edge cases.
- requirements.md за шаблоном EARS
- use-cases.md з каталогом акторів
- use-case-diagram.mmd 
- scenarios.feature в Gherkin
- traceability.md з матрицею
- audit.md: EARS на двозначність; include/extend; звірити акторів і сутності з моделлю даних (Завдання 1)

Ознаки відмінного виконання: вимоги в EARS однозначні й тестовані; трасування реально багато-до-багатьох; узгодженість з моделлю даних; є ≥1 непокрита вимога з поясненням.
```

## Уточнювальні промпти

```text
Уточнення, діаграма пишеться в форматі Mermaid Flowchart з еліпсами для UC, оскільки Mermaid не має окремого формату для UCD.
```

```text
Виправ use-cases.md, діаграму та audit.md в 2-use-case/ за такими пунктами.

1. Актори: Musician, Band Member (узагальнення Musician: Band Member is a Musician), Email Service і Streaming Platform (зовнішні системи). Прибери "Band" і "System Administrator" як акторів: Band у моделі є сутністю, а дії від імені гурту виконує Band Member.
2. Діаграма має містити ≥2 типи акторів, include, extend і узагальнення (актор → актор та UC → UC, напр. Search Bands → Filter by Genre / Filter by Instrument). Mermaid не має UCD-нотації, тому тип зв'язку передавай підписом на стрілці ("is a", «include», «extend»).
3. Виправ напрямок extend: Sign Up (UC-MUS-001) розширює View Event Details (UC-MUS-005), а не навпаки. Приведи use-cases.md, діаграму й audit.md до цього напрямку.
4. Внеси "Validate Input" у каталог use-cases.md як повноцінний UC або прибери його з діаграми; нехай діаграма й каталог мають однаковий набір UC. Додай нові UC із промпту 1.
5. У audit.md усунь посилання на неіснуючі UC-MUS-007/008 та нові ID, що конфліктують з наявними.
```

```text
Виправ use-cases.md, діаграму та audit.md

1. Актори: Musician, Band Member (узагальнення Musician: Band Member is a Musician), Email Service і Streaming Platform (зовнішні системи). Прибери "Band" і "System Administrator" як акторів: Band у моделі є сутністю, а дії від імені гурту виконує Band Member.
2. Діаграма має містити ≥2 типи акторів, include, extend і узагальнення (актор → актор та UC → UC, напр. Search Bands → Filter by Genre / Filter by Instrument). Mermaid не має UCD-нотації, тому тип зв'язку передавай підписом на стрілці ("is a", «include», «extend»).
3. Виправ напрямок extend: Sign Up (UC-MUS-001) розширює View Event Details (UC-MUS-005), а не навпаки. Приведи use-cases.md, діаграму й audit.md до цього напрямку.
4. Внеси "Validate Input" у каталог use-cases.md як повноцінний UC або прибери його з діаграми; нехай діаграма й каталог мають однаковий набір UC. Додай нові UC із промпту вище.
5. У audit.md усунь посилання на неіснуючі UC-MUS-007/008 та нові ID, що конфліктують з наявними.
```

```text
Перебудуй traceability.md та audit.md в 2-use-case/ з урахуванням вимог, UC і сценаріїв після попередніх комітів

1. Матриця "вимога ↔ UC ↔ сценарії ↔ сутності" має містити КОЖНУ вимогу з requirements.md (зараз 12 пропущено). Прибери стовпець "Status: Implemented"; використовуй лише "covered" або "uncovered". Виправ хибні зв'язки (напр. вимога про жанри → UC про інструменти, FR-005 → US-5).
2. Зв'язки мають бути реально багато-до-багатьох: одна вимога → кілька UC/сценаріїв і навпаки. Прибери односторонні списки "Many-to-Many" або заміни їх перетином з матриці.
3. Позначай непокриті вимоги і непокриті UC в одному розділі (зараз UC-BAND-002, UC-MUS-003, UC-MUS-005 без сценаріїв не позначені). Для кожного — причина. Перерахуй кількості сценаріїв за реальним станом scenarios.feature.
4. Приведи в audit.md той самий список непокритих і ту саму оцінку впливу, що в traceability.md.
5. Переписуй audit.md за фактами, без відсотків і без "100%": перевір EARS на двозначність (список знайдених слабких формулювань і що виправлено), include/extend/узагальнення, звірку акторів і сутностей з моделлю Завдання 1 (включно з атрибутами, яких має бути видно в spec.md). Додай розділ "Top-3 discrepancies" з розбіжностями між spec і артефактами.
```
