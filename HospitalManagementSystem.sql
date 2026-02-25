CREATE DATABASE HospitalManagement;
USE HospitalManagement;
 CREATE TABLE Patient (
      Patient_ID      INT PRIMARY KEY AUTO_INCREMENT,
      Patient_Name    VARCHAR(100) NOT NULL,
      Age             INT NOT NULL,
      Gender          VARCHAR(10) NOT NULL,
      Contact_Number  VARCHAR(15) NOT NULL );

CREATE TABLE Doctor (
      Doctor_ID       INT PRIMARY KEY AUTO_INCREMENT,
      Doctor_Name     VARCHAR(100) NOT NULL,
      Specialization  VARCHAR(100) NOT NULL,
      Experience      INT NOT NULL,
      Contact_Number  VARCHAR(15) NOT NULL );

 CREATE TABLE Appointment (
     Appointment_ID   INT PRIMARY KEY AUTO_INCREMENT,
     Patient_ID       INT NOT NULL,
     Doctor_ID        INT NOT NULL,
     Appointment_Date DATE NOT NULL,
     Status           VARCHAR(20) DEFAULT 'Scheduled',
     FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
     FOREIGN KEY (Doctor_ID)  REFERENCES Doctor(Doctor_ID));

CREATE TABLE Ward (
    Ward_ID       INT PRIMARY KEY AUTO_INCREMENT,
    Ward_Name     VARCHAR(50) NOT NULL,
    Ward_Type     VARCHAR(50) NOT NULL,
    Capacity      INT NOT NULL,
    Patient_ID    INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID));

CREATE TABLE Medicine (
    Medicine_ID     INT PRIMARY KEY AUTO_INCREMENT,
    Medicine_Name   VARCHAR(100) NOT NULL,
    Dosage          VARCHAR(50) NOT NULL,
    Price           DECIMAL(10,2) NOT NULL,
    Patient_ID      INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID));

 INSERT INTO Patient (Patient_Name, Age, Gender, Contact_Number) VALUES
     ('Rishabh Sharma',30, 'Male','9877867410'),
     ('Riya Mehta',28, 'Female', '9845456781'),
     ('Anvesh Jain',45, 'Male', '9012345678'),
     ('Shubhi Walia',30, 'Female','9765432109'),
     ('Mrigank Singh',52, 'Male','9654321098');

 INSERT INTO Doctor (Doctor_Name, Specialization, Experience, Contact_Number) VALUES
     ('Dr. Sandeep Jain','Cardiologist',15,'9899234567'),
     ('Dr. Rakesh Joshi','Dermatologist',10,'9222345678'),
     ('Dr. Sanjay Prakash','Neurologist',20,'9333456789'),
     ('Dr. Kavita Gupta','Pediatrician',8,'9444567890'),
     ('Dr. Saket Kumar','Orthopedic',12,'9555678901');

INSERT INTO Appointment (Patient_ID, Doctor_ID, Appointment_Date, Status) VALUES
     (1, 1, '2025-03-01', 'Scheduled'),
     (2, 2, '2025-03-02', 'Completed'),
     (3, 3, '2025-03-03', 'Scheduled'),
     (4, 4, '2025-03-04', 'Cancelled'),
     (5, 5, '2025-03-05', 'Scheduled');

INSERT INTO Ward (Ward_Name, Ward_Type, Capacity, Patient_ID) VALUES
     ('Ward A','General',20, 1),
     ('Ward B','ICU',5, 2),
     ('Ward C','Private',10, 3),
     ('Ward D','Pediatric',15, 4),
     ('Ward E','Surgical',8, 5);

 INSERT INTO Medicine (Medicine_Name, Dosage, Price, Patient_ID) VALUES
     ('Paracetamol', '500mg', 10.50, 1),
     ('Amoxicillin', '250mg', 25.00, 2),
     ('Metformin',   '500mg', 15.75, 3),
     ('Ibuprofen',   '400mg', 12.00, 4),
     ('Aspirin',     '150mg',  8.50, 5);


