SET NAMES utf8mb4;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

USE students-management;

CREATE TABLE `course`(
    `course_id` INT NOT NULL AUTO_INCREMENT,
    `name` TEXT NOT NULL,
    `code` TEXT NOT NULL,
    `credit` INT NOT NULL,
    PRIMARY KEY (course_id)
);
CREATE TABLE `student`(
    `student_id` INT NOT NULL AUTO_INCREMENT,
    `code` TEXT NOT NULL,
    `name` TEXT NOT NULL,
    `birthday` TEXT NOT NULL,
    `gender` TEXT NOT NULL,
    `hometown` TEXT NOT NULL,
    `phone` TEXT NOT NULL,
    `group_id` INT NOT NULL,
    `major` TEXT NOT NULL,
    PRIMARY KEY (student_id)
);
CREATE TABLE `student_club`(
    `student_id` INT NOT NULL,
    `club_id` INT NOT NULL,
    `position` TEXT NOT NULL,
    PRIMARY KEY (student_id, club_id)
);
CREATE TABLE `teacher_class`(
    `class_id` INT NOT NULL,
    `teacher_id` INT NOT NULL,
    PRIMARY KEY (class_id, teacher_id)
);
CREATE TABLE `teacher`(
    `teacher_id` INT NOT NULL AUTO_INCREMENT,
    `email` TEXT NOT NULL,
    `name` TEXT NOT NULL,
    `faculty` TEXT NOT NULL,
    `level` TEXT NOT NULL,
    PRIMARY KEY (teacher_id)
);
CREATE TABLE `student_class`(
    `student_id` INT NOT NULL,
    `class_id` INT NOT NULL,
    `finish` TINYINT(1) NOT NULL,
    `grade` INT NOT NULL,
    PRIMARY KEY (student_id, class_id)
);
CREATE TABLE `class_group`(
    `group_id` INT NOT NULL AUTO_INCREMENT,
    `year_start` INT NOT NULL,
    `year_end` INT NOT NULL,
    `name` TEXT NOT NULL,
    PRIMARY KEY (group_id)
);
CREATE TABLE `club`(
    `club_id` INT NOT NULL AUTO_INCREMENT,
    `name` TEXT NOT NULL,
    `fanpage` TEXT NOT NULL,
    PRIMARY KEY (club_id)
);
CREATE TABLE `class`(
    `class_id` INT NOT NULL AUTO_INCREMENT,
    `course_id` INT NOT NULL,
    `semester` TEXT NOT NULL,
    `code` TEXT NOT NULL,
    `group` TEXT NOT NULL,
    `quantity` INT NOT NULL,
    `dayOfWeek` INT NOT NULL,
    `section` TEXT NOT NULL,
    `classroom` TEXT NOT NULL,
    PRIMARY KEY (class_id)
);
ALTER TABLE
    `student_class` ADD CONSTRAINT `student_class_studentid_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`student_id`);
ALTER TABLE
    `student` ADD CONSTRAINT `student_groupid_foreign` FOREIGN KEY(`group_id`) REFERENCES `group`(`group_id`);
ALTER TABLE
    `teacher_class` ADD CONSTRAINT `teacher_class_teacherid_foreign` FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`teacher_id`);
ALTER TABLE
    `student_club` ADD CONSTRAINT `student_club_studentid_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`student_id`);
ALTER TABLE
    `teacher_class` ADD CONSTRAINT `teacher_class_classid_foreign` FOREIGN KEY(`class_id`) REFERENCES `class_group`(`class_id`);
ALTER TABLE
    `student_club` ADD CONSTRAINT `student_club_clubid_foreign` FOREIGN KEY(`club_id`) REFERENCES `club`(`club_id`);
ALTER TABLE
    `class` ADD CONSTRAINT `class_courseid_foreign` FOREIGN KEY(`course_id`) REFERENCES `course`(`course_id`);
ALTER TABLE
    `student_class` ADD CONSTRAINT `student_class_classid_foreign` FOREIGN KEY(`class_id`) REFERENCES `class`(`class_id`);
