-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 24, 2026 at 04:53 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_course`
--

CREATE TABLE `tbl_course` (
  `ID` int NOT NULL PRIMARY KEY,
  `COURSE` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_course`
--

INSERT INTO `tbl_course` (`ID`, `COURSE`, `DESCRIPTION`) VALUES
(2, 'BSCPE', 'BACHELOR OF SCIENCE IN COMPUTER ENGINEERING'),
(3, 'BSTM', 'BACHELOR OF SCIENCE IN TOURISM MANAGEMENT'),
(4, 'BSPSYCH', 'BACHELOR OF SCIENCE IN PSYCHOLOGY'),
(5, 'BTVTED', 'BACHELOR OF TECHNICAL-VOCATIONAL TEACHER EDUCATION'),
(6, 'BSA', 'BACHELOR OF SCIENCE IN ACCOUNTANCY'),
(7, 'BSCRIM', 'BACHELOR OF SCIENCE IN CRIMINOLOGY'),
(8, 'BSENTREP', 'BACHELOR OF SCIENCE IN ENTREPRENEURSHIP'),
(9, 'BSIS', 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_schoolyear`
--

CREATE TABLE `tbl_schoolyear` (
  `ID` int NOT NULL PRIMARY KEY,
  `SCHOOLYEAR` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_schoolyear`
--

INSERT INTO `tbl_schoolyear` (`ID`, `SCHOOLYEAR`, `DESCRIPTION`) VALUES
(1, '2024-2025', 'AY 2024-2025'),
(2, '2025-2026', 'AY 2025-2026'),
(3, '2026-2027', 'AY 2026-2027');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_section`
--

CREATE TABLE `tbl_section` (
  `ID` int NOT NULL PRIMARY KEY,
  `SECTION` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_section`
--

INSERT INTO `tbl_section` (`ID`, `SECTION`, `DESCRIPTION`) VALUES
(1, 'A', 'SECTION A'),
(2, 'B', 'SECTION B'),
(3, 'C', 'SECTION C'),
(4, 'D', 'SECTION D'),
(5, 'E', 'SECTION E'),
(6, 'F', 'SECTION F'),
(7, 'G', 'SECTION G');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subject`
--

CREATE TABLE `tbl_subject` (
  `ID` int NOT NULL PRIMARY KEY,
  `COURSE` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `YEARLEVEL` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `TERM` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `SUBJECTTITLE` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `LECTURE` float NOT NULL,
  `LABORATORY` float NOT NULL,
  `CREDIT` float NOT NULL,
  `GRADE` float NOT NULL,
  `PRE-REQUISITE` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_subject`
--

INSERT INTO `tbl_subject` (`ID`, `COURSE`, `YEARLEVEL`, `TERM`, `CODE`, `SUBJECTTITLE`, `LECTURE`, `LABORATORY`, `CREDIT`, `GRADE`, `PRE-REQUISITE`) VALUES
(1, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'FIRST SEMESTER', 'CC101', 'INTRODUCTION TO COMPUTING', 3, 0, 3, 0, 'NONE'),
(2, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'FIRST SEMESTER', 'CC102', 'COMPUTER PROGRAMMING', 3, 0, 3, 0, 'NONE'),
(3, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'FIRST SEMESTER', 'GE1', 'UNDERSTANDING THE SELF', 3, 0, 3, 0, 'NONE'),
(4, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'FIRST SEMESTER', 'GE2', 'MATHEMATICS IN THE MODERN WORLD', 3, 0, 3, 0, 'NONE'),
(5, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'FIRST SEMESTER', 'MATH1', 'CALCULUS', 3, 0, 3, 0, 'NONE'),
(6, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'FIRST SEMESTER', 'PE1', 'PHYSICAL FITNESS AND GYMNASTICS', 2, 0, 2, 0, 'NONE'),
(7, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'FIRST SEMESTER', 'NSTP113', 'NATIONAL SERVICE TRAINING PROGRAM', 3, 0, 3, 0, 'NONE'),
(8, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'SECOND SEMESTER', 'IS101', 'FUNDAMENTALS OF INFORMATION SYSTEMS', 3, 0, 3, 0, 'NONE'),
(9, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'SECOND SEMESTER', 'CC103', 'COMPUTER PROGRAMMING 2', 2, 1, 3, 0, 'NONE'),
(10, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'SECOND SEMESTER', 'IDBM', 'INTRODUCTION TO DATABASE MANAGEMENT', 2, 1, 3, 0, 'NONE'),
(11, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'SECOND SEMESTER', 'GE3', 'READING IN THE PHILIPPINE HISTORY', 3, 2, 3, 0, 'NONE'),
(12, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'SECOND SEMESTER', 'GE4', 'PURPOSIVE COMMUNICATION', 3, 0, 3, 0, 'NONE'),
(13, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'SECOND SEMESTER', 'PE2', 'RYTHMIC ACTIVITIES', 2, 0, 2, 0, 'PE1'),
(14, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '1ST YEAR', 'SECOND SEMESTER', 'NSTP123', 'NATIONAL SERVICE TRAINING PROGRAM', 3, 0, 3, 0, 'NSTP1'),
(15, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'FIRST SEMESTER', 'CC104', 'DATA STRUCTURES AND ALGORITHM', 2, 1, 3, 0, 'CC103'),
(16, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'FIRST SEMESTER', 'DM101', 'ORGANIZATION AND MANAGEMENT CONCEPTS', 3, 0, 3, 0, 'NONE'),
(17, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'FIRST SEMESTER', 'DM102', 'FINANCIAL MANAGEMENT', 3, 0, 3, 0, 'NONE'),
(18, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'FIRST SEMESTER', 'GE5', 'THE CONTEMPORARY WORLD', 3, 0, 3, 0, 'NONE'),
(19, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'FIRST SEMESTER', 'GE6', 'ART APPRECIATION', 3, 0, 3, 0, 'NONE'),
(20, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'FIRST SEMESTER', 'GEELEC1', 'LIVING IN THE IT ERA', 3, 0, 3, 0, 'NONE'),
(21, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'FIRST SEMESTER', 'PE3', 'INDIVIDUAL / DUAL SPORTS / GAMES', 2, 0, 2, 0, 'NONE'),
(22, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'SECOND SEMESTER', 'CC105', 'INFORMATION MANAGEMENT 1', 3, 2, 3, 0, 'DM101'),
(23, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'SECOND SEMESTER', 'IS103', 'IT INFRASTRUCTURE AND NETWORK TECHNOLOGIES', 2, 1, 3, 0, 'NONE'),
(24, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'SECOND SEMESTER', 'IS105', 'ENTERPRISE ARCHITECTURE', 3, 0, 3, 0, 'NONE'),
(25, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'SECOND SEMESTER', 'MATH2', 'DISCRETE MATHEMATICS', 3, 2, 3, 0, 'MATH1'),
(26, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'SECOND SEMESTER', 'GE7', 'SCIENCE AND TECHNOLOGY', 3, 0, 3, 0, 'CC101'),
(27, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'SECOND SEMESTER', 'GEELEC2', 'ENVIRONMENTAL SCIENCE', 3, 0, 3, 0, 'NONE'),
(28, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '2ND YEAR', 'SECOND SEMESTER', 'PE4', 'TEAM SPORTS / GAMES', 2, 0, 2, 0, 'NONE'),
(29, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'FIRST SEMESTER', 'DM103', 'BUSINESS PROCESS MANAGEMENT', 3, 2, 3, 0, 'DM102'),
(30, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'FIRST SEMESTER', 'IS104', 'SYSTEM ANALYSIS AND DESIGN', 3, 2, 3, 0, 'IM1'),
(31, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'FIRST SEMESTER', 'QUAMET', 'QUANTITATIVE METHODS', 3, 2, 3, 0, 'MATH2'),
(32, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'FIRST SEMESTER', 'ADV01', 'IS ELECTIVE 1', 2, 1, 3, 0, '3RD YR. STANDING'),
(33, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'FIRST SEMESTER', 'CC106', 'APPLICATION DEVELOPMENT AND EMERGING TECHNOLOGIES', 2, 1, 3, 0, 'IS103'),
(34, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'FIRST SEMESTER', 'ADV06', 'IS PROFESSIONAL ELECTIVE', 3, 2, 3, 0, '3RD YR. STANDING'),
(35, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SECOND SEMESTER', 'CAP101', 'CAPSTONE PROJECT 1', 3, 0, 3, 0, 'QUAMET'),
(36, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SECOND SEMESTER', 'IS106', 'IS PROJECT MANAGEMENT 1', 3, 0, 3, 0, 'IS104'),
(37, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SECOND SEMESTER', 'ADV03', 'IS ELECTIVE 2', 3, 0, 3, 0, 'ADV01'),
(38, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SECOND SEMESTER', 'DM104', 'EVALUATION OF BUSINESS PERFORMANCE', 2, 1, 3, 0, 'DM103'),
(39, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SECOND SEMESTER', 'ADV08', 'IS PROFESSIONAL ELECTIVE 3', 3, 0, 3, 0, 'IDBM'),
(40, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SECOND SEMESTER', 'GE8', 'ETHICS', 3, 0, 3, 0, 'NONE'),
(41, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SECOND SEMESTER', 'ADV07', 'IS PROFESSIONAL ELECTIVE 2', 3, 0, 3, 0, '3RD YR. STANDING'),
(42, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SUMMER CLASS', 'IS107', 'IS STRATEGY MANAGEMENT AND ACQUISITION', 3, 0, 3, 0, 'ADV03'),
(43, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SUMMER CLASS', 'ADV04', 'IS ELECTIVE 3', 3, 0, 3, 0, 'ADV07'),
(44, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '3RD YEAR', 'SUMMER CLASS', 'IS102', 'PROFESSIONAL ISSUES IN INFORMATION SYSTEM', 3, 0, 3, 0, 'NONE'),
(45, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '4TH YEAR', 'FIRST SEMESTER', 'IS108', 'IS PROJECT MANAGEMENT 2', 3, 0, 3, 0, 'IS106'),
(46, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '4TH YEAR', 'FIRST SEMESTER', 'CAP102', 'CAPSTONE PROJECT 2', 0, 3, 3, 0, 'CAP101'),
(47, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '4TH YEAR', 'FIRST SEMESTER', 'ADV05', 'IS ELECTIVE 4', 3, 0, 3, 0, 'ADV03'),
(48, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '4TH YEAR', 'FIRST SEMESTER', 'ADV09', 'IS PROFESSIONAL ELECTIVE 4', 3, 0, 3, 0, 'ADV07'),
(49, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '4TH YEAR', 'FIRST SEMESTER', 'TECHNO', 'TECHNOPRENEURSHIP', 3, 0, 3, 0, '4TH YR. STANDING'),
(50, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '4TH YEAR', 'FIRST SEMESTER', 'RIZAL', 'LIFE, WORKS AND WRITINGS OF RIZAL', 3, 0, 3, 0, 'NONE'),
(51, 'BACHELOR OF SCIENCE IN INFORMATION SYSTEM', '4TH YEAR', 'SECOND SEMESTER', 'PRACT101', 'PRACTICUM', 0, 9, 9, 0, 'CAP102');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_term`
--

CREATE TABLE `tbl_term` (
  `ID` int NOT NULL PRIMARY KEY,
  `TERM` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_term`
--

INSERT INTO `tbl_term` (`ID`, `TERM`, `DESCRIPTION`) VALUES
(1, '1ST SEM', 'FIRST SEMESTER'),
(2, '2ND SEM', 'SECOND SEMESTER'),
(3, 'SUMMER', 'SUMMER CLASS'),
(4, 'TUTORIAL', 'TUTORIAL CLASS');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `ID` int NOT NULL PRIMARY KEY,
  `USERNAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `PASSWORD` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `FULLNAME` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tbl_usertype_id` int DEFAULT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`ID`, `USERNAME`, `PASSWORD`, `FULLNAME`, `tbl_usertype_id`, `date_created`) VALUES
(1, 'Tammy17', '$2y$10$pE9cdpC/O94SDZS9sS9zH.A6ccyswbmcOyvl/V..1qHf8W59AVtga', NULL, NULL, '2026-09-25 00:53:03'),
(2, 'ADMIN', '$2y$10$.i.p2/UIjMPtN0xRlosbxO2m3tJfjSz4DJVRrr/XFqqz1snOgeTCi', NULL, NULL, '2026-09-25 00:53:03');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_usertype`
--

CREATE TABLE `tbl_usertype` (
  `ID` int NOT NULL PRIMARY KEY,
  `Usertype` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_usertype`
--

INSERT INTO `tbl_usertype` (`ID`, `Usertype`) VALUES
(1, 'Admin'),
(2, 'Registrar'),
(3, 'Dean'),
(4, 'Instructor'),
(6, 'Student');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_yearlevel`
--

CREATE TABLE `tbl_yearlevel` (
  `ID` int NOT NULL PRIMARY KEY,
  `YEARLEVEL` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_yearlevel`
--

INSERT INTO `tbl_yearlevel` (`ID`, `YEARLEVEL`, `DESCRIPTION`) VALUES
(1, '1ST', 'FIRST YEAR'),
(2, '2ND', 'SECOND YEAR'),
(3, '3RD', 'THIRD YEAR'),
(4, '4TH', 'FOURTH YEAR');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL PRIMARY KEY,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `usertype_id` int NOT NULL,
  `date_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_course`
--


--
-- Indexes for table `tbl_schoolyear`
--


--
-- Indexes for table `tbl_section`
--


--
-- Indexes for table `tbl_subject`
--


--
-- Indexes for table `tbl_term`
--


--
-- Indexes for table `tbl_users`
--


--
-- Indexes for table `tbl_usertype`
--


--
-- Indexes for table `tbl_yearlevel`
--


--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `usertype_id` (`usertype_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_course`
--
ALTER TABLE `tbl_course`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_schoolyear`
--
ALTER TABLE `tbl_schoolyear`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_section`
--
ALTER TABLE `tbl_section`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_subject`
--
ALTER TABLE `tbl_subject`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `tbl_term`
--
ALTER TABLE `tbl_term`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_usertype`
--
ALTER TABLE `tbl_usertype`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_yearlevel`
--
ALTER TABLE `tbl_yearlevel`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- --------------------------------------------------------
-- Added for the Student Management System (student records table)
-- --------------------------------------------------------

CREATE TABLE `tbl_student` (
  `ID` int NOT NULL PRIMARY KEY,
  `STUDENT_NO` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `LASTNAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `FIRSTNAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `MIDDLENAME` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `GENDER` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `BIRTHDATE` date DEFAULT NULL,
  `ADDRESS` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CONTACT` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `EMAIL` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `COURSE_ID` int DEFAULT NULL,
  `YEARLEVEL_ID` int DEFAULT NULL,
  `SECTION_ID` int DEFAULT NULL,
  `SCHOOLYEAR_ID` int DEFAULT NULL,
  `STATUS` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Active',
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `tbl_student`
  ADD UNIQUE KEY `STUDENT_NO` (`STUDENT_NO`),
  ADD KEY `COURSE_ID` (`COURSE_ID`),
  ADD KEY `YEARLEVEL_ID` (`YEARLEVEL_ID`),
  ADD KEY `SECTION_ID` (`SECTION_ID`),
  ADD KEY `SCHOOLYEAR_ID` (`SCHOOLYEAR_ID`);

ALTER TABLE `tbl_student`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_student`
  ADD CONSTRAINT `fk_student_course` FOREIGN KEY (`COURSE_ID`) REFERENCES `tbl_course` (`ID`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_student_yearlevel` FOREIGN KEY (`YEARLEVEL_ID`) REFERENCES `tbl_yearlevel` (`ID`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_student_section` FOREIGN KEY (`SECTION_ID`) REFERENCES `tbl_section` (`ID`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_student_schoolyear` FOREIGN KEY (`SCHOOLYEAR_ID`) REFERENCES `tbl_schoolyear` (`ID`) ON DELETE SET NULL;

-- A few sample students so the dashboard/list isn't empty on first run
INSERT INTO `tbl_student`
  (`STUDENT_NO`, `LASTNAME`, `FIRSTNAME`, `MIDDLENAME`, `GENDER`, `BIRTHDATE`, `ADDRESS`, `CONTACT`, `EMAIL`,
   `COURSE_ID`, `YEARLEVEL_ID`, `SECTION_ID`, `SCHOOLYEAR_ID`, `STATUS`) VALUES
('2026-0001', 'DELA CRUZ', 'JUAN', 'SANTOS', 'Male', '2005-03-14', 'MANILA, PHILIPPINES', '09171234567', 'juan.delacruz@example.com', 9, 1, 1, 2, 'Active'),
('2026-0002', 'REYES', 'MARIA', 'LOPEZ', 'Female', '2004-11-02', 'QUEZON CITY, PHILIPPINES', '09181234567', 'maria.reyes@example.com', 2, 2, 2, 2, 'Active'),
('2026-0003', 'GARCIA', 'JOSE', 'RAMOS', 'Male', '2003-07-21', 'PASIG CITY, PHILIPPINES', '09191234567', 'jose.garcia@example.com', 6, 3, 1, 2, 'Active');

-- --------------------------------------------------------
-- Added for Users / User Type management
-- --------------------------------------------------------

-- Usernames must be unique for login to behave correctly
ALTER TABLE `tbl_users`
  ADD UNIQUE KEY `USERNAME` (`USERNAME`);

-- Give the two existing accounts a sensible user type
-- (they shipped with tbl_usertype_id = NULL in the original dump)
UPDATE `tbl_users` SET `tbl_usertype_id` = 1 WHERE `USERNAME` = 'ADMIN' AND `tbl_usertype_id` IS NULL;
UPDATE `tbl_users` SET `tbl_usertype_id` = 6 WHERE `USERNAME` = 'Tammy17' AND `tbl_usertype_id` IS NULL;

-- --------------------------------------------------------
-- Added in v4: Instructors
-- --------------------------------------------------------

CREATE TABLE `tbl_instructors` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SALUTATION` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `FIRSTNAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `MIDDLENAME` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `LASTNAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `PHOTO` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