SELECT * FROM Patient;
+------------+----------------+-----+--------+----------------+
| Patient_ID | Patient_Name   | Age | Gender | Contact_Number |
+------------+----------------+-----+--------+----------------+
|          1 | Rishabh Sharma |  30 | Male   | 9877867410     |
|          2 | Riya Mehta     |  28 | Female | 9845456781     |
|          3 | Anvesh Jain    |  45 | Male   | 9012345678     |
|          4 | Shubhi Walia   |  30 | Female | 9765432109     |
|          5 | Mrigank Singh  |  52 | Male   | 9654321098     |
+------------+----------------+-----+--------+----------------+


 SELECT * FROM Doctor;
+-----------+--------------------+----------------+------------+----------------+
| Doctor_ID | Doctor_Name        | Specialization | Experience | Contact_Number |
+-----------+--------------------+----------------+------------+----------------+
|         1 | Dr. Sandeep Jain   | Cardiologist   |         15 | 9899234567     |
|         2 | Dr. Rakesh Joshi   | Dermatologist  |         10 | 9222345678     |
|         3 | Dr. Sanjay Prakash | Neurologist    |         20 | 9333456789     |
|         4 | Dr. Kavita Gupta   | Pediatrician   |          8 | 9444567890     |
|         5 | Dr. Saket Kumar    | Orthopedic     |         12 | 9555678901     |
+-----------+--------------------+----------------+------------+----------------+

SELECT
     A.Appointment_ID,
     P.Patient_Name,
     D.Doctor_Name,
     A.Appointment_Date,
     A.Status
     FROM Appointment A
     JOIN Patient P ON A.Patient_ID = P.Patient_ID
     JOIN Doctor  D ON A.Doctor_ID  = D.Doctor_ID;
+----------------+----------------+--------------------+------------------+-----------+
| Appointment_ID | Patient_Name   | Doctor_Name        | Appointment_Date | Status    |
+----------------+----------------+--------------------+------------------+-----------+
|              1 | Rishabh Sharma | Dr. Sandeep Jain   | 2025-03-01       | Scheduled |
|              2 | Riya Mehta     | Dr. Rakesh Joshi   | 2025-03-02       | Completed |
|              3 | Anvesh Jain    | Dr. Sanjay Prakash | 2025-03-03       | Scheduled |
|              4 | Shubhi Walia   | Dr. Kavita Gupta   | 2025-03-04       | Cancelled |
|              5 | Mrigank Singh  | Dr. Saket Kumar    | 2025-03-05       | Scheduled |
+----------------+----------------+--------------------+------------------+-----------+

SELECT W.Ward_Name, W.Ward_Type, W.Capacity, P.Patient_Name
     FROM Ward W
     JOIN Patient P ON W.Patient_ID = P.Patient_ID;
+-----------+-----------+----------+----------------+
| Ward_Name | Ward_Type | Capacity | Patient_Name   |
+-----------+-----------+----------+----------------+
| Ward A    | General   |       20 | Rishabh Sharma |
| Ward B    | ICU       |        5 | Riya Mehta     |
| Ward C    | Private   |       10 | Anvesh Jain    |
| Ward D    | Pediatric |       15 | Shubhi Walia   |
| Ward E    | Surgical  |        8 | Mrigank Singh  |
+-----------+-----------+----------+----------------+

SELECT M.Medicine_Name, M.Dosage, M.Price, P.Patient_Name
    FROM Medicine M
    JOIN Patient P ON M.Patient_ID = P.Patient_ID;
+---------------+--------+-------+----------------+
| Medicine_Name | Dosage | Price | Patient_Name   |
+---------------+--------+-------+----------------+
| Paracetamol   | 500mg  | 10.50 | Rishabh Sharma |
| Amoxicillin   | 250mg  | 25.00 | Riya Mehta     |
| Metformin     | 500mg  | 15.75 | Anvesh Jain    |
| Ibuprofen     | 400mg  | 12.00 | Shubhi Walia   |
| Aspirin       | 150mg  |  8.50 | Mrigank Singh  |
+---------------+--------+-------+----------------+