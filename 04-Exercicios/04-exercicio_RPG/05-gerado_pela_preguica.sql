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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`classe` (
  `id_classe` INT NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `descricao` VARCHAR(100) NULL,
  PRIMARY KEY (`id_classe`),
  UNIQUE INDEX `uq_nome_classe` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`personagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`personagem` (
  `id_personagem` INT NOT NULL,
  `nome` VARCHAR(12) NOT NULL,
  `id_usuario` INT NOT NULL,
  `genero` ENUM('f', 'm') NOT NULL,
  `nivel` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `experiencia` INT UNSIGNED NOT NULL DEFAULT 0,
  `id_classe` INT NOT NULL,
  PRIMARY KEY (`id_personagem`),
  UNIQUE INDEX `uq_nome_personagem` (`nome` ASC) VISIBLE,
  INDEX `fk_id_usuario` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_id_classe` (`id_classe` ASC) VISIBLE,
  CONSTRAINT `fk_id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `mydb`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_classe`
    FOREIGN KEY (`id_classe`)
    REFERENCES `mydb`.`classe` (`id_classe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`habilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`habilidade` (
  `id_habilidade` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id_habilidade`),
  UNIQUE INDEX `uq_nome_habilidade` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`classe_has_habilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`classe_has_habilidade` (
  `id_classe` INT NOT NULL,
  `id_habilidade` INT NOT NULL,
  PRIMARY KEY (`id_classe`, `id_habilidade`),
  INDEX `fk_habilidade` (`id_habilidade` ASC) VISIBLE,
  INDEX `fk_classe` (`id_classe` ASC) VISIBLE,
  CONSTRAINT `fk_id_habilidade`
    FOREIGN KEY (`id_classe`)
    REFERENCES `mydb`.`classe` (`id_classe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_classe_has_habilidade_habilidade1`
    FOREIGN KEY (`id_habilidade`)
    REFERENCES `mydb`.`habilidade` (`id_habilidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table2` (
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
