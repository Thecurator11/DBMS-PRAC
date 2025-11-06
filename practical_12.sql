create database vibhuti12;
use vibhuti12;

CREATE TABLE Doctor (
  Doctor_no INT PRIMARY KEY,
  Doctor_name VARCHAR(50),
  Address VARCHAR(50),
  City VARCHAR(50)
);
INSERT INTO Doctor VALUES
(1, 'Dr. Joshi', 'MG Road', 'Pune'),
(2, 'Dr. Mehta', 'FC Road', 'Mumbai'),
(3, 'Dr. Sharma', 'Main Street', 'Pune'),
(4, 'Dr. Patil', 'College Road', 'Nashik');

DELETE FROM Doc_Hosp;
DELETE FROM Hospital;

CREATE TABLE Hospital (
  Hospital_no INT PRIMARY KEY,
  Name VARCHAR(50),
  Street VARCHAR(50),
  City VARCHAR(50)
);
INSERT INTO Hospital VALUES
(101, 'Shree Clinic', 'JM Road', 'Pune'),
(102, 'City Hospital', 'Link Road', 'Mumbai'),
(103, 'Life Care', 'College Road', 'Nashik');

CREATE TABLE Doc_Hosp (
  Doctor_no INT,
  Hospital_no INT,
  Date DATE,
  FOREIGN KEY (Doctor_no) REFERENCES Doctor(Doctor_no),
  FOREIGN KEY (Hospital_no) REFERENCES Hospital(Hospital_no)
);

INSERT INTO Doc_Hosp VALUES
(1, 101, '2023-03-01'),
(2, 102, '2023-03-02'),
(3, 101, '2023-03-01'),
(4, 103, '2023-03-03'),
(1, 101, '2023-03-05');

SELECT D.Doctor_name, D.City, H.Name AS Hospital_Name
FROM Doctor D
JOIN Doc_Hosp DH ON D.Doctor_no = DH.Doctor_no
JOIN Hospital H ON DH.Hospital_no = H.Hospital_no;

SELECT D.Doctor_name, D.City, H.Name AS Hospital_Name
FROM Doctor D
JOIN Doc_Hosp DH ON D.Doctor_no = DH.Doctor_no
JOIN Hospital H ON DH.Hospital_no = H.Hospital_no
WHERE D.City = H.City;

SELECT H.Name AS Hospital_Name, DH.Date
FROM Doctor D
JOIN Doc_Hosp DH ON D.Doctor_no = DH.Doctor_no
JOIN Hospital H ON DH.Hospital_no = H.Hospital_no
WHERE D.Doctor_name = 'Dr. Joshi';

SELECT COUNT(*) AS Total_Doctors
FROM Doc_Hosp DH
JOIN Hospital H ON DH.Hospital_no = H.Hospital_no
WHERE H.Name = 'Shree Clinic' 
  AND DH.Date = '2023-03-01';
  
SELECT COUNT(*) AS Total_Visits
FROM Doctor D
JOIN Doc_Hosp DH ON D.Doctor_no = DH.Doctor_no
JOIN Hospital H ON DH.Hospital_no = H.Hospital_no
WHERE D.Doctor_name = 'Dr. Joshi' 
  AND H.Name = 'Shree Clinic';

