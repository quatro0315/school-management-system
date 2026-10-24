-- Run this ONLY if you already imported the v3 database and don't want to re-import.
USE student_db;

-- User types now match the roles: Admin, Registrar, Dean, Instructor, Student
UPDATE tbl_usertype SET Usertype = 'Dean'       WHERE ID = 3;
UPDATE tbl_usertype SET Usertype = 'Instructor' WHERE ID = 4;

CREATE TABLE IF NOT EXISTS `tbl_instructors` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SALUTATION` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `FIRSTNAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `MIDDLENAME` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `LASTNAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `PHOTO` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
