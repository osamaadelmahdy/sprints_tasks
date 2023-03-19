CREATE TABLE `BucketList`.`tbl_user` (
  `user_id` BIGINT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(200) NULL,
  `user_username` VARCHAR(200) NULL,
  `user_password` VARCHAR(200) NULL,
  UNIQUE KEY (`user_id`));
  