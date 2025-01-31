CREATE TABLE IF NOT EXISTS `daily_rewards` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL,
    `last_claimed_time` BIGINT NOT NULL,
    `current_day` INT NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
