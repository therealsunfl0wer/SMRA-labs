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
