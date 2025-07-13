# 📘 Student Result Processing System

> A database-driven system built using **MySQL** to store, manage, and analyze student academic records, calculate GPA, and generate semester-wise reports and rankings.

---

## 📌 Table of Contents

- [Objective](#objective)  
- [Tools Used](#tools-used)  
- [Database Design](#database-design)  
- [Sample Data](#sample-data)  
- [GPA Calculation](#gpa-calculation)  
- [Pass/Fail Statistics](#passfail-statistics)  
- [Rank List Generation](#rank-list-generation)  
- [Report Exporting](#report-exporting)  
- [Optional Features](#optional-features)  
- [Conclusion](#conclusion)  
- [Future Enhancements](#future-enhancements)  

---

## 🎯 Objective

To develop a SQL-based backend system for educational institutions to process and manage student results effectively, including:

- Storing student marks and grades  
- Calculating GPA (Grade Point Average)  
- Generating rank lists  
- Exporting semester-wise summaries  

---

## 🧰 Tools Used

- **Database:** MySQL  
- **Data Entry:** SQL Scripts  
- **Analysis:** SQL Queries and Views  
- **Export:** MySQL Workbench or CLI (CSV Export)

---

## 🗂️ Database Design

### **Tables:**

1. **Students**
   - `student_id` (Primary Key)  
   - `name`  
   - `department`  
   - `batch_year`  

2. **Courses**
   - `course_id` (Primary Key)  
   - `course_name`  
   - `credits`  

3. **Semesters**
   - `semester_id` (Primary Key)  
   - `semester_name`  

4. **Grades**
   - `grade_id` (Auto-Increment Primary Key)  
   - `student_id` (Foreign Key)  
   - `course_id` (Foreign Key)  
   - `semester_id` (Foreign Key)  
   - `marks`  
   - `grade`  

---

## 🧪 Sample Data

- **100 students** across **4 departments** (`CSE`, `ECE`, `MECH`, `EEE`)  
- **5 courses** (with varying credit values)  
- **2 semesters**  
- **Randomly generated marks (40–100)**  
- **Grades assigned** using a scale:

| Marks Range | Grade | Points |
|-------------|--------|--------|
| 90–100      | A      | 10     |
| 80–89       | B      | 8      |
| 70–79       | C      | 6      |
| 60–69       | D      | 4      |
| < 60        | F      | 0      |

---

## 📈 GPA Calculation

### **SQL Logic:**

```sql
SELECT student_id, semester_id,
       ROUND(SUM(
         CASE grade
           WHEN 'A' THEN 10
           WHEN 'B' THEN 8
           WHEN 'C' THEN 6
           WHEN 'D' THEN 4
           ELSE 0
         END * credits) / SUM(credits), 2) AS GPA
FROM Grades
JOIN Courses USING(course_id)
GROUP BY student_id, semester_id;
```

---

## ✅ Pass/Fail Statistics

### **SQL Query:**

```sql
SELECT student_id,
       COUNT(*) AS total_courses,
       SUM(CASE WHEN grade = 'F' THEN 1 ELSE 0 END) AS failed_courses
FROM Grades
GROUP BY student_id;
```

---

## 🏆 Rank List Generation

### **SQL with Window Function:**

```sql
WITH GPA_Table AS (
  SELECT student_id, semester_id,
         ROUND(SUM(
           CASE grade
             WHEN 'A' THEN 10
             WHEN 'B' THEN 8
             WHEN 'C' THEN 6
             WHEN 'D' THEN 4
             ELSE 0
           END * credits) / SUM(credits), 2) AS GPA
  FROM Grades
  JOIN Courses USING(course_id)
  GROUP BY student_id, semester_id
)

SELECT *,
       RANK() OVER (PARTITION BY semester_id ORDER BY GPA DESC) AS rank
FROM GPA_Table;
```

---

## 📤 Report Exporting

```sql
SELECT S.name, Se.semester_name, C.course_name, G.marks, G.grade
FROM Grades G
JOIN Students S ON G.student_id = S.student_id
JOIN Courses C ON G.course_id = C.course_id
JOIN Semesters Se ON G.semester_id = Se.semester_id
ORDER BY S.student_id, G.semester_id;
```

> Export this data as a CSV via MySQL Workbench or CLI.

---

## ⚙️ Optional Features

### ✅ Triggers (Bonus)

```sql
CREATE TRIGGER warn_on_fail
AFTER INSERT ON Grades
FOR EACH ROW
BEGIN
  IF NEW.grade = 'F' THEN
    INSERT INTO Fail_Log (student_id, course_id, reason)
    VALUES (NEW.student_id, NEW.course_id, 'Course failed');
  END IF;
END;
```

---

## 📌 Conclusion

This system demonstrates the full lifecycle of result processing in an academic environment, from data entry to analysis. It’s scalable, extensible, and easy to integrate with a front-end or reporting engine.

---

## 🚀 Future Enhancements

- Web interface using PHP, Flask, or Django  
- Student login to view results  
- Attendance and internal assessments  
- Graphical dashboards using Power BI or Tableau  
