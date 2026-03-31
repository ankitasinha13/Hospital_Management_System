MariaDB [(none)]> CREATE DATABASE HospitalManagement;
Query OK, 1 row affected (0.002 sec)

MariaDB [(none)]> USE HospitalManagement;
Database changed
MariaDB [HospitalManagement]>  CREATE TABLE Patient (
    ->       Patient_ID      INT PRIMARY KEY AUTO_INCREMENT,
    ->       Patient_Name    VARCHAR(100) NOT NULL,
    ->       Age             INT NOT NULL,
    ->       Gender          VARCHAR(10) NOT NULL,
    ->       Contact_Number  VARCHAR(15) NOT NULL );
Query OK, 0 rows affected (0.014 sec)

MariaDB [HospitalManagement]> CREATE TABLE Doctor (
    ->       Doctor_ID       INT PRIMARY KEY AUTO_INCREMENT,
    ->       Doctor_Name     VARCHAR(100) NOT NULL,
    ->       Specialization  VARCHAR(100) NOT NULL,
    ->       Experience      INT NOT NULL,
    ->       Contact_Number  VARCHAR(15) NOT NULL );
Query OK, 0 rows affected (0.016 sec)

MariaDB [HospitalManagement]>  CREATE TABLE Appointment (
    ->      Appointment_ID   INT PRIMARY KEY AUTO_INCREMENT,
    ->      Patient_ID       INT NOT NULL,
    ->      Doctor_ID        INT NOT NULL,
    ->      Appointment_Date DATE NOT NULL,
    ->      Status           VARCHAR(20) DEFAULT 'Scheduled',
    ->      FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    ->      FOREIGN KEY (Doctor_ID)  REFERENCES Doctor(Doctor_ID));
Query OK, 0 rows affected (0.039 sec)

MariaDB [HospitalManagement]> CREATE TABLE Ward (
    ->     Ward_ID       INT PRIMARY KEY AUTO_INCREMENT,
    ->     Ward_Name     VARCHAR(50) NOT NULL,
    ->     Ward_Type     VARCHAR(50) NOT NULL,
    ->     Capacity      INT NOT NULL,
    ->     Patient_ID    INT,
    ->     FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID));
Query OK, 0 rows affected (0.042 sec)

MariaDB [HospitalManagement]> CREATE TABLE Medicine (
    ->     Medicine_ID     INT PRIMARY KEY AUTO_INCREMENT,
    ->     Medicine_Name   VARCHAR(100) NOT NULL,
    ->     Dosage          VARCHAR(50) NOT NULL,
    ->     Price           DECIMAL(10,2) NOT NULL,
    ->     Patient_ID      INT,
    ->     FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID));
Query OK, 0 rows affected (0.036 sec)

MariaDB [HospitalManagement]> INSERT INTO Patient (Patient_Name, Age, Gender, Contact_Number) VALUES
    ->      ('Rishabh Sharma',30, 'Male','9877867410'),
    ->      ('Riya Mehta',28, 'Female', '9845456781'),
    ->      ('Anvesh Jain',45, 'Male', '9012345678'),
    ->      ('Shubhi Walia',30, 'Female','9765432109'),
    ->      ('Mrigank Singh',52, 'Male','9654321098');
Query OK, 5 rows affected (0.051 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]>  INSERT INTO Doctor (Doctor_Name, Specialization, Experience, Contact_Number) VALUES
    ->      ('Dr. Sandeep Jain','Cardiologist',15,'9899234567'),
    ->      ('Dr. Rakesh Joshi','Dermatologist',10,'9222345678'),
    ->      ('Dr. Sanjay Prakash','Neurologist',20,'9333456789'),
    ->      ('Dr. Kavita Gupta','Pediatrician',8,'9444567890'),
    ->      ('Dr. Saket Kumar','Orthopedic',12,'9555678901');
Query OK, 5 rows affected (0.018 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]> INSERT INTO Appointment (Patient_ID, Doctor_ID, Appointment_Date, Status) VALUES
    ->      (1, 1, '2025-03-01', 'Scheduled'),
    ->      (2, 2, '2025-03-02', 'Completed'),
    ->      (3, 3, '2025-03-03', 'Scheduled'),
    ->      (4, 4, '2025-03-04', 'Cancelled'),
    ->      (5, 5, '2025-03-05', 'Scheduled');
Query OK, 5 rows affected (0.014 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]> INSERT INTO Ward (Ward_Name, Ward_Type, Capacity, Patient_ID) VALUES
    ->      ('Ward A','General',20, 1),
    ->      ('Ward B','ICU',5, 2),
    ->      ('Ward C','Private',10, 3),
    ->      ('Ward D','Pediatric',15, 4),
    ->      ('Ward E','Surgical',8, 5);
