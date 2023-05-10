
-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_collegeInfo` (
  `collegeNumber` varchar(20)  NOT NULL COMMENT 'collegeNumber',
  `collegeName` varchar(20)  NOT NULL COMMENT '学院名称',
  `collegeBirthDate` varchar(20)  NULL COMMENT '成立日期',
  `collegeMan` varchar(10)  NULL COMMENT '院长姓名',
  `collegeTelephone` varchar(20)  NULL COMMENT '联系电话',
  `collegeMemo` varchar(100)  NULL COMMENT '附加信息',
  PRIMARY KEY (`collegeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_specialFieldInfo` (
  `specialFieldNumber` varchar(20)  NOT NULL COMMENT 'specialFieldNumber',
  `specialFieldName` varchar(20)  NOT NULL COMMENT '专业名称',
  `specialCollegeNumber` varchar(20)  NOT NULL COMMENT '所在学院',
  `specialBirthDate` varchar(20)  NULL COMMENT '成立日期',
  `specialMan` varchar(10)  NULL COMMENT '联系人',
  `specialTelephone` varchar(20)  NULL COMMENT '联系电话',
  `specialMemo` varchar(100)  NULL COMMENT '附加信息',
  PRIMARY KEY (`specialFieldNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_classInfo` (
  `classNumber` varchar(20)  NOT NULL COMMENT 'classNumber',
  `className` varchar(20)  NOT NULL COMMENT '班级名称',
  `classSpecialFieldNumber` varchar(20)  NOT NULL COMMENT '所属专业',
  `classBirthDate` varchar(20)  NULL COMMENT '成立日期',
  `classTeacherCharge` varchar(12)  NULL COMMENT '班主任',
  `classTelephone` varchar(20)  NULL COMMENT '联系电话',
  `classMemo` varchar(100)  NULL COMMENT '附加信息',
  PRIMARY KEY (`classNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_student` (
  `studentNumber` varchar(30)  NOT NULL COMMENT 'studentNumber',
  `studentName` varchar(12)  NOT NULL COMMENT '姓名',
  `studentPassword` varchar(30)  NOT NULL COMMENT '登录密码',
  `studentSex` varchar(2)  NOT NULL COMMENT '性别',
  `studentClassNumber` varchar(20)  NOT NULL COMMENT '所在班级',
  `studentBirthday` varchar(20)  NULL COMMENT '出生日期',
  `studentState` varchar(20)  NULL COMMENT '政治面貌',
  `studentPhoto` varchar(60)  NOT NULL COMMENT '学生照片',
  `studentTelephone` varchar(20)  NULL COMMENT '联系电话',
  `studentEmail` varchar(30)  NULL COMMENT '学生邮箱',
  `studentQQ` varchar(20)  NULL COMMENT '联系qq',
  `studentAddress` varchar(100)  NULL COMMENT '家庭地址',
  `studentMemo` varchar(100)  NULL COMMENT '附加信息',
  PRIMARY KEY (`studentNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_teacher` (
  `teacherNumber` varchar(20)  NOT NULL COMMENT 'teacherNumber',
  `teacherName` varchar(12)  NOT NULL COMMENT '教师姓名',
  `teacherPassword` varchar(30)  NULL COMMENT '登录密码',
  `teacherSex` varchar(2)  NOT NULL COMMENT '性别',
  `teacherBirthday` varchar(20)  NULL COMMENT '出生日期',
  `teacherArriveDate` varchar(20)  NULL COMMENT '入职日期',
  `teacherCardNumber` varchar(20)  NULL COMMENT '身份证号',
  `teacherPhone` varchar(20)  NULL COMMENT '联系电话',
  `teacherPhoto` varchar(60)  NOT NULL COMMENT '教师照片',
  `teacherAddress` varchar(100)  NULL COMMENT '家庭地址',
  `teacherMemo` varchar(100)  NULL COMMENT '附加信息',
  PRIMARY KEY (`teacherNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_courseInfo` (
  `courseNumber` varchar(20)  NOT NULL COMMENT 'courseNumber',
  `courseName` varchar(20)  NOT NULL COMMENT '课程名称',
  `courseTeacher` varchar(20)  NOT NULL COMMENT '上课老师',
  `courseTime` varchar(40)  NULL COMMENT '上课时间',
  `coursePlace` varchar(40)  NULL COMMENT '上课地点',
  `courseScore` float NOT NULL COMMENT '课程学分',
  `courseMemo` varchar(100)  NULL COMMENT '附加信息',
  PRIMARY KEY (`courseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_studentSelectCourseInfo` (
  `selectId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `studentNumber` varchar(30)  NOT NULL COMMENT '学生对象',
  `courseNumber` varchar(20)  NOT NULL COMMENT '课程对象',
  PRIMARY KEY (`selectId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_scoreInfo` (
  `scoreId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `studentNumber` varchar(30)  NOT NULL COMMENT '学生对象',
  `courseNumber` varchar(20)  NOT NULL COMMENT '课程对象',
  `scoreValue` float NOT NULL COMMENT '成绩得分',
  `studentEvaluate` varchar(30)  NULL COMMENT '学生评价',
  PRIMARY KEY (`scoreId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_news` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `newsTitle` varchar(50)  NOT NULL COMMENT '新闻标题',
  `newsContent` varchar(500)  NOT NULL COMMENT '新闻内容',
  `newsDate` varchar(20)  NULL COMMENT '发布日期',
  `newsPhoto` varchar(60)  NOT NULL COMMENT '新闻图片',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_specialFieldInfo ADD CONSTRAINT FOREIGN KEY (specialCollegeNumber) REFERENCES t_collegeInfo(collegeNumber);
ALTER TABLE t_classInfo ADD CONSTRAINT FOREIGN KEY (classSpecialFieldNumber) REFERENCES t_specialFieldInfo(specialFieldNumber);
ALTER TABLE t_student ADD CONSTRAINT FOREIGN KEY (studentClassNumber) REFERENCES t_classInfo(classNumber);
ALTER TABLE t_courseInfo ADD CONSTRAINT FOREIGN KEY (courseTeacher) REFERENCES t_teacher(teacherNumber);
ALTER TABLE t_studentSelectCourseInfo ADD CONSTRAINT FOREIGN KEY (studentNumber) REFERENCES t_student(studentNumber);
ALTER TABLE t_studentSelectCourseInfo ADD CONSTRAINT FOREIGN KEY (courseNumber) REFERENCES t_courseInfo(courseNumber);
ALTER TABLE t_scoreInfo ADD CONSTRAINT FOREIGN KEY (studentNumber) REFERENCES t_student(studentNumber);
ALTER TABLE t_scoreInfo ADD CONSTRAINT FOREIGN KEY (courseNumber) REFERENCES t_courseInfo(courseNumber);


