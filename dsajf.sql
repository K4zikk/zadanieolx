-- MySQL Script generated by MySQL Workbench
-- Wed Nov  9 14:03:06 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`for_sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`for_sale` (
  `id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `users_id`),
  INDEX `fk_for_sale_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_for_sale_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item` (
  `id` INT NOT NULL,
  `for_sale_id` INT NOT NULL,
  `for_sale_users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `for_sale_id`, `for_sale_users_id`),
  INDEX `fk_item_for_sale1_idx` (`for_sale_id` ASC, `for_sale_users_id` ASC),
  CONSTRAINT `fk_item_for_sale1`
    FOREIGN KEY (`for_sale_id` , `for_sale_users_id`)
    REFERENCES `mydb`.`for_sale` (`id` , `users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`following`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`following` (
  `id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `users_id`),
  INDEX `fk_following_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_following_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bought`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bought` (
  `id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `following_id` INT NOT NULL,
  `following_users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bought_users1_idx` (`users_id` ASC),
  INDEX `fk_bought_following1_idx` (`following_id` ASC, `following_users_id` ASC),
  CONSTRAINT `fk_bought_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bought_following1`
    FOREIGN KEY (`following_id` , `following_users_id`)
    REFERENCES `mydb`.`following` (`id` , `users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payment` (
  `id` INT NOT NULL,
  `bought_id` INT NOT NULL,
  PRIMARY KEY (`id`, `bought_id`),
  INDEX `fk_payment_bought1_idx` (`bought_id` ASC),
  CONSTRAINT `fk_payment_bought1`
    FOREIGN KEY (`bought_id`)
    REFERENCES `mydb`.`bought` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