Query OK, 5 rows affected (0.004 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]>  INSERT INTO Medicine (Medicine_Name, Dosage, Price, Patient_ID) VALUES
    ->      ('Paracetamol', '500mg', 10.50, 1),
    ->      ('Amoxicillin', '250mg', 25.00, 2),
    ->      ('Metformin',   '500mg', 15.75, 3),
    ->      ('Ibuprofen',   '400mg', 12.00, 4),
    ->      ('Aspirin',     '150mg',  8.50, 5);
Query OK, 5 rows affected (0.008 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]> SELECT * FROM Patient;
+------------+----------------+-----+--------+----------------+
| Patient_ID | Patient_Name   | Age | Gender | Contact_Number |
+------------+----------------+-----+--------+----------------+
|          1 | Rishabh Sharma |  30 | Male   | 9877867410     |
|          2 | Riya Mehta     |  28 | Female | 9845456781     |
|          3 | Anvesh Jain    |  45 | Male   | 9012345678     |
|          4 | Shubhi Walia   |  30 | Female | 9765432109     |
|          5 | Mrigank Singh  |  52 | Male   | 9654321098     |
+------------+----------------+-----+--------+----------------+
5 rows in set (0.000 sec)

MariaDB [HospitalManagement]>  SELECT * FROM Doctor;
+-----------+--------------------+----------------+------------+----------------+
| Doctor_ID | Doctor_Name        | Specialization | Experience | Contact_Number |
+-----------+--------------------+----------------+------------+----------------+
|         1 | Dr. Sandeep Jain   | Cardiologist   |         15 | 9899234567     |
|         2 | Dr. Rakesh Joshi   | Dermatologist  |         10 | 9222345678     |
|         3 | Dr. Sanjay Prakash | Neurologist    |         20 | 9333456789     |
|         4 | Dr. Kavita Gupta   | Pediatrician   |          8 | 9444567890     |
|         5 | Dr. Saket Kumar    | Orthopedic     |         12 | 9555678901     |
+-----------+--------------------+----------------+------------+----------------+
5 rows in set (0.000 sec)

MariaDB [HospitalManagement]> SELECT
    ->      A.Appointment_ID,
    ->      P.Patient_Name,
    ->      D.Doctor_Name,
    ->      A.Appointment_Date,
    ->      A.Status
    ->      FROM Appointment A
    ->      JOIN Patient P ON A.Patient_ID = P.Patient_ID
    ->      JOIN Doctor  D ON A.Doctor_ID  = D.Doctor_ID;
+----------------+----------------+--------------------+------------------+-----------+
| Appointment_ID | Patient_Name   | Doctor_Name        | Appointment_Date | Status    |
+----------------+----------------+--------------------+------------------+-----------+
|              1 | Rishabh Sharma | Dr. Sandeep Jain   | 2025-03-01       | Scheduled |
|              2 | Riya Mehta     | Dr. Rakesh Joshi   | 2025-03-02       | Completed |
|              3 | Anvesh Jain    | Dr. Sanjay Prakash | 2025-03-03       | Scheduled |
|              4 | Shubhi Walia   | Dr. Kavita Gupta   | 2025-03-04       | Cancelled |
|              5 | Mrigank Singh  | Dr. Saket Kumar    | 2025-03-05       | Scheduled |
+----------------+----------------+--------------------+------------------+-----------+
5 rows in set (0.000 sec)

MariaDB [HospitalManagement]> SELECT W.Ward_Name, W.Ward_Type, W.Capacity, P.Patient_Name
    ->      FROM Ward W
    ->      JOIN Patient P ON W.Patient_ID = P.Patient_ID;
+-----------+-----------+----------+----------------+
| Ward_Name | Ward_Type | Capacity | Patient_Name   |
+-----------+-----------+----------+----------------+
| Ward A    | General   |       20 | Rishabh Sharma |
| Ward B    | ICU       |        5 | Riya Mehta     |
| Ward C    | Private   |       10 | Anvesh Jain    |
| Ward D    | Pediatric |       15 | Shubhi Walia   |
| Ward E    | Surgical  |        8 | Mrigank Singh  |
+-----------+-----------+----------+----------------+
5 rows in set (0.000 sec)

MariaDB [HospitalManagement]> SELECT M.Medicine_Name, M.Dosage, M.Price, P.Patient_Name
    ->     FROM Medicine M
    ->     JOIN Patient P ON M.Patient_ID = P.Patient_ID;
+---------------+--------+-------+----------------+
| Medicine_Name | Dosage | Price | Patient_Name   |
+---------------+--------+-------+----------------+
| Paracetamol   | 500mg  | 10.50 | Rishabh Sharma |
| Amoxicillin   | 250mg  | 25.00 | Riya Mehta     |
| Metformin     | 500mg  | 15.75 | Anvesh Jain    |
| Ibuprofen     | 400mg  | 12.00 | Shubhi Walia   |
| Aspirin       | 150mg  |  8.50 | Mrigank Singh  |
+---------------+--------+-------+----------------+
5 rows in set (0.001 sec)

