-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 26, 2024 at 09:21 PM
-- Server version: 8.0.40
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ladh2971`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`ladh2971`@`%` PROCEDURE `AddPlayer` (IN `playerNumber` INT, IN `teamID` INT, IN `firstName` VARCHAR(50), IN `lastName` VARCHAR(50), IN `dob` DATE, IN `positionID` INT)   BEGIN
	INSERT INTO Players (PlayerNumber, TeamID, FirstName, LastName, DOB, PositionID)
    VALUES (playerNumber, teamID, firstName, lastName, dob, positionID);
END$$

--
-- Functions
--
CREATE DEFINER=`ladh2971`@`%` FUNCTION `GetAveragePoints` (`playerID` INT) RETURNS DECIMAL(5,2) DETERMINISTIC BEGIN
	DECLARE avgPoints DECIMAL(5,2);
    
    SELECT AVG(Points) 
    INTO avgPoints
    FROM PlayerStats
    WHERE PlayerStats.PlayerID = playerID;
    
    RETURN avgPoints;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ArchivedGames`
--

CREATE TABLE `ArchivedGames` (
  `GameID` int NOT NULL DEFAULT '0',
  `GameDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ArenaID` int NOT NULL,
  `Team1ID` int NOT NULL,
  `Team2ID` int NOT NULL,
  `Team1Score` int NOT NULL,
  `Team2Score` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ArchivedGames`
--

INSERT INTO `ArchivedGames` (`GameID`, `GameDate`, `ArenaID`, `Team1ID`, `Team2ID`, `Team1Score`, `Team2Score`) VALUES
(3, '2023-04-12 19:30:00', 3, 3, 5, 126, 122),
(4, '2022-10-03 18:00:00', 4, 1, 4, 130, 129),
(5, '2022-09-02 18:30:00', 5, 5, 2, 97, 100);

-- --------------------------------------------------------

--
-- Table structure for table `Arenas`
--

CREATE TABLE `Arenas` (
  `ArenaID` int NOT NULL,
  `ArenaName` varchar(50) NOT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Capacity` int DEFAULT '10000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Arenas`
--

INSERT INTO `Arenas` (`ArenaID`, `ArenaName`, `City`, `Capacity`) VALUES
(1, 'Scotiabank Arena', 'Toronto', 19800),
(2, 'TD Garden', 'Boston', 19580),
(3, 'Crypto.com Arena', 'Los Angeles', 20000),
(4, 'Wells Fargo Center', 'Philadelphia', 21000),
(5, 'Keseya Center', 'Miami', 19600);

-- --------------------------------------------------------

--
-- Table structure for table `Games`
--

CREATE TABLE `Games` (
  `GameID` int NOT NULL,
  `GameDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ArenaID` int NOT NULL,
  `Team1ID` int NOT NULL,
  `Team2ID` int NOT NULL,
  `Team1Score` int NOT NULL,
  `Team2Score` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Games`
--

INSERT INTO `Games` (`GameID`, `GameDate`, `ArenaID`, `Team1ID`, `Team2ID`, `Team1Score`, `Team2Score`) VALUES
(1, '2024-11-01 19:00:00', 1, 1, 3, 120, 114),
(2, '2024-10-03 20:30:00', 2, 4, 2, 98, 110),
(3, '2023-04-12 19:30:00', 3, 3, 5, 126, 122),
(4, '2022-10-03 18:00:00', 4, 1, 4, 130, 129),
(5, '2022-09-02 18:30:00', 5, 5, 2, 97, 100);

-- --------------------------------------------------------

--
-- Stand-in structure for view `PlayerGameStats`
-- (See below for the actual view)
--
CREATE TABLE `PlayerGameStats` (
`Assists` decimal(5,2)
,`GameDate` datetime
,`PlayerID` int
,`PlayerName` varchar(51)
,`Points` decimal(5,2)
,`Rebounds` decimal(5,2)
,`Steals` decimal(5,2)
,`TeamName` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `Players`
--

CREATE TABLE `Players` (
  `PlayerID` int NOT NULL,
  `PlayerNumber` tinyint NOT NULL,
  `TeamID` int NOT NULL,
  `FirstName` varchar(25) DEFAULT NULL,
  `LastName` varchar(25) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `PositionID` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Players`
--

INSERT INTO `Players` (`PlayerID`, `PlayerNumber`, `TeamID`, `FirstName`, `LastName`, `DOB`, `PositionID`) VALUES
(1, 23, 3, 'LeBron', 'James', '1984-12-30', 3),
(2, 7, 4, 'Kyle', 'Lowry', '1986-03-25', 1),
(3, 0, 2, 'Jayson', 'Tatum', '1998-03-03', 4),
(4, 22, 5, 'Jimmy', 'Butler', '1989-09-14', 3),
(5, 4, 1, 'Scottie', 'Barnes', '2001-08-01', 3),
(6, 3, 3, 'Anthony', 'Davis', '1993-03-11', 4),
(7, 21, 4, 'Joel', 'Embiid', '1994-03-16', 5),
(8, 8, 2, 'Kristaps', 'Porzingis', '1995-08-02', 5),
(9, 14, 5, 'Tyler', 'Herro', '2000-01-20', 1),
(10, 1, 1, 'Gradey', 'Dick', '2003-11-20', 2);

-- --------------------------------------------------------

--
-- Table structure for table `PlayerStats`
--

CREATE TABLE `PlayerStats` (
  `PlayerID` int NOT NULL,
  `GameID` int NOT NULL,
  `Points` decimal(5,2) NOT NULL,
  `Rebounds` decimal(5,2) NOT NULL,
  `Assists` decimal(5,2) NOT NULL,
  `Steals` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `PlayerStats`
--

INSERT INTO `PlayerStats` (`PlayerID`, `GameID`, `Points`, `Rebounds`, `Assists`, `Steals`) VALUES
(1, 1, 25.00, 5.00, 5.00, 2.00),
(1, 4, 32.00, 12.00, 8.00, 2.00),
(2, 2, 23.00, 3.00, 2.00, 1.00),
(2, 4, 14.00, 3.00, 4.00, 0.00),
(3, 4, 32.00, 5.00, 2.00, 3.00),
(3, 5, 15.00, 8.00, 8.00, 2.00),
(4, 5, 28.00, 12.00, 10.00, 2.00),
(6, 1, 19.00, 8.00, 2.00, 1.00);

--
-- Triggers `PlayerStats`
--
DELIMITER $$
CREATE TRIGGER `CheckPlayerStats` BEFORE INSERT ON `PlayerStats` FOR EACH ROW BEGIN
	IF NEW.Points < 0 OR NEW.Rebounds < 0 OR NEW.Assists < 0 OR NEW.Steals < 0
    THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'points, rebounds, assists, and steals must be non-negative';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Positions`
--

CREATE TABLE `Positions` (
  `PositionID` tinyint NOT NULL,
  `PositionName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Positions`
--

INSERT INTO `Positions` (`PositionID`, `PositionName`) VALUES
(5, 'Center'),
(1, 'Point Guard'),
(4, 'Power Forward'),
(2, 'Shooting Guard'),
(3, 'Small Forward');

-- --------------------------------------------------------

--
-- Table structure for table `Teams`
--

CREATE TABLE `Teams` (
  `TeamID` int NOT NULL,
  `TeamName` varchar(50) NOT NULL,
  `City` varchar(50) DEFAULT NULL,
  `CoachName` varchar(50) DEFAULT 'TBD'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Teams`
--

INSERT INTO `Teams` (`TeamID`, `TeamName`, `City`, `CoachName`) VALUES
(1, 'Raptors', 'Toronto', 'Darko Rajaković'),
(2, 'Celtics', 'Boston', 'Joe Mazzulla'),
(3, 'Lakers', 'Los Angeles', 'JJ Redick'),
(4, '76ers', 'Philadelphia', 'Nick Nurse'),
(5, 'Heat', 'Miami', 'Erik Spoelstra');

-- --------------------------------------------------------

--
-- Structure for view `PlayerGameStats`
--
DROP TABLE IF EXISTS `PlayerGameStats`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ladh2971`@`%` SQL SECURITY DEFINER VIEW `PlayerGameStats`  AS SELECT `p`.`PlayerID` AS `PlayerID`, concat(`p`.`FirstName`,' ',`p`.`LastName`) AS `PlayerName`, `t`.`TeamName` AS `TeamName`, `g`.`GameDate` AS `GameDate`, `ps`.`Points` AS `Points`, `ps`.`Rebounds` AS `Rebounds`, `ps`.`Assists` AS `Assists`, `ps`.`Steals` AS `Steals` FROM (((`Players` `p` join `Teams` `t` on((`p`.`TeamID` = `t`.`TeamID`))) join `PlayerStats` `ps` on((`p`.`PlayerID` = `ps`.`PlayerID`))) join `Games` `g` on((`ps`.`GameID` = `g`.`GameID`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Arenas`
--
ALTER TABLE `Arenas`
  ADD PRIMARY KEY (`ArenaID`),
  ADD UNIQUE KEY `ArenaName` (`ArenaName`);

--
-- Indexes for table `Games`
--
ALTER TABLE `Games`
  ADD PRIMARY KEY (`GameID`),
  ADD KEY `fk_Game_Arena` (`ArenaID`),
  ADD KEY `fk_Game_Team1` (`Team1ID`),
  ADD KEY `fk_Game_Team2` (`Team2ID`);

--
-- Indexes for table `Players`
--
ALTER TABLE `Players`
  ADD PRIMARY KEY (`PlayerID`),
  ADD UNIQUE KEY `PlayerNumber` (`PlayerNumber`,`TeamID`),
  ADD KEY `fk_Player_Team` (`TeamID`),
  ADD KEY `fk_Player_Position` (`PositionID`);

--
-- Indexes for table `PlayerStats`
--
ALTER TABLE `PlayerStats`
  ADD PRIMARY KEY (`PlayerID`,`GameID`),
  ADD KEY `fk_Stats_Game` (`GameID`);

--
-- Indexes for table `Positions`
--
ALTER TABLE `Positions`
  ADD PRIMARY KEY (`PositionID`),
  ADD UNIQUE KEY `PositionName` (`PositionName`);

--
-- Indexes for table `Teams`
--
ALTER TABLE `Teams`
  ADD PRIMARY KEY (`TeamID`),
  ADD UNIQUE KEY `TeamName` (`TeamName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Arenas`
--
ALTER TABLE `Arenas`
  MODIFY `ArenaID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Games`
--
ALTER TABLE `Games`
  MODIFY `GameID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Players`
--
ALTER TABLE `Players`
  MODIFY `PlayerID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `Positions`
--
ALTER TABLE `Positions`
  MODIFY `PositionID` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Teams`
--
ALTER TABLE `Teams`
  MODIFY `TeamID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Games`
--
ALTER TABLE `Games`
  ADD CONSTRAINT `fk_Game_Arena` FOREIGN KEY (`ArenaID`) REFERENCES `Arenas` (`ArenaID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Game_Team1` FOREIGN KEY (`Team1ID`) REFERENCES `Teams` (`TeamID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Game_Team2` FOREIGN KEY (`Team2ID`) REFERENCES `Teams` (`TeamID`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `Players`
--
ALTER TABLE `Players`
  ADD CONSTRAINT `fk_Player_Position` FOREIGN KEY (`PositionID`) REFERENCES `Positions` (`PositionID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Player_Team` FOREIGN KEY (`TeamID`) REFERENCES `Teams` (`TeamID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `PlayerStats`
--
ALTER TABLE `PlayerStats`
  ADD CONSTRAINT `fk_Stats_Game` FOREIGN KEY (`GameID`) REFERENCES `Games` (`GameID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Stats_Player` FOREIGN KEY (`PlayerID`) REFERENCES `Players` (`PlayerID`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`ladh2971`@`%` EVENT `ArchiveOldGames` ON SCHEDULE EVERY 1 MONTH STARTS '2024-11-26 17:09:45' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    INSERT INTO ArchivedGames
    SELECT * FROM Games
    WHERE GameDate < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
