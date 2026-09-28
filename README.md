<div align="center">

# 🥉 Bronze Layer — Preliminary Science Marks

**Splits raw student marks into one table per grade (10 · 11 · 12)**

![Layer](https://img.shields.io/badge/layer-Bronze-cd7f32?style=for-the-badge)
![Language](https://img.shields.io/badge/SQL-T--SQL-blue?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Architecture](https://img.shields.io/badge/architecture-Medallion-gold?style=for-the-badge)
![Step](https://img.shields.io/badge/step-4%20of%20load-success?style=for-the-badge)

</div>

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Medallion Architecture](#-medallion-architecture)
- [ETL Pipeline](#-etl-pipeline)
- [Grade Routing](#-grade-routing)
- [Columns Loaded](#-columns-loaded)
- [Prerequisites](#-prerequisites)
- [How to Run](#-how-to-run)
- [Validation](#-validation)
- [Notes and Caveats](#-notes-and-caveats)
- [Roadmap](#-roadmap)

---

## 🔎 Overview

**Script:** `002_Insert_Broze_Tables.sql`

This script is **step 4** of the Bronze load. It copies rows from one source table into three grade-specific tables, using the `grade` column to decide where each row goes.

| 🎓 Grade | 🎯 Target table | 🔍 Filter |
|:-------:|-----------------|-----------|
| **10** | `Bronze.prelim_science_students_marks_grade10` | `grade LIKE '%10%'` |
| **11** | `Bronze.prelim_science_students_marks_grade11` | `grade LIKE '%11%'` |
| **12** | `Bronze.prelim_science_students_marks_grade12` | `grade LIKE '%12%'` |

📥 **Source table:** `Bronze.prelim_science_students_marks`

---

## 🏅 Medallion Architecture

The project follows the **medallion** pattern: data moves through progressively cleaner layers.

```mermaid
flowchart LR
    A[("📄 Raw Source<br/>CSV / files")]:::src --> B

    subgraph B["🥉 BRONZE — Raw"]
        direction TB
        B1[("prelim_science_<br/>students_marks")]
    end

    B --> C

    subgraph C["🥈 SILVER — Cleaned"]
        direction TB
        C1["Validate & type-cast"]
        C2["Deduplicate"]
    end

    C --> D

    subgraph D["🥇 GOLD — Business-ready"]
        direction TB
        D1["Averages & rankings"]
        D2["Subject performance"]
    end

    D --> E[/"📊 Reports & BI"/]:::out

    classDef src fill:#eee,stroke:#888,color:#222;
    classDef out fill:#dff5e1,stroke:#2e8b57,color:#222;
    style B fill:#f3e0cc,stroke:#cd7f32,stroke-width:2px,color:#222
    style C fill:#e8e8ee,stroke:#9a9aa5,stroke-width:2px,color:#222
    style D fill:#fff5cc,stroke:#d4af37,stroke-width:2px,color:#222
```

> ℹ️ **This repository script covers the Bronze layer only.** Silver and Gold are shown to give context; they are planned next steps (see [Roadmap](#-roadmap)).

---

## 🔄 ETL Pipeline

What happens inside the Bronze layer, step by step:

```mermaid
flowchart TD
    S1["1️⃣ Create schema & tables"] --> S2["2️⃣ Load raw data into<br/>Bronze.prelim_science_students_marks"]
    S2 --> S3["3️⃣ Prepare grade tables<br/>grade10 · grade11 · grade12"]
    S3 --> S4{{"4️⃣ THIS SCRIPT<br/>002_Insert_Broze_Tables.sql"}}

    S4 -->|"grade LIKE '%10%'"| G10[("Grade 10 table")]
    S4 -->|"grade LIKE '%11%'"| G11[("Grade 11 table")]
    S4 -->|"grade LIKE '%12%'"| G12[("Grade 12 table")]

    G10 --> V["✅ Row-count validation"]
    G11 --> V
    G12 --> V

    style S4 fill:#f3e0cc,stroke:#cd7f32,stroke-width:3px,color:#222
    style V fill:#dff5e1,stroke:#2e8b57,color:#222
```

> Steps 1–3 are inferred from the script's numbering ("4.") and its prerequisites.

---

## 🧭 Grade Routing

```mermaid
flowchart LR
    SRC[("Bronze.prelim_science_<br/>students_marks")] --> F{"Check<br/>grade column"}
    F -- "contains 10" --> T10["✅ grade10"]
    F -- "contains 11" --> T11["✅ grade11"]
    F -- "contains 12" --> T12["✅ grade12"]
    F -- "no match / NULL" --> X["⚠️ Not loaded"]
```

---

## 🧾 Columns Loaded

All three inserts use the same column list.

| # | Column | Description |
|:-:|--------|-------------|
| 1 | `student_id` | Unique identifier for the student |
| 2 | `student_name` | Student's name |
| 3 | `grade` | Grade label (e.g. 10, 11, 12) |
| 4 | `mathematics_mark` | Mathematics |
| 5 | `physical_science_mark` | Physical Science |
| 6 | `life_sciences_mark` | Life Sciences |
| 7 | `english_home_language_mark` | English Home Language |
| 8 | `life_orientation_mark` | Life Orientation |
| 9 | `information_technology_mark` | Information Technology |
| 10 | `agricultural_science_mark` | Agricultural Science |
| 11 | `total_mark` | Total of the student's marks |
| 12 | `average_mark` | Average of the student's marks |

> 💡 Columns are listed explicitly in both `INSERT` and `SELECT` (not `SELECT *`), so the load still works if the source column order changes.

---

## ✅ Prerequisites

- [ ] The `Bronze` schema exists
- [ ] `Bronze.prelim_science_students_marks` exists and is populated
- [ ] The three target tables exist with the columns above

---

## ▶️ How to Run

1. Confirm the prerequisites above.
2. Run `002_Insert_Broze_Tables.sql` against the target database.
3. Check row counts (see below).

---

## 🧪 Validation

Compare the source count with the three target counts:

```sql
SELECT COUNT(*) AS source_rows
FROM   Bronze.prelim_science_students_marks;

SELECT
    (SELECT COUNT(*) FROM Bronze.prelim_science_students_marks_grade10) AS grade10_rows,
    (SELECT COUNT(*) FROM Bronze.prelim_science_students_marks_grade11) AS grade11_rows,
    (SELECT COUNT(*) FROM Bronze.prelim_science_students_marks_grade12) AS grade12_rows;
```

If the totals don't match, some rows have a `grade` value that doesn't contain 10, 11 or 12, or is `NULL`.

---

## ⚠️ Notes and Caveats

| | Note |
|:-:|------|
| 🔁 | **Not idempotent.** The script only inserts; running it twice duplicates rows unless the targets are truncated first. |
| 🔤 | **Pattern matching.** `LIKE '%10%'` matches any value containing those digits (e.g. `110` would match). Use an exact match if `grade` data is not clean. |
| 🚫 | **Unmatched rows** (no 10/11/12 in `grade`) are not loaded anywhere. |
| 🧱 | **No cleaning.** This is a straight copy, in line with Bronze holding raw data. |

---

## 🗺️ Roadmap

- [x] Bronze: split raw marks by grade
- [ ] Add `TRUNCATE` (or a load-log) to make the load re-runnable
- [ ] Silver: validate marks (0–100), cast types, remove duplicates
- [ ] Gold: per-grade averages, subject rankings, pass rates
- [ ] Connect Gold to a BI dashboard