MariaDB [HospitalManagement]> INSERT INTO Patient (Patient_Name, Age, Gender, Contact_Number) VALUES
    -> ('Aman Verma', 35, 'Male', '9123456789'),
    -> ('Neha Kapoor', 26, 'Female', '9234567890'),
    -> ('Karan Malhotra', 40, 'Male', '9345678901'),
    -> ('Simran Kaur', 29, 'Female', '9456789012'),
    -> ('Rahul Das', 33, 'Male', '9567890123');
Query OK, 5 rows affected (0.007 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]> SELECT * FROM PATIENT;
+------------+----------------+-----+--------+----------------+
| Patient_ID | Patient_Name   | Age | Gender | Contact_Number |
+------------+----------------+-----+--------+----------------+
|          1 | Rishabh Sharma |  30 | Male   | 9877867410     |
|          2 | Riya Mehta     |  28 | Female | 9845456781     |
|          3 | Anvesh Jain    |  45 | Male   | 9012345678     |
|          4 | Shubhi Walia   |  30 | Female | 9765432109     |
|          5 | Mrigank Singh  |  52 | Male   | 9654321098     |
|          6 | Aman Verma     |  35 | Male   | 9123456789     |
|          7 | Neha Kapoor    |  26 | Female | 9234567890     |
|          8 | Karan Malhotra |  40 | Male   | 9345678901     |
|          9 | Simran Kaur    |  29 | Female | 9456789012     |
|         10 | Rahul Das      |  33 | Male   | 9567890123     |
+------------+----------------+-----+--------+----------------+
10 rows in set (0.001 sec)

MariaDB [HospitalManagement]> INSERT INTO Doctor (Doctor_Name, Specialization, Experience, Contact_Number) VALUES
    -> ('Dr. Amit Verma','Cardiologist',18,'9666789012'),
    -> ('Dr. Neha Sharma','Dermatologist',7,'9777890123'),
    -> ('Dr. Rohit Mehta','Neurologist',14,'9888901234'),
    -> ('Dr. Pooja Singh','Pediatrician',9,'9999012345'),
    -> ('Dr. Anil Kapoor','Orthopedic',16,'9000123456');
Query OK, 5 rows affected (0.003 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]> SELECT * FROM DOCTOR;
+-----------+--------------------+----------------+------------+----------------+
| Doctor_ID | Doctor_Name        | Specialization | Experience | Contact_Number |
+-----------+--------------------+----------------+------------+----------------+
|         1 | Dr. Sandeep Jain   | Cardiologist   |         15 | 9899234567     |
|         2 | Dr. Rakesh Joshi   | Dermatologist  |         10 | 9222345678     |
|         3 | Dr. Sanjay Prakash | Neurologist    |         20 | 9333456789     |
|         4 | Dr. Kavita Gupta   | Pediatrician   |          8 | 9444567890     |
|         5 | Dr. Saket Kumar    | Orthopedic     |         12 | 9555678901     |
|         6 | Dr. Amit Verma     | Cardiologist   |         18 | 9666789012     |
|         7 | Dr. Neha Sharma    | Dermatologist  |          7 | 9777890123     |
|         8 | Dr. Rohit Mehta    | Neurologist    |         14 | 9888901234     |
|         9 | Dr. Pooja Singh    | Pediatrician   |          9 | 9999012345     |
|        10 | Dr. Anil Kapoor    | Orthopedic     |         16 | 9000123456     |
+-----------+--------------------+----------------+------------+----------------+
10 rows in set (0.000 sec)

MariaDB [HospitalManagement]> INSERT INTO Appointment (Patient_ID, Doctor_ID, Appointment_Date, Status) VALUES
    -> (1, 2, '2025-03-06', 'Scheduled'),
    -> (2, 3, '2025-03-07', 'Completed'),
    -> (3, 4, '2025-03-08', 'Scheduled'),
    -> (4, 5, '2025-03-09', 'Cancelled'),
    -> (5, 1, '2025-03-10', 'Scheduled');
Query OK, 5 rows affected (0.006 sec)
Records: 5  Duplicates: 0  Warnings: 0


MariaDB [HospitalManagement]> SELECT
    ->      A.Appointment_ID,
    ->      P.Patient_Name,
    ->      D.Doctor_Name,
    ->      A.Appointment_Date,
    ->      A.Status
    ->      FROM Appointment A
    ->      JOIN Patient P ON A.Patient_ID = P.Patient_ID
    ->      JOIN Doctor  D ON A.Doctor_ID  = D.Doctor_ID;
