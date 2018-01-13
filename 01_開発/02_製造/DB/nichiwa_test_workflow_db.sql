-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2017 年 12 朁E09 日 09:11
-- サーバのバージョン： 10.1.24-MariaDB
-- PHP Version: 7.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nichiwa_test_workflow_db`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `apply`
--

CREATE TABLE `apply` (
  `apply_id` int(32) NOT NULL COMMENT '連番',
  `user_id` int(32) DEFAULT NULL,
  `apply_date` date DEFAULT NULL COMMENT '申請日',
  `type` int(2) DEFAULT NULL COMMENT '1:代休 2:有給 他',
  `reasun` varchar(32) DEFAULT NULL COMMENT '事由',
  `check_control` tinyint(1) DEFAULT NULL COMMENT '現場調整済',
  `check_after` tinyint(1) DEFAULT NULL COMMENT '事後申請No',
  `check_manager` tinyint(1) DEFAULT NULL COMMENT '総務連絡済',
  `check_bossock` tinyint(1) DEFAULT NULL COMMENT '上長OK',
  `status` int(11) DEFAULT NULL COMMENT '状態（1:申請 2:決済等）',
  `_____date` date DEFAULT NULL COMMENT '承認日',
  `feedback_reason` varchar(32) CHARACTER SET latin1 DEFAULT NULL COMMENT '差戻理由'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `common`
--

CREATE TABLE `common` (
  `delete-flag` tinyint(1) DEFAULT NULL,
  `regist_date` date DEFAULT NULL,
  `update_date` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `holiday`
--

CREATE TABLE `holiday` (
  `holiday_id` int(32) NOT NULL COMMENT '連番',
  `apply_id` int(32) DEFAULT NULL,
  `date_date` date DEFAULT NULL COMMENT '休暇',
  `half_flag` tinyint(1) DEFAULT NULL COMMENT '半日or終日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `user`
--

CREATE TABLE `user` (
  `user_id` int(32) NOT NULL COMMENT '連番',
  `emp_num` varchar(32) NOT NULL COMMENT '社員番号',
  `name` varchar(32) DEFAULT NULL COMMENT '社員名',
  `passward` varchar(32) DEFAULT NULL COMMENT 'パスワード',
  `mail` varchar(100) DEFAULT NULL COMMENT 'メールアドレス',
  `post` varchar(64) DEFAULT NULL COMMENT '部署',
  `auth` int(2) DEFAULT NULL COMMENT '0:一般ユーザ 1:承認者(1) 2:承認者(2)  3:システム管理者'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `user`
--

INSERT INTO `user` (`user_id`, `emp_num`, `name`, `passward`, `mail`, `post`, `auth`) VALUES
(1, 'T00000', 'testuser', 'aaaa', 'testuser@nichiwa-system.co.jp', NULL, 0),
(2, 'T000001', 'syouninuser01', 'bbbb', '', NULL, 1),
(3, 'T0000002', 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほ', 'cccc', 'syouninsyay*_user02@nichiwa-system.co.jp', NULL, 2);

-- --------------------------------------------------------

--
-- テーブルの構造 `user_holiday`
--

CREATE TABLE `user_holiday` (
  `userholi_id` int(2) NOT NULL COMMENT '連番',
  `emp_num` int(32) NOT NULL COMMENT '社員ID',
  `paid_holidays` int(2) NOT NULL COMMENT '残有給休暇日数',
  `paid_holiday` date NOT NULL COMMENT '有給付与日',
  `delete_flg` tinyint(1) NOT NULL COMMENT '削除フラグ',
  `regist_date` date NOT NULL COMMENT '登録日',
  `update_date` date NOT NULL COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `workday`
--

CREATE TABLE `workday` (
  `workday_id` int(32) NOT NULL COMMENT '連番',
  `apply_id` int(32) DEFAULT NULL,
  `date_date` date DEFAULT NULL COMMENT '出勤日',
  `start_time` varchar(32) DEFAULT NULL COMMENT '開始時間',
  `end_time` varchar(32) DEFAULT NULL COMMENT '終了時間',
  `work_time` varchar(32) DEFAULT NULL COMMENT '稼働時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apply`
--
ALTER TABLE `apply`
  ADD PRIMARY KEY (`apply_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `holiday`
--
ALTER TABLE `holiday`
  ADD PRIMARY KEY (`holiday_id`),
  ADD KEY `apply_id` (`apply_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_holiday`
--
ALTER TABLE `user_holiday`
  ADD PRIMARY KEY (`userholi_id`),
  ADD KEY `emp_num` (`emp_num`);

--
-- Indexes for table `workday`
--
ALTER TABLE `workday`
  ADD PRIMARY KEY (`workday_id`),
  ADD KEY `apply_id` (`apply_id`);

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `apply`
--
ALTER TABLE `apply`
  ADD CONSTRAINT `apply_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- テーブルの制約 `holiday`
--
ALTER TABLE `holiday`
  ADD CONSTRAINT `holiday_ibfk_1` FOREIGN KEY (`apply_id`) REFERENCES `apply` (`apply_id`);

--
-- テーブルの制約 `user_holiday`
--
ALTER TABLE `user_holiday`
  ADD CONSTRAINT `user_holiday_ibfk_1` FOREIGN KEY (`emp_num`) REFERENCES `user` (`user_id`);

--
-- テーブルの制約 `workday`
--
ALTER TABLE `workday`
  ADD CONSTRAINT `workday_ibfk_1` FOREIGN KEY (`apply_id`) REFERENCES `apply` (`apply_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