+----------------+----------------+--------------------+------------------+-----------+
| Appointment_ID | Patient_Name   | Doctor_Name        | Appointment_Date | Status    |
+----------------+----------------+--------------------+------------------+-----------+
|              1 | Rishabh Sharma | Dr. Sandeep Jain   | 2025-03-01       | Scheduled |
|              2 | Riya Mehta     | Dr. Rakesh Joshi   | 2025-03-02       | Completed |
|              3 | Anvesh Jain    | Dr. Sanjay Prakash | 2025-03-03       | Scheduled |
|              4 | Shubhi Walia   | Dr. Kavita Gupta   | 2025-03-04       | Cancelled |
|              5 | Mrigank Singh  | Dr. Saket Kumar    | 2025-03-05       | Scheduled |
|              6 | Rishabh Sharma | Dr. Rakesh Joshi   | 2025-03-06       | Scheduled |
|              7 | Riya Mehta     | Dr. Sanjay Prakash | 2025-03-07       | Completed |
|              8 | Anvesh Jain    | Dr. Kavita Gupta   | 2025-03-08       | Scheduled |
|              9 | Shubhi Walia   | Dr. Saket Kumar    | 2025-03-09       | Cancelled |
|             10 | Mrigank Singh  | Dr. Sandeep Jain   | 2025-03-10       | Scheduled |
+----------------+----------------+--------------------+------------------+-----------+
10 rows in set (0.000 sec)

MariaDB [HospitalManagement]> INSERT INTO Ward (Ward_Name, Ward_Type, Capacity, Patient_ID) VALUES
    -> ('Ward F','General',18, 1),
    -> ('Ward G','ICU',6, 2),
    -> ('Ward H','Private',12, 3),
    -> ('Ward I','Pediatric',14, 4),
    -> ('Ward J','Surgical',9, 5);
Query OK, 5 rows affected (0.007 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]> SELECT W.Ward_Name, W.Ward_Type, W.Capacity, P.Patient_Name
    ->      FROM Ward W
    ->      JOIN Patient P ON W.Patient_ID = P.Patient_ID;
+-----------+-----------+----------+----------------+
| Ward_Name | Ward_Type | Capacity | Patient_Name   |
+-----------+-----------+----------+----------------+
| Ward A    | General   |       20 | Rishabh Sharma |
| Ward B    | ICU       |        5 | Riya Mehta     |
| Ward C    | Private   |       10 | Anvesh Jain    |
| Ward D    | Pediatric |       15 | Shubhi Walia   |
| Ward E    | Surgical  |        8 | Mrigank Singh  |
| Ward F    | General   |       18 | Rishabh Sharma |
| Ward G    | ICU       |        6 | Riya Mehta     |
| Ward H    | Private   |       12 | Anvesh Jain    |
| Ward I    | Pediatric |       14 | Shubhi Walia   |
| Ward J    | Surgical  |        9 | Mrigank Singh  |
+-----------+-----------+----------+----------------+
10 rows in set (0.000 sec)

MariaDB [HospitalManagement]> INSERT INTO Medicine (Medicine_Name, Dosage, Price, Patient_ID) VALUES
    -> ('Cetrizine', '10mg', 5.50, 1),
    -> ('Azithromycin', '500mg', 30.00, 2),
    -> ('Pantoprazole', '40mg', 18.75, 3),
    -> ('Dolo 650', '650mg', 12.50, 4),
    -> ('Vitamin C', '500mg', 9.00, 5);
Query OK, 5 rows affected (0.007 sec)
Records: 5  Duplicates: 0  Warnings: 0

MariaDB [HospitalManagement]> SELECT M.Medicine_Name, M.Dosage, M.Price, P.Patient_Name
    ->     FROM Medicine M
    ->     JOIN Patient P ON M.Patient_ID = P.Patient_ID;
+---------------+--------+-------+----------------+
| Medicine_Name | Dosage | Price | Patient_Name   |
+---------------+--------+-------+----------------+
| Paracetamol   | 500mg  | 10.50 | Rishabh Sharma |
| Amoxicillin   | 250mg  | 25.00 | Riya Mehta     |
| Metformin     | 500mg  | 15.75 | Anvesh Jain    |
| Ibuprofen     | 400mg  | 12.00 | Shubhi Walia   |
| Aspirin       | 150mg  |  8.50 | Mrigank Singh  |
| Cetrizine     | 10mg   |  5.50 | Rishabh Sharma |
| Azithromycin  | 500mg  | 30.00 | Riya Mehta     |
| Pantoprazole  | 40mg   | 18.75 | Anvesh Jain    |
| Dolo 650      | 650mg  | 12.50 | Shubhi Walia   |
| Vitamin C     | 500mg  |  9.00 | Mrigank Singh  |
+---------------+--------+-------+----------------+
10 rows in set (0.000 sec)

MariaDB [HospitalManagement]>
